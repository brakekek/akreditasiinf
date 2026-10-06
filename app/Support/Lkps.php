<?php

namespace App\Support;

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Validation\Rule;

class Lkps
{
    /** Disk privat untuk lampiran bukti (storage/app/private); diakses lewat route pratinjau. */
    public const DISK = 'local';

    /** Kolom lampiran yang otomatis ada di setiap tabel LKPS. */
    public const LAMPIRAN = 'lampiran_bukti';

    /** Batas ukuran unggahan lampiran (KB): 20 MB. */
    public const MAKS_LAMPIRAN_KB = 20480;

    /** Batas unggah efektif dari php.ini (MB), untuk peringatan di form. */
    public static function batasServerMb(): float
    {
        $mb = function (string $v): float {
            $v = trim($v);
            $n = (float) $v;
            return match (strtolower(substr($v, -1))) {
                'g' => $n * 1024, 'k' => $n / 1024, 'm' => $n, default => $n / 1048576,
            };
        };

        return min($mb((string) ini_get('upload_max_filesize')), $mb((string) ini_get('post_max_size')));
    }

    public static function tabel(): array
    {
        return config('lkps.tabel', []);
    }

    public static function definisi(string $slug): array
    {
        $def = self::tabel()[$slug] ?? null;
        abort_if($def === null, 404, 'Tabel LKPS tidak ditemukan.');

        return $def;
    }

    public static function namaTabel(string $slug): string
    {
        return 'lkps_' . $slug;
    }

    /** Kolom yang sudah dinormalisasi: label, type, rules, options. */
    public static function kolom(string $slug): array
    {
        $hasil = [];
        foreach (self::definisi($slug)['kolom'] as $nama => $d) {
            $jalur = array_map('trim', explode('|', $d[0]));
            $hasil[$nama] = [
                'label'   => implode(' – ', $jalur),
                'jalur'   => $jalur,
                'type'    => $d[1] ?? 'text',
                'rules'   => $d[2] ?? 'nullable',
                'options' => $d[3] ?? [],
            ];
        }

        // Setiap baris data punya Lampiran Bukti (PDF/gambar) yang dibuka sebagai pratinjau.
        $hasil[self::LAMPIRAN] ??= [
            'label'   => 'Lampiran Bukti',
            'jalur'   => ['Lampiran Bukti'],
            'type'    => 'file',
            'rules'   => 'nullable',
            'options' => [],
        ];

        return $hasil;
    }

    /** Link pratinjau lampiran (bukan link unduh). */
    public static function urlLampiran(string $slug, int $id, string $kolom = self::LAMPIRAN): string
    {
        return route('lkps.lampiran.lihat', [$slug, $id, $kolom]);
    }

    public static function namaKelompok(string $slug): string
    {
        $kode = self::definisi($slug)['kelompok'] ?? '';

        return config("lkps.kelompok.$kode", $kode);
    }

    public static function rules(string $slug, bool $ubah = false): array
    {
        $hasil = [];
        foreach (self::kolom($slug) as $nama => $k) {
            $r = array_values(array_filter(explode('|', $k['rules'])));

            // Saat mengubah data, berkas lama tetap dipakai jika tidak diganti.
            if ($k['type'] === 'file' && $ubah) {
                $r = array_map(fn ($x) => $x === 'required' ? 'nullable' : $x, $r);
            }
            if (! in_array('required', $r, true) && ! in_array('nullable', $r, true)) {
                $r[] = 'nullable';
            }

            $tambahan = match ($k['type']) {
                'number'   => ['integer', 'min:0'],
                'decimal'  => ['numeric'],
                'date'     => ['date'],
                'url'      => ['string', 'max:500'],
                'check'    => ['boolean'],
                'file'     => ['file', 'max:' . self::MAKS_LAMPIRAN_KB, 'mimes:pdf,jpg,jpeg,png,webp'],
                'textarea' => ['string'],
                'select'   => [],
                default    => ['string', 'max:255'],
            };
            foreach ($tambahan as $t) {
                $kunci = explode(':', $t)[0];
                $ada = collect($r)->contains(fn ($x) => is_string($x) && explode(':', $x)[0] === $kunci);
                if (! $ada) {
                    $r[] = $t;
                }
            }
            if ($k['type'] === 'select' && $k['options']) {
                $r[] = Rule::in($k['options']);
            }

            $hasil[$nama] = $r;
        }

        return $hasil;
    }

    public static function label(string $slug): array
    {
        return array_map(fn ($k) => $k['label'], self::kolom($slug));
    }

    /**
     * Header tabel bertingkat seperti di Excel, dari label "Grup|Sub|Kolom".
     * Mengembalikan ['depth' => n, 'baris' => [[['label','colspan','rowspan'], ...], ...]].
     */
    public static function header(string $slug): array
    {
        $jalur = array_values(array_map(fn ($k) => $k['jalur'], self::kolom($slug)));
        $n = count($jalur);
        $depth = $n ? max(array_map('count', $jalur)) : 1;
        $baris = [];

        for ($l = 0; $l < $depth; $l++) {
            $row = [];
            $i = 0;
            while ($i < $n) {
                $p = $jalur[$i];
                if (count($p) <= $l) {
                    $i++;
                    continue;
                }
                if ($l === count($p) - 1) {
                    $row[] = ['label' => $p[$l], 'colspan' => 1, 'rowspan' => $depth - $l];
                    $i++;
                    continue;
                }
                $j = $i + 1;
                while ($j < $n && count($jalur[$j]) > $l + 1
                    && array_slice($jalur[$j], 0, $l + 1) === array_slice($p, 0, $l + 1)) {
                    $j++;
                }
                $row[] = ['label' => $p[$l], 'colspan' => $j - $i, 'rowspan' => 1];
                $i = $j;
            }
            $baris[] = $row;
        }

        return ['depth' => $depth, 'baris' => $baris];
    }

    /** Baris Jumlah / Rata-rata di bawah tabel, sesuai 'ringkasan' di config. */
    public static function ringkasan(string $slug, iterable $rows): array
    {
        $jenis = self::definisi($slug)['ringkasan'] ?? [];
        if (! $jenis) {
            return [];
        }
        $kolom = self::kolom($slug);
        $jumlah = [];
        $isi = [];
        foreach ($kolom as $n => $k) {
            if (in_array($k['type'], ['number', 'decimal', 'check'], true)) {
                $jumlah[$n] = 0;
                $isi[$n] = 0;
            }
        }
        foreach ($rows as $r) {
            foreach (array_keys($jumlah) as $n) {
                $v = $r->$n ?? null;
                if ($kolom[$n]['type'] === 'check') {
                    $jumlah[$n] += $v ? 1 : 0;
                } elseif ($v !== null && $v !== '') {
                    $jumlah[$n] += (float) $v;
                    $isi[$n]++;
                }
            }
        }

        $hasil = [];
        if (in_array('jumlah', $jenis, true)) {
            $hasil['Jumlah'] = $jumlah;
        }
        if (in_array('rata', $jenis, true)) {
            $rata = [];
            foreach ($jumlah as $n => $v) {
                $rata[$n] = $kolom[$n]['type'] !== 'check' && $isi[$n] ? $v / $isi[$n] : null;
            }
            $hasil['Rata-rata'] = $rata;
        }

        return $hasil;
    }

    /** Format angka gaya Indonesia, maksimal 2 desimal. */
    public static function angka(mixed $v): string
    {
        if ($v === null || $v === '' || ! is_numeric($v)) {
            return (string) $v;
        }
        $s = number_format((float) $v, 2, ',', '.');

        return str_ends_with($s, ',00') ? substr($s, 0, -3) : rtrim($s, '0');
    }

    /** Menu sidebar & dashboard: tabel dikelompokkan per kriteria. */
    public static function perKelompok(): array
    {
        $grup = [];
        foreach (config('lkps.kelompok', []) as $kode => $nama) {
            $grup[$kode] = ['nama' => $nama, 'tabel' => []];
        }
        foreach (self::tabel() as $slug => $def) {
            $kode = $def['kelompok'] ?? 'lainnya';
            $grup[$kode] ??= ['nama' => ucfirst($kode), 'tabel' => []];
            $grup[$kode]['tabel'][$slug] = $def['judul'];
        }

        return array_filter($grup, fn ($g) => ! empty($g['tabel']));
    }

    /** Buat tabel/kolom yang belum ada. Tidak pernah menghapus data. */
    public static function sinkron(): array
    {
        $log = [];
        foreach (self::tabel() as $slug => $def) {
            $nama = self::namaTabel($slug);
            $kolom = self::kolom($slug);

            if (! Schema::hasTable($nama)) {
                Schema::create($nama, function (Blueprint $t) use ($kolom) {
                    $t->id();
                    foreach ($kolom as $n => $k) {
                        self::buatKolom($t, $n, $k['type']);
                    }
                    $t->unsignedBigInteger('created_by')->nullable();
                    $t->timestamps();
                });
                $log[] = "Tabel {$nama} dibuat.";
                continue;
            }

            foreach ($kolom as $n => $k) {
                if (! Schema::hasColumn($nama, $n)) {
                    Schema::table($nama, fn (Blueprint $t) => self::buatKolom($t, $n, $k['type']));
                    $log[] = "Kolom {$nama}.{$n} ditambahkan.";
                }
            }
        }

        if (! Schema::hasTable('lkps_isian')) {
            Schema::create('lkps_isian', function (Blueprint $t) {
                $t->id();
                $t->string('kunci')->unique();
                $t->text('nilai')->nullable();
                $t->timestamps();
            });
            $log[] = 'Tabel lkps_isian dibuat.';
        }

        return $log ?: ['Semua tabel LKPS sudah sesuai konfigurasi.'];
    }

    private static function buatKolom(Blueprint $t, string $nama, string $type): void
    {
        $kolom = match ($type) {
            'textarea'    => $t->text($nama),
            'number'      => $t->integer($nama),
            'decimal'     => $t->decimal($nama, 15, 2),
            'check'       => $t->boolean($nama)->default(false),
            'date'        => $t->date($nama),
            'file', 'url' => $t->string($nama, 500),
            default       => $t->string($nama),
        };
        $kolom->nullable();
    }
}

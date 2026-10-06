<?php

namespace App\Support;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;

/** Jembatan antara database dan LkpsExcel. */
class LkpsData
{
    public static function template(): string
    {
        return storage_path('app/lkps/template.xlsx');
    }

    public static function excel(): LkpsExcel
    {
        return new LkpsExcel(config('lkps.tabel', []), config('lkps_excel', []), config('lkps.isian', []));
    }

    /** Isian di luar tabel: [kunci => nilai]. */
    public static function isian(): array
    {
        return Schema::hasTable('lkps_isian')
            ? DB::table('lkps_isian')->pluck('nilai', 'kunci')->all()
            : [];
    }

    public static function simpanIsian(array $nilai): void
    {
        $now = now();
        foreach ($nilai as $kunci => $v) {
            DB::table('lkps_isian')->updateOrInsert(
                ['kunci' => $kunci],
                ['nilai' => $v === '' ? null : $v, 'updated_at' => $now, 'created_at' => $now]
            );
        }
    }

    /** Seluruh isi 31 tabel: [slug => [ [kolom => nilai], ... ]]. */
    public static function semua(bool $linkLampiran = false): array
    {
        $data = [];
        foreach (array_keys(Lkps::tabel()) as $slug) {
            $nama = Lkps::namaTabel($slug);
            $rows = Schema::hasTable($nama)
                ? DB::table($nama)->orderBy('id')->get()->map(fn ($r) => (array) $r)->all()
                : [];

            // Untuk ekspor: path berkas diganti link pratinjau Lampiran Bukti
            // (ditulis ke kolom "Link Bukti" di template).
            if ($linkLampiran) {
                foreach ($rows as &$r) {
                    $r[Lkps::LAMPIRAN] = filled($r[Lkps::LAMPIRAN] ?? null)
                        ? Lkps::urlLampiran($slug, $r['id'])
                        : null;
                }
                unset($r);
            }
            $data[$slug] = $rows;
        }

        return $data;
    }

    /**
     * Simpan hasil impor. Mode ganti: isi lama sebuah tabel dihapus hanya bila
     * file impor berisi data untuk tabel tersebut. Mengembalikan [slug => jumlah baris].
     */
    public static function simpan(array $hasil, bool $tambah, ?int $userId): array
    {
        $ringkas = [];
        DB::transaction(function () use ($hasil, $tambah, $userId, &$ringkas) {
            $now = now();
            foreach ($hasil as $slug => $rows) {
                if (! $rows || ! isset(Lkps::tabel()[$slug])) {
                    continue;
                }
                $nama = Lkps::namaTabel($slug);
                if (! $tambah) {
                    $berkas = array_keys(array_filter(Lkps::kolom($slug), fn ($k) => $k['type'] === 'file'));
                    foreach ($berkas as $kolom) {
                        Storage::disk(Lkps::DISK)->delete(DB::table($nama)->whereNotNull($kolom)->pluck($kolom)->all());
                    }
                    DB::table($nama)->delete();
                }
                foreach (array_chunk($rows, 200) as $potong) {
                    DB::table($nama)->insert(array_map(
                        fn ($r) => $r + ['created_by' => $userId, 'created_at' => $now, 'updated_at' => $now],
                        $potong
                    ));
                }
                $ringkas[$slug] = count($rows);
            }
        });

        return $ringkas;
    }
}

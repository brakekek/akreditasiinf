<?php
namespace App\Support;
use App\Models\Dokumen;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class SumberDokumen {
    // Daftar dokumen yang bisa dipakai ulang (tanpa dokumen milik butir yang sedang dibuka)
    public static function daftar(int $kecualiIsi = 0): array {
        $out = [];
        if (class_exists(DataInduk::class)) {
            foreach (DataInduk::KATEGORI as $k => $judul) {
                foreach (DataInduk::semua($k) as $d) {
                    if (empty($d['file']) && empty($d['link'])) continue;
                    $out[] = ['kunci' => "di:$k:" . $d['id'], 'grup' => 'Data Induk - ' . $judul,
                              'nama' => $d['nama'], 'jenis' => !empty($d['file']) ? 'Berkas' : 'Link'];
                }
            }
        }
        $rows = Dokumen::with('isi.kriteria')->where('isi_kriteria_id', '!=', $kecualiIsi)->orderBy('nama')->get();
        foreach ($rows as $x) {
            if (!$x->isi || !$x->isi->kriteria) continue;
            $out[] = ['kunci' => 'dk:' . $x->id, 'grup' => 'Kriteria ' . $x->isi->kriteria->kode . ' - Butir ' . $x->isi->butir,
                      'nama' => $x->nama, 'jenis' => $x->file_path ? 'Berkas' : 'Link'];
        }
        return $out;
    }

    // Ambil data sumber dari kunci "di:<kategori>:<id>" atau "dk:<id dokumen>"
    public static function ambil(string $kunci): ?array {
        if (str_starts_with($kunci, 'di:') && class_exists(DataInduk::class)) {
            $p = explode(':', $kunci, 3);
            if (count($p) !== 3 || !isset(DataInduk::KATEGORI[$p[1]])) return null;
            $d = DataInduk::cari($p[1], $p[2]);
            return $d ? ['nama' => $d['nama'], 'file' => $d['file'] ?? null, 'link' => $d['link'] ?? null] : null;
        }
        if (str_starts_with($kunci, 'dk:')) {
            $x = Dokumen::find((int) substr($kunci, 3));
            return $x ? ['nama' => $x->nama, 'file' => $x->file_path, 'link' => $x->link] : null;
        }
        return null;
    }

    // Salin berkas fisik ke nama baru
    public static function salinFile(?string $path): ?string {
        if (!$path) return null;
        $disk = Storage::disk('public');
        if (!$disk->exists($path)) return null;
        $ext = pathinfo($path, PATHINFO_EXTENSION);
        $baru = 'dokumen-akreditasi/' . Str::uuid() . ($ext ? '.' . $ext : '');
        $disk->copy($path, $baru);
        return $baru;
    }
}

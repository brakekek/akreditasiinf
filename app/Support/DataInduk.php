<?php
namespace App\Support;

class DataInduk {
    const KATEGORI = [
        'standar-mutu' => 'Dokumen Standar Mutu',
        'universitas'  => 'Dokumen Universitas',
        'fakultas'     => 'Dokumen Fakultas',
        'stmik-sinus'  => 'Dokumen Tambahan',
    ];

    public static function judul(string $k): string {
        return self::KATEGORI[$k] ?? abort(404);
    }
    private static function path(string $k): string {
        return storage_path('app/data-induk/' . $k . '.json');
    }
    public static function semua(string $k): array {
        $p = self::path($k);
        if (!is_file($p)) return [];
        $d = json_decode((string) file_get_contents($p), true);
        return is_array($d) ? $d : [];
    }
    public static function cari(string $k, string $id): ?array {
        foreach (self::semua($k) as $x) if (($x['id'] ?? null) === $id) return $x;
        return null;
    }
    // Baca-ubah-tulis dengan kunci berkas agar dua pengguna tidak saling menimpa
    public static function ubah(string $k, callable $fn): void {
        $p = self::path($k);
        if (!is_dir(dirname($p))) mkdir(dirname($p), 0775, true);
        $f = fopen($p, 'c+');
        flock($f, LOCK_EX);
        $d = json_decode((string) stream_get_contents($f), true);
        $d = $fn(is_array($d) ? $d : []);
        ftruncate($f, 0);
        rewind($f);
        fwrite($f, json_encode(array_values($d), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
        fflush($f);
        flock($f, LOCK_UN);
        fclose($f);
    }

    // Format ukuran berkas tanpa ekstensi PHP intl (Number::fileSize Laravel membutuhkan intl)
    public static function ukuran($bytes): string {
        $b = (float) $bytes;
        $u = ['B', 'KB', 'MB', 'GB'];
        $i = 0;
        while ($b >= 1024 && $i < 3) { $b /= 1024; $i++; }
        return ($i === 0 ? (string) (int) $b : number_format($b, 1, ',', '.')) . ' ' . $u[$i];
    }
}

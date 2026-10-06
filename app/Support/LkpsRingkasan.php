<?php

namespace App\Support;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

/** Ringkasan kelengkapan LKPS untuk Dashboard Akreditasi dan halaman daftar LKPS. */
class LkpsRingkasan
{
    private static ?array $cache = null;

    /** Hapus hasil hitung yang tersimpan (dipakai setelah data berubah dalam proses yang sama). */
    public static function segarkan(): void
    {
        self::$cache = null;
    }

    /**
     * @return array{tersedia:bool,total:int,terisi:int,persen:int,kelompok:array}
     *  tersedia = tabel LKPS sudah dibuat (migration sudah dijalankan)
     */
    public static function data(): array
    {
        if (self::$cache !== null) {
            return self::$cache;
        }

        $tersedia = false;
        try {
            $tersedia = Schema::hasTable('lkps_isian');
        } catch (\Throwable $e) {
            $tersedia = false;
        }

        $kelompok = [];
        $total = 0;
        $terisi = 0;
        if ($tersedia) {
            foreach (Lkps::perKelompok() as $kode => $grup) {
                $items = [];
                foreach ($grup['tabel'] as $slug => $judul) {
                    $nama = Lkps::namaTabel($slug);
                    $n = Schema::hasTable($nama) ? DB::table($nama)->count() : 0;
                    $items[] = compact('slug', 'judul', 'n');
                    $total++;
                    $terisi += $n > 0 ? 1 : 0;
                }
                $kelompok[] = [
                    'kode'   => $kode,
                    'nama'   => $grup['nama'],
                    'items'  => $items,
                    'terisi' => count(array_filter($items, fn ($i) => $i['n'] > 0)),
                ];
            }
        }

        return self::$cache = [
            'tersedia' => $tersedia,
            'total'    => $total,
            'terisi'   => $terisi,
            'persen'   => $total ? (int) round($terisi / $total * 100) : 0,
            'kelompok' => $kelompok,
        ];
    }
}

<?php

use App\Support\Lkps;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

// Hanya MENAMBAH tabel lkps_* baru (dan kolom yang belum ada). Tabel lain tidak disentuh.
return new class extends Migration
{
    public function up(): void
    {
        Lkps::sinkron();
    }

    public function down(): void
    {
        // Pengaman: hanya tabel yang masih KOSONG yang dihapus; tabel berisi data dibiarkan.
        foreach (array_keys(Lkps::tabel()) as $slug) {
            $nama = Lkps::namaTabel($slug);
            if (Schema::hasTable($nama) && DB::table($nama)->count() === 0) {
                Schema::dropIfExists($nama);
            }
        }
        if (Schema::hasTable('lkps_isian') && DB::table('lkps_isian')->count() === 0) {
            Schema::dropIfExists('lkps_isian');
        }
    }
};

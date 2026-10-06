<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('kriterias', function (Blueprint $t) {
            $t->id();
            $t->string('kode', 20)->unique();
            $t->string('nama');
            $t->timestamps();
        });
        Schema::create('isi_kriteria', function (Blueprint $t) {
            $t->id();
            $t->foreignId('kriteria_id')->constrained('kriterias')->cascadeOnDelete();
            $t->string('butir', 50);
            $t->text('elemen_penilaian');
            $t->longText('narasi')->nullable();
            $t->unsignedTinyInteger('persentase')->default(0);
            $t->timestamps();
        });
        Schema::create('dokumen', function (Blueprint $t) {
            $t->id();
            $t->foreignId('isi_kriteria_id')->constrained('isi_kriteria')->cascadeOnDelete();
            $t->string('nama');
            $t->string('file_path')->nullable();
            $t->string('link')->nullable();
            $t->timestamps();
        });
    }
    public function down(): void {
        Schema::dropIfExists('dokumen');
        Schema::dropIfExists('isi_kriteria');
        Schema::dropIfExists('kriterias');
    }
};

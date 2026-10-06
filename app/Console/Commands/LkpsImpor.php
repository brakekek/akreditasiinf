<?php

namespace App\Console\Commands;

use App\Support\LkpsData;
use Illuminate\Console\Command;

class LkpsImpor extends Command
{
    protected $signature = 'lkps:impor {file : path workbook .xlsx} {--ganti : ganti isi tabel yang ada di file (bawaan: menambahkan)}';
    protected $description = 'Impor workbook LKPS (.xlsx) ke database. Bawaan: menambahkan, tidak menghapus data yang ada';

    public function handle(): int
    {
        if (! class_exists(\PhpOffice\PhpSpreadsheet\IOFactory::class)) {
            $this->error('PhpSpreadsheet belum terpasang. Jalankan: composer require phpoffice/phpspreadsheet');

            return self::FAILURE;
        }
        @ini_set('memory_limit', '1024M');
        $excel = LkpsData::excel();
        $hasil = $excel->impor($this->argument('file'));
        $ringkas = LkpsData::simpan($hasil, ! $this->option('ganti'), null);
        LkpsData::simpanIsian($excel->isian);
        foreach ($ringkas as $slug => $n) {
            $this->line(sprintf('%-30s %4d baris', $slug, $n));
        }
        foreach ($excel->catatan as $c) {
            $this->warn($c);
        }
        $this->info('Impor selesai: ' . array_sum($ringkas) . ' baris.');

        return self::SUCCESS;
    }
}

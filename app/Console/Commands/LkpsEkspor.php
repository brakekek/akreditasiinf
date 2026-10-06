<?php

namespace App\Console\Commands;

use App\Support\LkpsData;
use Illuminate\Console\Command;

class LkpsEkspor extends Command
{
    protected $signature = 'lkps:ekspor {tujuan=storage/app/lkps/LKPS_ekspor.xlsx : berkas hasil}';
    protected $description = 'Ekspor seluruh data LKPS ke template Excel';

    public function handle(): int
    {
        if (! class_exists(\PhpOffice\PhpSpreadsheet\IOFactory::class)) {
            $this->error('PhpSpreadsheet belum terpasang. Jalankan: composer require phpoffice/phpspreadsheet');

            return self::FAILURE;
        }
        @ini_set('memory_limit', '1024M');
        $template = LkpsData::template();
        if (! is_file($template)) {
            $this->error('Template belum ada di ' . $template);

            return self::FAILURE;
        }
        $excel = LkpsData::excel();
        $book = $excel->ekspor($template, LkpsData::semua(true), LkpsData::isian());
        @mkdir(dirname($this->argument('tujuan')), 0775, true);
        \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($book, 'Xlsx')->save($this->argument('tujuan'));
        foreach ($excel->catatan as $c) {
            $this->warn($c);
        }
        $this->info('Tersimpan: ' . $this->argument('tujuan'));

        return self::SUCCESS;
    }
}

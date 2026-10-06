<?php

namespace App\Console\Commands;

use App\Support\Lkps;
use Illuminate\Console\Command;

class LkpsSinkron extends Command
{
    protected $signature = 'lkps:sinkron';
    protected $description = 'Buat tabel/kolom LKPS baru sesuai config/lkps.php tanpa menghapus data';

    public function handle(): int
    {
        foreach (Lkps::sinkron() as $pesan) {
            $this->info($pesan);
        }

        return self::SUCCESS;
    }
}

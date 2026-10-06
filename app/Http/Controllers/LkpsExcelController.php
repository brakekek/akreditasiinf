<?php

namespace App\Http\Controllers;

use App\Support\Lkps;
use App\Support\LkpsData;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class LkpsExcelController extends Controller
{
    /** Pustaka PhpSpreadsheet opsional; tanpa itu halaman ini hanya menampilkan petunjuk pemasangan. */
    private function tersedia(): bool
    {
        return class_exists(\PhpOffice\PhpSpreadsheet\IOFactory::class);
    }

    private function tanpaPustaka()
    {
        return redirect()->route('lkps.excel.index')
            ->with('galat', 'Pustaka PhpSpreadsheet belum terpasang. Jalankan: composer require phpoffice/phpspreadsheet');
    }

    public function index()
    {
        $path = LkpsData::template();

        return view('lkps.excel', [
            'tersedia'      => $this->tersedia(),
            'adaTemplate'   => is_file($path),
            'waktuTemplate' => is_file($path) ? date('d-m-Y H:i', filemtime($path)) : null,
            'judul'         => array_map(fn ($d) => $d['judul'], Lkps::tabel()),
        ]);
    }

    public function ekspor()
    {
        if (! $this->tersedia()) {
            return $this->tanpaPustaka();
        }
        $path = LkpsData::template();
        if (! is_file($path)) {
            return redirect()->route('lkps.excel.index')->with('galat', 'Template Excel belum diunggah. Unggah template terlebih dahulu.');
        }
        $this->longgarkanBatas();

        $excel = LkpsData::excel();
        $book = $excel->ekspor($path, LkpsData::semua(true), LkpsData::isian());
        $tmp = tempnam(sys_get_temp_dir(), 'lkps') . '.xlsx';
        \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($book, 'Xlsx')->save($tmp);

        return response()->download($tmp, 'LKPS_LAM_Infokom_' . date('Ymd_His') . '.xlsx')->deleteFileAfterSend(true);
    }

    public function unggahTemplate(Request $request)
    {
        if (! $this->tersedia()) {
            return $this->tanpaPustaka();
        }
        $request->validate(['template' => ['required', 'file', 'max:20480', $this->harusXlsx()]], [], ['template' => 'template']);
        $this->longgarkanBatas();

        $file = $request->file('template');
        try {
            $sheets = \PhpOffice\PhpSpreadsheet\IOFactory::createReaderForFile($file->getRealPath())->listWorksheetNames($file->getRealPath());
        } catch (\Throwable) {
            return back()->with('galat', 'File tidak bisa dibaca sebagai workbook Excel.');
        }
        $hilang = array_diff(array_column(config('lkps_excel'), 'sheet'), $sheets);
        if ($hilang) {
            return back()->with('galat', 'Template belum sesuai. Sheet yang tidak ditemukan: ' . implode(', ', $hilang) . '.');
        }

        File::ensureDirectoryExists(dirname(LkpsData::template()));
        $file->move(dirname(LkpsData::template()), basename(LkpsData::template()));

        return back()->with('ok', 'Template disimpan. Ekspor berikutnya memakai template ini.');
    }

    public function impor(Request $request)
    {
        if (! $this->tersedia()) {
            return $this->tanpaPustaka();
        }
        $request->validate([
            'file' => ['required', 'file', 'max:20480', $this->harusXlsx()],
            'mode' => ['required', 'in:ganti,tambah'],
        ], [], ['file' => 'file Excel', 'mode' => 'cara impor']);
        $this->longgarkanBatas();

        $excel = LkpsData::excel();
        try {
            $hasil = $excel->impor($request->file('file')->getRealPath());
        } catch (\Throwable $e) {
            return back()->with('galat', 'File tidak bisa dibaca: ' . $e->getMessage());
        }

        $ringkas = LkpsData::simpan($hasil, $request->input('mode') === 'tambah', $request->user()->id);
        LkpsData::simpanIsian($excel->isian);
        $total = array_sum($ringkas);

        return redirect()->route('lkps.excel.index')
            ->with('ok', "Impor selesai: {$total} baris masuk ke " . count($ringkas) . ' tabel, '
                . count($excel->isian) . ' isian identitas/tambahan diperbarui.')
            ->with('ringkas', $ringkas)
            ->with('catatan', $excel->catatan);
    }

    private function harusXlsx(): \Closure
    {
        return function (string $attr, $file, \Closure $fail) {
            if (strtolower($file->getClientOriginalExtension()) !== 'xlsx') {
                $fail('File harus berformat .xlsx.');
            }
        };
    }

    private function longgarkanBatas(): void
    {
        @ini_set('memory_limit', '1024M');
        @set_time_limit(300);
    }
}

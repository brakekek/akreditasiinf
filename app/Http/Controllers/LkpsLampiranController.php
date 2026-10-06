<?php

namespace App\Http\Controllers;

use App\Support\Lkps;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

/** Pratinjau lampiran bukti: berkas dibuka di browser (inline), bukan diunduh. */
class LkpsLampiranController extends Controller
{
    public function lihat(string $tabel, int $id, string $kolom = 'lampiran_bukti')
    {
        [$row, $path] = $this->cari($tabel, $id, $kolom);
        $mime = Storage::disk(Lkps::DISK)->mimeType($path) ?: 'application/octet-stream';

        // Ringkasan baris: dua isian teks pertama, sebagai keterangan di halaman pratinjau.
        $ringkas = [];
        foreach (Lkps::kolom($tabel) as $n => $k) {
            if (in_array($k['type'], ['text', 'select'], true) && filled($row->$n ?? null)) {
                $ringkas[] = $row->$n;
            }
            if (count($ringkas) === 2) {
                break;
            }
        }

        return view('lkps.lampiran', [
            'tabel'   => $tabel,
            'def'     => Lkps::definisi($tabel),
            'label'   => Lkps::kolom($tabel)[$kolom]['label'],
            'ringkas' => implode(' – ', $ringkas),
            'mime'    => $mime,
            'src'     => route('lkps.lampiran.berkas', [$tabel, $id, $kolom]),
        ]);
    }

    public function berkas(string $tabel, int $id, string $kolom)
    {
        [, $path] = $this->cari($tabel, $id, $kolom);

        return response()->file(Storage::disk(Lkps::DISK)->path($path), [
            'Content-Disposition'    => 'inline; filename="' . basename($path) . '"',
            'X-Content-Type-Options' => 'nosniff',
            'Cache-Control'          => 'private, max-age=3600',
        ]);
    }

    private function cari(string $tabel, int $id, string $kolom): array
    {
        $kol = Lkps::kolom($tabel);
        abort_if(($kol[$kolom]['type'] ?? null) !== 'file', 404);

        $row = DB::table(Lkps::namaTabel($tabel))->where('id', $id)->first();
        $path = $row->$kolom ?? null;
        abort_if(! $path || ! Storage::disk(Lkps::DISK)->exists($path), 404, 'Lampiran tidak ditemukan.');

        return [$row, $path];
    }
}

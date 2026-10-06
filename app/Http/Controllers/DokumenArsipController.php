<?php
namespace App\Http\Controllers;
use App\Models\Dokumen;
use App\Support\SumberDokumen;
use Illuminate\Http\Request;

class DokumenArsipController extends Controller {
    public function store(Request $r) {
        $d = $r->validate([
            'isi_kriteria_id' => 'required|exists:isi_kriteria,id',
            'rujukan'         => 'required|string|max:200',
            'nama'            => 'required|max:255',
        ], ['rujukan.required' => 'Pilih salah satu dokumen yang sudah ada.']);

        $s = SumberDokumen::ambil($d['rujukan']);
        if (!$s) return back()->withInput()->withErrors(['rujukan' => 'Dokumen sumber tidak ditemukan atau sudah dihapus.']);

        $file = null;
        if (!empty($s['file'])) {
            $file = SumberDokumen::salinFile($s['file']);
            if (!$file && blank($s['link'] ?? null)) {
                return back()->withInput()->withErrors(['rujukan' => 'Berkas sumber tidak ditemukan di penyimpanan.']);
            }
        }
        Dokumen::create([
            'isi_kriteria_id' => $d['isi_kriteria_id'],
            'nama'            => $d['nama'],
            'file_path'       => $file,
            'link'            => $s['link'] ?? null,
        ]);
        return redirect()->route('isi.show', $d['isi_kriteria_id'])->with('ok', 'Dokumen ditambahkan dari dokumen yang sudah ada.');
    }
}

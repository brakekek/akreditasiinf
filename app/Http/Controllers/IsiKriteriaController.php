<?php
namespace App\Http\Controllers;
use App\Models\{IsiKriteria, Kriteria};
use Illuminate\Http\Request;

class IsiKriteriaController extends Controller {
    private array $rules = [
        'kriteria_id'      => 'required|exists:kriterias,id',
        'butir'            => 'required|max:50',
        'elemen_penilaian' => 'required',
        'narasi'           => 'nullable',
        'persentase'       => 'required|integer|min:0|max:100',
    ];
    // Validasi + bersihkan HTML narasi; narasi kosong disimpan NULL agar dihitung "belum terisi"
    private function data(Request $r): array {
        $d = $r->validate($this->rules);
        $html = clean($d['narasi'] ?? '', IsiKriteria::PURIFY);
        if (trim(strip_tags($html)) === '' && !preg_match('/<(img|table)/i', $html)) $html = null;
        $d['narasi'] = $html;
        return $d;
    }
    // Endpoint unggah gambar untuk editor narasi (TinyMCE)
    public function unggahGambar(Request $r) {
        $r->validate(['file' => 'required|image|mimes:jpg,jpeg,png,gif,webp|max:4096']);
        $path = $r->file('file')->store('narasi-gambar', 'public');
        return response()->json(['location' => '/storage/'.$path]);
    }
    public function create(Request $r) {
        $isi = new IsiKriteria(['kriteria_id' => $r->query('kriteria_id'), 'persentase' => 0]);
        return view('isi.form', ['isi' => $isi, 'kriterias' => Kriteria::orderBy('kode')->get()]);
    }
    public function store(Request $r) {
        $isi = IsiKriteria::create($this->data($r));
        return redirect()->route('kriteria.show', $isi->kriteria_id)->with('ok', 'Isi kriteria ditambahkan.');
    }
    public function show(IsiKriteria $isi) {
        $isi->load('kriteria', 'dokumen');
        return view('isi.show', compact('isi'));
    }
    public function edit(IsiKriteria $isi) {
        return view('isi.form', ['isi' => $isi, 'kriterias' => Kriteria::orderBy('kode')->get()]);
    }
    public function update(Request $r, IsiKriteria $isi) {
        $isi->update($this->data($r));
        return redirect()->route('isi.show', $isi)->with('ok', 'Isi kriteria diperbarui.');
    }
    public function destroy(IsiKriteria $isi) {
        $isi->load('dokumen');
        foreach ($isi->dokumen as $d) app(DokumenController::class)->hapusFile($d);
        $kid = $isi->kriteria_id;
        $isi->delete();
        return redirect()->route('kriteria.show', $kid)->with('ok', 'Isi kriteria dihapus.');
    }
}

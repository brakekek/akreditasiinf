<?php
namespace App\Http\Controllers;
use App\Models\Kriteria;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class KriteriaController extends Controller {
    private function rules(?Kriteria $k = null): array {
        return [
            'kode' => ['required', 'max:20', Rule::unique('kriterias', 'kode')->ignore($k)],
            'nama' => 'required|max:255',
        ];
    }
    public function index() {
        return view('kriteria.index', ['items' => Kriteria::with('isi')->orderBy('kode')->paginate(15)]);
    }
    public function create() { return view('kriteria.form', ['kriteria' => new Kriteria]); }
    public function store(Request $r) {
        Kriteria::create($r->validate($this->rules()));
        return redirect()->route('kriteria.index')->with('ok', 'Kriteria ditambahkan.');
    }
    public function show(Kriteria $kriteria) {
        $kriteria->load('isi.dokumen');
        return view('kriteria.show', compact('kriteria'));
    }
    public function edit(Kriteria $kriteria) { return view('kriteria.form', compact('kriteria')); }
    public function update(Request $r, Kriteria $kriteria) {
        $kriteria->update($r->validate($this->rules($kriteria)));
        return redirect()->route('kriteria.index')->with('ok', 'Kriteria diperbarui.');
    }
    public function destroy(Kriteria $kriteria) {
        $kriteria->load('isi.dokumen');
        foreach ($kriteria->isi as $i) foreach ($i->dokumen as $d) app(DokumenController::class)->hapusFile($d);
        $kriteria->delete();
        return redirect()->route('kriteria.index')->with('ok', 'Kriteria dihapus.');
    }
}

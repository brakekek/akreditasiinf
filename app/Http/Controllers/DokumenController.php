<?php
namespace App\Http\Controllers;
use App\Models\{Dokumen, IsiKriteria};
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class DokumenController extends Controller {
    private function rules(): array {
        return [
            'isi_kriteria_id' => 'required|exists:isi_kriteria,id',
            'nama'            => 'required|max:255',
            'file'            => 'nullable|file|max:20480|mimes:pdf,doc,docx,xls,xlsx,ppt,pptx,zip,jpg,png',
            'link'            => 'nullable|url|max:500',
        ];
    }
    public function hapusFile(Dokumen $d): void {
        if ($d->file_path) Storage::disk('public')->delete($d->file_path);
    }
    public function create(Request $r) {
        $dokumen = new Dokumen(['isi_kriteria_id' => $r->query('isi_id')]);
        return view('dokumen.form', ['dokumen' => $dokumen, 'isi' => IsiKriteria::with('kriteria')->findOrFail($r->query('isi_id'))]);
    }
    public function store(Request $r) {
        $data = $r->validate($this->rules());
        if (!$r->hasFile('file') && blank($data['link'] ?? null)) {
            return back()->withInput()->withErrors(['file' => 'Unggah berkas atau isi link dokumen.']);
        }
        if ($r->hasFile('file')) $data['file_path'] = $r->file('file')->store('dokumen-akreditasi', 'public');
        unset($data['file']);
        $d = Dokumen::create($data);
        return redirect()->route('isi.show', $d->isi_kriteria_id)->with('ok', 'Dokumen ditambahkan.');
    }
    public function edit(Dokumen $dokumen) {
        return view('dokumen.form', ['dokumen' => $dokumen, 'isi' => $dokumen->isi->load('kriteria')]);
    }
    public function update(Request $r, Dokumen $dokumen) {
        $data = $r->validate($this->rules());
        if ($r->hasFile('file')) {
            $this->hapusFile($dokumen);
            $data['file_path'] = $r->file('file')->store('dokumen-akreditasi', 'public');
        }
        unset($data['file']);
        if (blank($data['file_path'] ?? $dokumen->file_path) && blank($data['link'] ?? null)) {
            return back()->withInput()->withErrors(['file' => 'Dokumen harus berupa berkas atau link.']);
        }
        $dokumen->update($data);
        return redirect()->route('isi.show', $dokumen->isi_kriteria_id)->with('ok', 'Dokumen diperbarui.');
    }
    public function destroy(Dokumen $dokumen) {
        $this->hapusFile($dokumen);
        $id = $dokumen->isi_kriteria_id;
        $dokumen->delete();
        return redirect()->route('isi.show', $id)->with('ok', 'Dokumen dihapus.');
    }
}

<?php
namespace App\Http\Controllers;
use App\Support\DataInduk;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class DataIndukController extends Controller {
    private function rules(): array {
        return [
            'nama'       => 'required|max:255',
            'keterangan' => 'nullable|max:1000',
            'file'       => 'nullable|file|max:20480|mimes:pdf,doc,docx,xls,xlsx,ppt,pptx,zip,jpg,png',
            'link'       => 'nullable|url:http,https|max:500',
        ];
    }
    private function simpanFile(Request $r, string $kategori): ?array {
        if (!$r->hasFile('file')) return null;
        $f = $r->file('file');
        return [
            'file'      => $f->store('data-induk/' . $kategori, 'public'),
            'nama_file' => $f->getClientOriginalName(),
            'ukuran'    => $f->getSize(),
        ];
    }

    public function index(Request $r, string $kategori) {
        $judul = DataInduk::judul($kategori);
        $q = trim((string) $r->query('q', ''));
        $items = collect(DataInduk::semua($kategori))->sortByDesc('diubah')->values();
        if ($q !== '') {
            $items = $items->filter(fn ($d) => Str::contains(Str::lower($d['nama'] . ' ' . ($d['keterangan'] ?? '')), Str::lower($q)))->values();
        }
        return view('datainduk.index', compact('kategori', 'judul', 'items', 'q'));
    }

    public function create(string $kategori) {
        return view('datainduk.form', ['kategori' => $kategori, 'judul' => DataInduk::judul($kategori), 'dok' => null]);
    }

    public function store(Request $r, string $kategori) {
        DataInduk::judul($kategori);
        $data = $r->validate($this->rules());
        if (!$r->hasFile('file') && blank($data['link'] ?? null)) {
            return back()->withInput()->withErrors(['file' => 'Unggah berkas atau isi link dokumen.']);
        }
        $rec = [
            'id' => (string) Str::uuid(), 'nama' => $data['nama'], 'keterangan' => $data['keterangan'] ?? null,
            'file' => null, 'nama_file' => null, 'ukuran' => null, 'link' => $data['link'] ?? null,
            'dibuat' => now()->toDateTimeString(), 'diubah' => now()->toDateTimeString(),
        ];
        $rec = array_merge($rec, $this->simpanFile($r, $kategori) ?? []);
        DataInduk::ubah($kategori, function ($d) use ($rec) { $d[] = $rec; return $d; });
        return redirect()->route('datainduk.index', $kategori)->with('ok', 'Dokumen ditambahkan.');
    }

    public function edit(string $kategori, string $id) {
        $dok = DataInduk::cari($kategori, $id) ?? abort(404);
        return view('datainduk.form', ['kategori' => $kategori, 'judul' => DataInduk::judul($kategori), 'dok' => $dok]);
    }

    public function update(Request $r, string $kategori, string $id) {
        DataInduk::judul($kategori);
        $ada = DataInduk::cari($kategori, $id) ?? abort(404);
        $data = $r->validate($this->rules());
        if (!$r->hasFile('file') && empty($ada['file']) && blank($data['link'] ?? null)) {
            return back()->withInput()->withErrors(['file' => 'Dokumen harus berupa berkas atau link.']);
        }
        $baru = $this->simpanFile($r, $kategori);
        DataInduk::ubah($kategori, function ($d) use ($id, $data, $baru) {
            foreach ($d as &$x) {
                if (($x['id'] ?? null) === $id) {
                    $x['nama'] = $data['nama'];
                    $x['keterangan'] = $data['keterangan'] ?? null;
                    $x['link'] = $data['link'] ?? null;
                    $x['diubah'] = now()->toDateTimeString();
                    if ($baru) $x = array_merge($x, $baru);
                }
            }
            unset($x);
            return $d;
        });
        if ($baru && !empty($ada['file'])) Storage::disk('public')->delete($ada['file']);
        return redirect()->route('datainduk.index', $kategori)->with('ok', 'Dokumen diperbarui.');
    }

    public function destroy(string $kategori, string $id) {
        DataInduk::judul($kategori);
        $ada = DataInduk::cari($kategori, $id) ?? abort(404);
        DataInduk::ubah($kategori, fn ($d) => array_values(array_filter($d, fn ($x) => ($x['id'] ?? null) !== $id)));
        if (!empty($ada['file'])) Storage::disk('public')->delete($ada['file']);
        return redirect()->route('datainduk.index', $kategori)->with('ok', 'Dokumen dihapus.');
    }
}

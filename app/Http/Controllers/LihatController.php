<?php
namespace App\Http\Controllers;
use App\Models\Dokumen;
use App\Support\DataInduk;
use Illuminate\Support\Facades\Storage;

class LihatController extends Controller {
    private const GAMBAR = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
    private const OFFICE = ['doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'];

    public function dataInduk(string $kategori, string $id) {
        $judulKat = DataInduk::judul($kategori);
        $d = DataInduk::cari($kategori, $id) ?? abort(404);
        return $this->tampil($d['nama'], 'Data Induk - ' . $judulKat, $d['file'] ?? null, $d['link'] ?? null, route('datainduk.index', $kategori));
    }

    public function dokumen(int $id) {
        $x = Dokumen::with('isi.kriteria')->findOrFail($id);
        $sub = ($x->isi && $x->isi->kriteria) ? 'Kriteria ' . $x->isi->kriteria->kode . ' - Butir ' . $x->isi->butir : '';
        $kembali = $x->isi ? route('isi.show', $x->isi) : route('dashboard');
        return $this->tampil($x->nama, $sub, $x->file_path, $x->link, $kembali);
    }

    private function tampil(string $judul, string $sub, ?string $file, ?string $link, string $kembali) {
        if (!$file) return $link ? redirect()->away($link) : abort(404);
        abort_unless(Storage::disk('public')->exists($file), 404, 'Berkas tidak ditemukan di penyimpanan.');
        $ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
        $tipe = $ext === 'pdf' ? 'pdf'
            : (in_array($ext, self::GAMBAR, true) ? 'gambar'
            : (in_array($ext, self::OFFICE, true) ? 'office' : 'lain'));
        $url = asset('storage/' . $file);
        $officeUrl = null;
        if ($tipe === 'office' && $this->publik(url('storage/' . $file))) {
            $officeUrl = 'https://view.officeapps.live.com/op/embed.aspx?src=' . rawurlencode(url('storage/' . $file));
        }
        return view('lihat', compact('judul', 'sub', 'url', 'ext', 'tipe', 'officeUrl', 'kembali'));
    }

    // Pratinjau Office memakai layanan Microsoft: hanya berfungsi bila situs dapat dijangkau publik lewat HTTPS
    private function publik(string $url): bool {
        $p = parse_url($url);
        if (($p['scheme'] ?? '') !== 'https') return false;
        $h = strtolower($p['host'] ?? '');
        if ($h === '' || $h === 'localhost') return false;
        if (preg_match('/\.(test|local|lan|localhost|internal)$/', $h)) return false;
        if (filter_var($h, FILTER_VALIDATE_IP) && !filter_var($h, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE)) return false;
        return true;
    }
}

<?php
namespace App\Http\Controllers;
use App\Models\Kriteria;

class DashboardController extends Controller {
    public function index() {
        $rows = Kriteria::with('isi.dokumen')->orderBy('kode')->get()->map(function ($k) {
            $n = $k->isi->count();
            $pct = fn ($c) => $n ? (int) round($c / $n * 100) : 0;
            return [
                'kriteria' => $k,
                'jumlah'   => $n,
                'isian'    => $k->persentase,
                'narasi'   => $pct($k->isi->filter(fn ($i) => filled($i->narasi))->count()),
                'dokumen'  => $pct($k->isi->filter(fn ($i) => $i->dokumen->isNotEmpty())->count()),
            ];
        });
        $total = [
            'isian'   => (int) round($rows->avg('isian') ?? 0),
            'narasi'  => (int) round($rows->avg('narasi') ?? 0),
            'dokumen' => (int) round($rows->avg('dokumen') ?? 0),
        ];
        return view('dashboard', compact('rows', 'total'));
    }
}

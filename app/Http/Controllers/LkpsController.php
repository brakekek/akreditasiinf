<?php

namespace App\Http\Controllers;

use App\Support\Lkps;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class LkpsController extends Controller
{
    /** Halaman menu LKPS: daftar tabel per kelompok beserta kelengkapannya. */
    public function daftar()
    {
        return view('lkps.daftar', ['lk' => \App\Support\LkpsRingkasan::data(), 'tahun' => config('lkps.tahun_ts')]);
    }

    public function index(Request $request, string $tabel)
    {
        $def = Lkps::definisi($tabel);
        $kolom = Lkps::kolom($tabel);
        $cari = trim((string) $request->query('q', ''));

        $query = DB::table(Lkps::namaTabel($tabel))
            ->when($cari !== '', function ($q) use ($kolom, $cari) {
                $q->where(function ($w) use ($kolom, $cari) {
                    foreach ($kolom as $n => $k) {
                        if ($k['type'] !== 'file') {
                            $w->orWhere($n, 'like', "%{$cari}%");
                        }
                    }
                });
            })
            ->orderBy('id');
        $ringkasan = Lkps::ringkasan($tabel, (clone $query)->get());
        $rows = $query->paginate(25)->withQueryString();

        return view('lkps.tabel', [
            'tabel'    => $tabel,
            'def'      => $def,
            'kolom'    => $kolom,
            'rows'     => $rows,
            'cari'      => $cari,
            'kelompok'  => Lkps::namaKelompok($tabel),
            'header'    => Lkps::header($tabel),
            'ringkasan' => $ringkasan,
        ]);
    }

    public function create(string $tabel)
    {
        return $this->form($tabel, null);
    }

    public function store(Request $request, string $tabel)
    {
        $data = $this->ambilData($request, $tabel, null);
        $data['created_by'] = $request->user()?->id;
        $data['created_at'] = $data['updated_at'] = now();

        DB::table(Lkps::namaTabel($tabel))->insert($data);

        return redirect()->route('lkps.tabel.index', $tabel)->with('ok', 'Data ditambahkan.');
    }

    public function edit(string $tabel, int $id)
    {
        return $this->form($tabel, $this->cariBaris($tabel, $id));
    }

    public function update(Request $request, string $tabel, int $id)
    {
        $row = $this->cariBaris($tabel, $id);
        $data = $this->ambilData($request, $tabel, $row);
        $data['updated_at'] = now();

        DB::table(Lkps::namaTabel($tabel))->where('id', $id)->update($data);

        return redirect()->route('lkps.tabel.index', $tabel)->with('ok', 'Perubahan disimpan.');
    }

    public function destroy(string $tabel, int $id)
    {
        $row = $this->cariBaris($tabel, $id);
        foreach (Lkps::kolom($tabel) as $n => $k) {
            if ($k['type'] === 'file' && $row->$n) {
                Storage::disk(Lkps::DISK)->delete($row->$n);
            }
        }
        DB::table(Lkps::namaTabel($tabel))->where('id', $id)->delete();

        return redirect()->route('lkps.tabel.index', $tabel)->with('ok', 'Data dihapus.');
    }

    /** Ekspor CSV (pemisah titik koma agar langsung terbaca Excel berlokal Indonesia). */
    public function export(string $tabel)
    {
        $kolom = Lkps::kolom($tabel);
        $nama = Lkps::namaTabel($tabel);

        return response()->streamDownload(function () use ($kolom, $nama, $tabel) {
            $out = fopen('php://output', 'w');
            fwrite($out, "\xEF\xBB\xBF");
            fputcsv($out, array_merge(['No'], array_column($kolom, 'label')), ';');
            $no = 0;
            DB::table($nama)->orderBy('id')->chunk(500, function ($rows) use (&$no, $out, $kolom, $tabel) {
                foreach ($rows as $r) {
                    $baris = [++$no];
                    foreach ($kolom as $n => $k) {
                        $baris[] = match (true) {
                            $k['type'] === 'check' => $r->$n ? '√' : '',
                            $k['type'] === 'file'  => $r->$n ? Lkps::urlLampiran($tabel, $r->id, $n) : '',
                            default                => $r->$n,
                        };
                    }
                    fputcsv($out, $baris, ';');
                }
            });
            fclose($out);
        }, "lkps_{$tabel}_" . date('Ymd') . '.csv', ['Content-Type' => 'text/csv; charset=UTF-8']);
    }

    private function form(string $tabel, ?object $row)
    {
        return view('lkps.form', [
            'tabel'    => $tabel,
            'def'      => Lkps::definisi($tabel),
            'kolom'    => Lkps::kolom($tabel),
            'row'      => $row,
            'kelompok' => Lkps::namaKelompok($tabel),
        ]);
    }

    private function cariBaris(string $tabel, int $id): object
    {
        Lkps::definisi($tabel);
        $row = DB::table(Lkps::namaTabel($tabel))->where('id', $id)->first();
        abort_if(! $row, 404, 'Data tidak ditemukan.');

        return $row;
    }

    private function ambilData(Request $request, string $tabel, ?object $row): array
    {
        $data = $request->validate(Lkps::rules($tabel, $row !== null), [], Lkps::label($tabel));

        foreach (Lkps::kolom($tabel) as $n => $k) {
            if ($k['type'] === 'check') {
                $data[$n] = $request->boolean($n);
                continue;
            }
            if ($k['type'] !== 'file') {
                continue;
            }
            if ($request->hasFile($n)) {
                if ($row && $row->$n) {
                    Storage::disk(Lkps::DISK)->delete($row->$n);
                }
                $data[$n] = $request->file($n)->store("lkps/{$tabel}", Lkps::DISK);
            } elseif ($row && $row->$n && $request->boolean("hapus_{$n}")) {
                Storage::disk(Lkps::DISK)->delete($row->$n);
                $data[$n] = null;
            } else {
                unset($data[$n]);
            }
        }

        // Kolom total dihitung otomatis (mis. Total SKS pada EWMP).
        foreach (Lkps::definisi($tabel)['total'] ?? [] as $target => $sumber) {
            $data[$target] = array_sum(array_map(fn ($c) => (float) ($data[$c] ?? 0), $sumber));
        }

        return $data;
    }
}

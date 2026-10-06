<?php

namespace App\Http\Controllers;

use App\Support\LkpsData;
use Illuminate\Http\Request;

class LkpsIsianController extends Controller
{
    public function index()
    {
        return view('lkps.isian', [
            'grup'  => config('lkps.isian', []),
            'nilai' => LkpsData::isian(),
        ]);
    }

    public function simpan(Request $request)
    {
        $rules = [];
        $label = [];
        foreach (config('lkps.isian', []) as $daftar) {
            foreach ($daftar as $kunci => [$lbl, $tipe]) {
                $rules[$kunci] = $tipe === 'number' ? ['nullable', 'integer', 'min:0'] : ['nullable', 'string', 'max:255'];
                $label[$kunci] = $lbl;
            }
        }
        $data = $request->validate($rules, [], $label);
        LkpsData::simpanIsian(array_map(fn ($v) => $v ?? '', $data + array_fill_keys(array_keys($rules), null)));

        return back()->with('ok', 'Isian disimpan.');
    }
}

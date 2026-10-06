@extends('layout')
@section('title', 'Identitas & isian tambahan')

@section('content')
@include('lkps._gaya')
<h1 class="mb-1">Identitas & isian tambahan</h1>
<p class="text-secondary mb-4" style="max-width: 70ch">
    Isian di luar 31 tabel: sheet Identitas pada template dan baris Jumlah Dosen DTPR pada Tabel 3.A.3.
    Nilainya ikut diekspor dan diimpor bersama data tabel.
</p>

<form method="POST" action="{{ route('lkps.isian.simpan') }}">
    @csrf
    <div class="row g-3">
        @foreach ($grup as $judulGrup => $daftar)
            <div class="col-12 col-xl-6">
                <section class="lk-panel h-100">
                    <h2 class="mb-3">{{ $judulGrup }}</h2>
                    @foreach ($daftar as $kunci => [$label, $tipe])
                        <div class="mb-2">
                            <label for="i_{{ $kunci }}" class="form-label small fw-semibold mb-1">{{ $label }}</label>
                            @auth
                                <input id="i_{{ $kunci }}" name="{{ $kunci }}" type="{{ $tipe === 'number' ? 'number' : 'text' }}"
                                       @if ($tipe === 'number') min="0" step="1" @endif
                                       value="{{ old($kunci, $nilai[$kunci] ?? '') }}"
                                       class="form-control form-control-sm @error($kunci) is-invalid @enderror">
                                @error($kunci) <div class="invalid-feedback">{{ $message }}</div> @enderror
                            @else
                                <div id="i_{{ $kunci }}" class="form-control form-control-sm bg-light">{{ ($nilai[$kunci] ?? '') !== '' ? $nilai[$kunci] : '–' }}</div>
                            @endauth
                        </div>
                    @endforeach
                </section>
            </div>
        @endforeach
    </div>
    @auth
        <div class="mt-3"><button class="btn btn-primary">Simpan isian</button></div>
    @endauth
</form>
@endsection

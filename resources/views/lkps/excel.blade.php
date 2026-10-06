@extends('layout')
@section('title', 'Impor & ekspor Excel')

@section('content')
@include('lkps._gaya')
<h1 class="mb-1">Impor & ekspor Excel</h1>
<p class="text-secondary mb-4" style="max-width: 70ch">
    Ekspor mengisi template resmi LKPS (31 sheet) dengan seluruh data aplikasi. Impor membaca workbook
    dengan format yang sama dan memasukkan isinya ke database.
</p>

@if (! $tersedia)
    <div class="alert alert-warning py-2">Pustaka <strong>PhpSpreadsheet</strong> belum terpasang di server, jadi impor dan ekspor Excel belum dapat dipakai. Jalankan di folder aplikasi: <code>composer require phpoffice/phpspreadsheet</code></div>
@endif

@if (session('galat'))
    <div class="alert alert-danger py-2">{{ session('galat') }}</div>
@endif

@if (session('ringkas'))
    <div class="lk-panel mb-3">
        <h2 class="mb-2">Hasil impor</h2>
        <ul class="lk-list">
            @foreach (session('ringkas') as $slug => $n)
                <li><a href="{{ route('lkps.tabel.index', $slug) }}">{{ $judul[$slug] ?? $slug }}</a><span class="lk-status isi">{{ $n }} baris</span></li>
            @endforeach
        </ul>
    </div>
@endif

@if (session('catatan'))
    <div class="alert alert-warning py-2">
        <strong>Catatan:</strong>
        <ul class="mb-0 mt-1">
            @foreach (session('catatan') as $c)
                <li>{{ $c }}</li>
            @endforeach
        </ul>
    </div>
@endif

<div class="row g-3">
    <div class="col-12 col-xl-4">
        <section class="lk-panel h-100">
            <h2 class="mb-2">Ekspor ke template</h2>
            @if ($adaTemplate)
                <p class="small text-secondary">Template terakhir diperbarui {{ $waktuTemplate }}.</p>
                <a href="{{ route('lkps.excel.ekspor') }}" class="btn btn-primary">Unduh LKPS (.xlsx)</a>
            @else
                <p class="small text-secondary mb-0">Template belum ada. Unggah template LKPS terlebih dahulu.</p>
            @endif
        </section>
    </div>

    <div class="col-12 col-xl-4">
        <section class="lk-panel h-100">
            <h2 class="mb-2">Template LKPS</h2>
            <p class="small text-secondary">{{ $adaTemplate ? 'Template sudah tersedia. Unggah lagi untuk mengganti.' : 'Unggah workbook template LKPS LAM Infokom yang kosong.' }}</p>
            @auth
                <form method="POST" action="{{ route('lkps.excel.template') }}" enctype="multipart/form-data">
                    @csrf
                    <label for="template" class="visually-hidden">File template</label>
                    <input id="template" type="file" name="template" accept=".xlsx" required class="form-control form-control-sm mb-2 @error('template') is-invalid @enderror">
                    @error('template') <div class="invalid-feedback d-block mb-2">{{ $message }}</div> @enderror
                    <button class="btn btn-sm btn-outline-secondary">Simpan template</button>
                </form>
            @else
                <a href="{{ route('login') }}" class="btn btn-sm btn-outline-secondary">Masuk untuk mengunggah template</a>
            @endauth
        </section>
    </div>

    <div class="col-12 col-xl-4">
        <section class="lk-panel h-100">
            <h2 class="mb-2">Impor dari Excel</h2>
            @auth
                <form method="POST" action="{{ route('lkps.excel.impor') }}" enctype="multipart/form-data">
                    @csrf
                    <label for="file" class="form-label small fw-semibold">Workbook LKPS yang sudah terisi</label>
                    <input id="file" type="file" name="file" accept=".xlsx" required class="form-control form-control-sm mb-2 @error('file') is-invalid @enderror">
                    @error('file') <div class="invalid-feedback d-block mb-2">{{ $message }}</div> @enderror
                    <div class="form-check small">
                        <input class="form-check-input" type="radio" name="mode" id="mode-ganti" value="ganti">
                        <label class="form-check-label" for="mode-ganti">Ganti isi tabel yang ada di file</label>
                    </div>
                    <div class="form-check small mb-3">
                        <input class="form-check-input" type="radio" name="mode" id="mode-tambah" value="tambah" checked>
                        <label class="form-check-label" for="mode-tambah">Tambahkan ke data yang sudah ada</label>
                    </div>
                    <button class="btn btn-sm btn-primary" onclick="return document.getElementById('mode-tambah').checked || confirm('Isi tabel yang ada di file akan diganti. Lanjutkan?')">Impor</button>
                </form>
            @else
                <a href="{{ route('login') }}" class="btn btn-sm btn-outline-secondary">Masuk untuk mengimpor data</a>
            @endauth
        </section>
    </div>
</div>
@endsection

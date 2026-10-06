@extends('layout')
@section('title', 'LKPS')

@section('content')
@include('lkps._gaya')
<div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-3">
  <div>
    <p class="lk-crumb">Data Induk</p>
    <h1 class="mb-0">LKPS LAM Infokom</h1>
    <p class="small text-secondary mb-0 mt-1">Laporan Kinerja Program Studi &middot; Tahun TS {{ $tahun }}</p>
  </div>
  <div class="d-flex gap-2">
    <a href="{{ route('lkps.isian.index') }}" class="btn btn-sm btn-outline-secondary">Identitas &amp; isian tambahan</a>
    <a href="{{ route('lkps.excel.index') }}" class="btn btn-sm btn-outline-secondary">Impor &amp; ekspor Excel</a>
  </div>
</div>

@if(! $lk['tersedia'])
  <div class="alert alert-warning">Tabel LKPS belum dibuat. Jalankan <code>php artisan lkps:sinkron</code> di folder aplikasi.</div>
@else
  <div class="lk-panel mb-3">
    <div class="mb-2"><strong>{{ $lk['terisi'] }}</strong> dari {{ $lk['total'] }} tabel sudah berisi data</div>
    <div style="max-width:560px">@include('bar', ['v' => $lk['persen']])</div>
  </div>
  <div class="row g-3">
    @foreach($lk['kelompok'] as $g)
      <div class="col-12 col-xl-6">
        <section class="lk-panel h-100">
          <div class="d-flex justify-content-between align-items-baseline gap-2">
            <h2 class="h6 mb-0 fw-semibold">{{ $g['nama'] }}</h2>
            <span class="small text-secondary text-nowrap">{{ $g['terisi'] }}/{{ count($g['items']) }} terisi</span>
          </div>
          <div class="lk-seg" aria-hidden="true">
            @foreach($g['items'] as $i)<span class="{{ $i['n'] > 0 ? 'isi' : 'kosong' }}" title="{{ $i['judul'] }}"></span>@endforeach
          </div>
          <ul class="lk-list">
            @foreach($g['items'] as $i)
              <li>
                <a href="{{ route('lkps.tabel.index', $i['slug']) }}">{{ $i['judul'] }}</a>
                <span class="lk-status {{ $i['n'] > 0 ? 'isi' : 'kosong' }}">{{ $i['n'] > 0 ? $i['n'] . ' baris' : 'Belum diisi' }}</span>
              </li>
            @endforeach
          </ul>
        </section>
      </div>
    @endforeach
  </div>
@endif
@endsection

@extends('layout')
@section('title', 'Lihat Dokumen')
@section('content')
<div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
  <div><h1 class="mb-0 h4">{{ $judul }}</h1>@if($sub)<div class="text-muted small">{{ $sub }}</div>@endif</div>
  <a href="{{ $kembali }}" class="btn btn-outline-secondary btn-sm">&larr; Kembali</a>
</div>
<div class="card">
  @if($tipe === 'pdf')
    <iframe src="{{ $url }}" title="{{ $judul }}" style="width:100%;height:80vh;border:0"></iframe>
  @elseif($tipe === 'gambar')
    <div class="p-3 text-center"><img src="{{ $url }}" alt="{{ $judul }}" style="max-width:100%;height:auto"></div>
  @elseif($tipe === 'office' && $officeUrl)
    <iframe src="{{ $officeUrl }}" title="{{ $judul }}" style="width:100%;height:80vh;border:0"></iframe>
  @else
    <div class="p-4 text-center">
      @if($tipe === 'office')
        <p class="mb-1 fw-medium">Dokumen Office tidak dapat dipratinjau di server ini.</p>
        <p class="text-muted small">Pratinjau Office memerlukan situs yang dapat diakses publik lewat HTTPS.</p>
      @else
        <p class="mb-1 fw-medium">Format .{{ $ext }} tidak dapat dipratinjau di browser.</p>
      @endif
      <a class="btn btn-primary" href="{{ $url }}" download>Unduh berkas</a>
    </div>
  @endif
</div>
@endsection

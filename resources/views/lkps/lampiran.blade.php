@extends('layout')
@section('title', $label . ' - ' . $def['judul'])

@section('content')
@include('lkps._gaya')
<div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-3">
    <div>
        <p class="lk-crumb">
            <a href="{{ route('lkps.tabel.index', $tabel) }}" class="link-secondary">{{ $def['judul'] }}</a>
        </p>
        <h1>{{ $label }}</h1>
        @if ($ringkas !== '')
            <p class="small text-secondary mb-0 mt-1">{{ $ringkas }}</p>
        @endif
    </div>
    <div class="d-flex gap-2">
        <a href="{{ $src }}" target="_blank" rel="noopener" class="btn btn-sm btn-outline-secondary">
            Buka di tab baru
        </a>
        <a href="{{ route('lkps.tabel.index', $tabel) }}" class="btn btn-sm btn-outline-secondary">Kembali ke tabel</a>
    </div>
</div>

<div class="lk-panel p-2">
    @if (str_starts_with($mime, 'image/'))
        <img src="{{ $src }}" alt="{{ $label }}" class="d-block mx-auto" style="max-width: 100%; max-height: 80vh">
    @elseif ($mime === 'application/pdf')
        <iframe src="{{ $src }}" title="{{ $label }}" style="width: 100%; height: 80vh; border: 0"></iframe>
    @else
        <p class="text-center text-secondary my-5">Jenis berkas ini tidak bisa dipratinjau di browser.</p>
    @endif
</div>
@endsection

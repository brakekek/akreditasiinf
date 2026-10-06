@extends('layout')
@section('title', $judul)
@section('content')
<div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
  <div><h1 class="mb-0">{{ $judul }}</h1><div class="text-muted small">Data Induk &middot; {{ $items->count() }} dokumen</div></div>
  @auth<a href="{{ route('datainduk.create', $kategori) }}" class="btn btn-primary">Tambah dokumen</a>@endauth
</div>
<form method="get" class="mb-3"><input type="search" name="q" value="{{ $q }}" class="form-control" style="max-width:380px" placeholder="Cari nama atau keterangan dokumen..."></form>
<div class="card"><div class="table-responsive"><table class="table align-middle mb-0">
  <thead><tr><th style="width:48px">No</th><th>Nama dokumen</th><th>Keterangan</th><th>Berkas / link</th>@auth<th class="text-end">Aksi</th>@endauth</tr></thead>
  <tbody>
  @forelse($items as $i => $d)
    <tr>
      <td>{{ $i + 1 }}</td>
      <td class="fw-medium">{{ $d['nama'] }}</td>
      <td class="elemen" style="min-width:220px">{{ ($d['keterangan'] ?? '') ?: '-' }}</td>
      <td>
        @if(!empty($d['file']))<a href="{{ route('lihat.datainduk', [$kategori, $d['id']]) }}" target="_blank" rel="noopener">Lihat</a> <span class="text-muted small">({{ \App\Support\DataInduk::ukuran($d['ukuran'] ?? 0) }})</span>@endif
        @if(!empty($d['file']) && !empty($d['link']))<br>@endif
        @if(!empty($d['link']))<a href="{{ $d['link'] }}" target="_blank" rel="noopener">Buka link</a>@endif
      </td>
      @auth
      <td class="text-end text-nowrap">
        <a href="{{ route('datainduk.edit', [$kategori, $d['id']]) }}" class="btn btn-sm btn-outline-secondary">Ubah</a>
        <form action="{{ route('datainduk.destroy', [$kategori, $d['id']]) }}" method="post" class="d-inline" onsubmit="return confirm('Hapus dokumen ini?')">@csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button></form>
      </td>
      @endauth
    </tr>
  @empty
    <tr><td colspan="5" class="text-center text-muted py-4">Belum ada dokumen.</td></tr>
  @endforelse
  </tbody>
</table></div></div>
@endsection

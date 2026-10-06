@extends('layout')
@section('title', $kriteria->kode)
@section('content')
<div class="d-flex justify-content-between mb-2">
  <h4>{{ $kriteria->kode }} - {{ $kriteria->nama }}</h4>
  @auth <a href="{{ route('isi.create', ['kriteria_id' => $kriteria->id]) }}" class="btn btn-primary">Tambah isi kriteria</a> @endauth
</div>
<div class="mb-3" style="max-width:400px">@include('bar', ['v' => $kriteria->persentase])</div>
<div class="card"><table class="table align-middle mb-0">
  <thead><tr><th>Butir</th><th>Elemen penilaian</th><th>Narasi</th><th style="width:15%">Isian</th><th class="text-center">Dokumen</th><th class="text-end">Aksi</th></tr></thead>
  <tbody>
  @forelse($kriteria->isi as $i)
    <tr>
      <td>{{ $i->butir }}</td>
      <td class="elemen" style="min-width:260px">{!! nl2br(e($i->elemen_penilaian)) !!}</td>
      <td style="min-width:240px">
        @if(filled($i->narasi))
          {{ \Illuminate\Support\Str::limit(trim(preg_replace('/\s+/', ' ', html_entity_decode(strip_tags($i->narasi)))) ?: '[Narasi berisi gambar/tabel]', 140) }}
          <a href="{{ route('isi.show', $i) }}">Read more</a>
        @else
          <span class="badge text-bg-secondary">Kosong</span>
        @endif
      </td>
      <td>@include('bar', ['v' => $i->persentase])</td>
      <td class="text-center">{{ $i->dokumen->count() }}</td>
      <td class="text-end">
        <a href="{{ route('isi.show', $i) }}" class="btn btn-sm btn-outline-primary">Detail</a>
        @auth <a href="{{ route('isi.edit', $i) }}" class="btn btn-sm btn-outline-secondary">Ubah</a> @endauth
        @auth <form action="{{ route('isi.destroy', $i) }}" method="post" class="d-inline" onsubmit="return confirm('Hapus butir ini beserta dokumennya?')">@csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button></form> @endauth
      </td>
    </tr>
  @empty
    <tr><td colspan="6" class="text-center text-muted py-4">Belum ada isi kriteria.</td></tr>
  @endforelse
  </tbody>
</table></div>
<a href="{{ route('kriteria.index') }}" class="btn btn-link mt-2">Kembali</a>
@endsection

@extends('layout')
@section('title', 'Kriteria Akreditasi')
@section('content')
<div class="d-flex justify-content-between mb-3"><h4>Kriteria Akreditasi</h4>@auth <a href="{{ route('kriteria.create') }}" class="btn btn-primary">Tambah kriteria</a> @endauth</div>
<div class="card"><table class="table align-middle mb-0">
  <thead><tr><th>Kode</th><th>Nama kriteria</th><th style="width:20%">Persentase isian</th><th class="text-end">Aksi</th></tr></thead>
  <tbody>
  @forelse($items as $k)
    <tr>
      <td>{{ $k->kode }}</td><td>{{ $k->nama }}</td>
      <td>@include('bar', ['v' => $k->persentase])</td>
      <td class="text-end">
        <a href="{{ route('kriteria.show', $k) }}" class="btn btn-sm btn-outline-primary">Isi kriteria</a>
        @auth <a href="{{ route('kriteria.edit', $k) }}" class="btn btn-sm btn-outline-secondary">Ubah</a> @endauth
        @auth <form action="{{ route('kriteria.destroy', $k) }}" method="post" class="d-inline" onsubmit="return confirm('Hapus kriteria beserta isi dan dokumennya?')">@csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button></form> @endauth
      </td>
    </tr>
  @empty
    <tr><td colspan="4" class="text-center text-muted py-4">Belum ada kriteria.</td></tr>
  @endforelse
  </tbody>
</table></div>
<div class="mt-3">{{ $items->links() }}</div>
@endsection

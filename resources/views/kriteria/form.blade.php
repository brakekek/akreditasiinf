@extends('layout')
@section('title', $kriteria->exists ? 'Ubah Kriteria' : 'Tambah Kriteria')
@section('content')
<h4 class="mb-3">{{ $kriteria->exists ? 'Ubah' : 'Tambah' }} kriteria</h4>
<form method="post" class="card card-body" action="{{ $kriteria->exists ? route('kriteria.update', $kriteria) : route('kriteria.store') }}">
  @csrf @if($kriteria->exists) @method('PUT') @endif
  <div class="mb-3"><label class="form-label">Kode kriteria</label><input name="kode" class="form-control" value="{{ old('kode', $kriteria->kode) }}" required></div>
  <div class="mb-3"><label class="form-label">Nama kriteria</label><input name="nama" class="form-control" value="{{ old('nama', $kriteria->nama) }}" required></div>
  <p class="text-muted small">Persentase isian dihitung otomatis dari rata-rata persentase butir di dalam kriteria.</p>
  <div><button class="btn btn-primary">Simpan</button> <a href="{{ route('kriteria.index') }}" class="btn btn-link">Batal</a></div>
</form>
@endsection

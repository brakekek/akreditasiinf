@extends('layout')
@section('title', $dok ? 'Ubah Dokumen' : 'Tambah Dokumen')
@section('content')
<h1 class="mb-3">{{ $dok ? 'Ubah' : 'Tambah' }} dokumen &ndash; {{ $judul }}</h1>
<form method="post" enctype="multipart/form-data" class="card card-body" style="max-width:680px"
      action="{{ $dok ? route('datainduk.update', [$kategori, $dok['id']]) : route('datainduk.store', $kategori) }}">
  @csrf @if($dok) @method('PUT') @endif
  <div class="mb-3"><label class="form-label">Nama dokumen</label><input name="nama" class="form-control" value="{{ old('nama', $dok['nama'] ?? '') }}" required></div>
  <div class="mb-3"><label class="form-label">Keterangan</label><textarea name="keterangan" rows="3" class="form-control">{{ old('keterangan', $dok['keterangan'] ?? '') }}</textarea></div>
  <div class="mb-3"><label class="form-label">Berkas (PDF, Office, ZIP, gambar; maks. 20 MB)</label>
    <input type="file" name="file" class="form-control">
    @if(!empty($dok['file']))<div class="form-text">Berkas saat ini: <a href="{{ route('lihat.datainduk', [$kategori, $dok['id']]) }}" target="_blank" rel="noopener">{{ $dok['nama_file'] }}</a>. Unggah berkas baru untuk menggantinya.</div>@endif</div>
  <div class="mb-3"><label class="form-label">Atau link dokumen</label><input type="url" name="link" class="form-control" placeholder="https://" value="{{ old('link', $dok['link'] ?? '') }}"></div>
  <div><button class="btn btn-primary">Simpan</button> <a href="{{ route('datainduk.index', $kategori) }}" class="btn btn-link">Batal</a></div>
</form>
@endsection

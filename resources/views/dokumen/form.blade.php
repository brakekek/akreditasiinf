@extends('layout')
@section('title', $dokumen->exists ? 'Ubah Dokumen' : 'Tambah Dokumen')
@section('content')
<h4 class="mb-3">{{ $dokumen->exists ? 'Ubah' : 'Tambah' }} dokumen - Butir {{ $isi->butir }}</h4>
<form method="post" enctype="multipart/form-data" class="card card-body" action="{{ $dokumen->exists ? route('dokumen.update', $dokumen) : route('dokumen.store') }}">
  @csrf @if($dokumen->exists) @method('PUT') @endif
  <input type="hidden" name="isi_kriteria_id" value="{{ $isi->id }}">
  <div class="mb-3"><label class="form-label">Nama dokumen</label><input name="nama" class="form-control" value="{{ old('nama', $dokumen->nama) }}" required></div>
  <div class="mb-3"><label class="form-label">Berkas (PDF, Office, ZIP, gambar; maks. 20 MB)</label>
    <input type="file" name="file" class="form-control">
    @if($dokumen->file_path)<div class="form-text">Berkas saat ini: <a href="{{ route('lihat.dokumen', $dokumen) }}" target="_blank" rel="noopener">lihat</a>. Unggah berkas baru untuk menggantinya.</div>@endif</div>
  <div class="mb-3"><label class="form-label">Atau link dokumen</label><input type="url" name="link" class="form-control" placeholder="https://" value="{{ old('link', $dokumen->link) }}"></div>
  <div><button class="btn btn-primary">Simpan</button> <a href="{{ route('isi.show', $isi) }}" class="btn btn-link">Batal</a></div>
</form>
@unless($dokumen->exists)
@php $grupArsip = collect(\App\Support\SumberDokumen::daftar($isi->id))->groupBy('grup'); @endphp
<div class="card card-body mt-4" id="arsip" style="max-width:680px">
  <h2 class="h6 mb-1">Atau gunakan dokumen yang sudah pernah diunggah</h2>
  <p class="text-muted small">Pilih dari Data Induk atau dokumen pada kriteria lain. Berkas akan disalin, sehingga dokumen ini berdiri sendiri (menghapus salah satunya tidak memengaruhi yang lain).</p>
  <form method="post" action="{{ route('dokumen.arsip') }}">
    @csrf
    <input type="hidden" name="isi_kriteria_id" value="{{ $isi->id }}">
    <input type="search" id="cari-arsip" class="form-control mb-2" placeholder="Cari nama dokumen...">
    <div class="border rounded" style="max-height:280px;overflow:auto" id="daftar-arsip">
      @forelse($grupArsip as $judulGrup => $items)
        <div class="px-3 py-1 bg-light small fw-semibold text-muted grup-arsip">{{ $judulGrup }}</div>
        @foreach($items as $it)
          <label class="d-flex gap-2 align-items-center px-3 py-2 border-top item-arsip" style="cursor:pointer;margin:0">
            <input type="radio" name="rujukan" value="{{ $it['kunci'] }}" data-nama="{{ $it['nama'] }}" @checked(old('rujukan') === $it['kunci'])>
            <span class="flex-grow-1">{{ $it['nama'] }}</span>
            <span class="badge text-bg-light border">{{ $it['jenis'] }}</span>
          </label>
        @endforeach
      @empty
        <div class="p-3 text-muted small">Belum ada dokumen yang dapat dipilih.</div>
      @endforelse
    </div>
    <div class="mt-3"><label class="form-label">Nama dokumen pada butir ini</label>
      <input name="nama" id="nama-arsip" class="form-control" value="{{ old('nama') }}" required></div>
    <div class="mt-3"><button class="btn btn-primary">Gunakan dokumen ini</button></div>
  </form>
  <script>
    (function () {
      var q = document.getElementById('cari-arsip'), nm = document.getElementById('nama-arsip'), auto = '';
      q.addEventListener('input', function () {
        var t = q.value.toLowerCase();
        document.querySelectorAll('#daftar-arsip .item-arsip').forEach(function (el) {
          el.style.display = el.textContent.toLowerCase().indexOf(t) > -1 ? '' : 'none';
        });
        document.querySelectorAll('#daftar-arsip .grup-arsip').forEach(function (g) {
          var n = g.nextElementSibling, ada = false;
          while (n && n.classList.contains('item-arsip')) { if (n.style.display !== 'none') ada = true; n = n.nextElementSibling; }
          g.style.display = ada ? '' : 'none';
        });
      });
      document.querySelectorAll('#daftar-arsip input[type=radio]').forEach(function (r) {
        r.addEventListener('change', function () {
          if (nm.value === '' || nm.value === auto) { nm.value = r.dataset.nama; auto = r.dataset.nama; }
        });
      });
    })();
  </script>
</div>
@endunless
@endsection

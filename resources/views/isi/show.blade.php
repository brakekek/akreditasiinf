@extends('layout')
@section('title', 'Butir '.$isi->butir)
@section('content')
<p class="mb-1"><a href="{{ route('kriteria.show', $isi->kriteria) }}">&larr; {{ $isi->kriteria->kode }} - {{ $isi->kriteria->nama }}</a></p>
<h4>Butir {{ $isi->butir }}</h4>
<div class="card card-body mb-4">
  <h6>Elemen penilaian</h6><p class="elemen">{!! nl2br(e($isi->elemen_penilaian)) !!}</p>
  <style>
    .narasi img{max-width:100%;height:auto}
    .narasi table{border-collapse:collapse;width:100%;margin-bottom:1rem}
    .narasi td,.narasi th{border:1px solid #dee2e6;padding:.4rem .6rem}
    .narasi.clamp{max-height:160px;overflow:hidden;-webkit-mask-image:linear-gradient(#000 55%,transparent);mask-image:linear-gradient(#000 55%,transparent)}
  </style>
  <h6>Narasi</h6>
  @if(filled($isi->narasi))
    <div class="narasi clamp" id="narasi-box">{!! clean($isi->narasi, \App\Models\IsiKriteria::PURIFY) !!}</div>
    <button type="button" class="btn btn-link p-0 mb-3 d-none" id="narasi-toggle">Read more</button>
    <script>
      (function () {
        var b = document.getElementById('narasi-box'), t = document.getElementById('narasi-toggle');
        function cek() { if (b.classList.contains('clamp') && b.scrollHeight > b.clientHeight + 4) t.classList.remove('d-none'); }
        t.onclick = function () { var tutup = b.classList.toggle('clamp'); t.textContent = tutup ? 'Read more' : 'Read less'; };
        cek(); window.addEventListener('load', cek);
      })();
    </script>
  @else
    <div class="mb-3 text-muted">Narasi belum diisi.</div>
  @endif
  <h6>Persentase isian</h6><div style="max-width:400px">@include('bar', ['v' => $isi->persentase])</div>
  <div class="mt-3">@auth <a href="{{ route('isi.edit', $isi) }}" class="btn btn-sm btn-outline-secondary">Ubah isi</a> @endauth</div>
</div>
<div class="d-flex justify-content-between mb-2"><h5>Detail dokumen</h5>@auth <a href="{{ route('dokumen.create', ['isi_id' => $isi->id]) }}" class="btn btn-primary btn-sm">Tambah dokumen</a> @endauth</div>
<div class="card"><table class="table align-middle mb-0">
  <thead><tr><th>Butir</th><th>Nama dokumen</th><th>Dokumen / link</th><th class="text-end">Aksi</th></tr></thead>
  <tbody>
  @forelse($isi->dokumen as $d)
    <tr>
      <td>{{ $isi->butir }}</td><td>{{ $d->nama }}</td>
      <td>
        @if($d->file_path)<a href="{{ route('lihat.dokumen', $d) }}" target="_blank" rel="noopener">Lihat</a>@endif
        @if($d->file_path && $d->link) &nbsp;|&nbsp; @endif
        @if($d->link)<a href="{{ $d->link }}" target="_blank" rel="noopener">Buka link</a>@endif
      </td>
      <td class="text-end">
        @auth <a href="{{ route('dokumen.edit', $d) }}" class="btn btn-sm btn-outline-secondary">Ubah</a> @endauth
        @auth <form action="{{ route('dokumen.destroy', $d) }}" method="post" class="d-inline" onsubmit="return confirm('Hapus dokumen ini?')">@csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button></form> @endauth
      </td>
    </tr>
  @empty
    <tr><td colspan="4" class="text-center text-muted py-4">Belum ada dokumen.</td></tr>
  @endforelse
  </tbody>
</table></div>
@endsection

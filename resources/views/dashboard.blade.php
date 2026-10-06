@extends('layout')
@section('title', 'Dashboard')
@section('content')
@php
  $overall = (int) round(($total['isian'] + $total['narasi'] + $total['dokumen']) / 3);
  $nk = $rows->count();
  $ringkas = [
    ['Isian kriteria', $total['isian']],
    ['Isian narasi', $total['narasi']],
    ['Kelengkapan dokumen', $total['dokumen']],
  ];
  // titik-titik gauge 270 derajat (dari kiri bawah ke kanan bawah)
  $ticks = [];
  for ($i = 0; $i <= 10; $i++) {
    $a = deg2rad(135 + 27 * $i);
    $ticks[] = [90 + 84 * cos($a), 90 + 84 * sin($a), 90 + 90 * cos($a), 90 + 90 * sin($a)];
  }
  // radar profil capaian per kriteria
  $rc = 130; $rr = 92;
  $titik = function ($i, $v) use ($nk, $rc, $rr) {
    $a = deg2rad(-90 + 360 / max($nk, 1) * $i);
    return [$rc + $rr * $v / 100 * cos($a), $rc + $rr * $v / 100 * sin($a)];
  };
  $poligon = fn ($key) => $rows->values()->map(fn ($r, $i) => implode(',', array_map(fn ($n) => round($n, 1), $titik($i, $r[$key]))))->implode(' ');
  $seri = [['isian', 'Isian', '#2563eb'], ['narasi', 'Narasi', '#0d9488'], ['dokumen', 'Dokumen', '#f59e0b']];
@endphp

<div class="dh">
  <div class="dh-gauge">
    <svg viewBox="0 0 180 180" aria-hidden="true">
      @foreach($ticks as $t)<line x1="{{ $t[0] }}" y1="{{ $t[1] }}" x2="{{ $t[2] }}" y2="{{ $t[3] }}" class="tk"/>@endforeach
      <path d="M40.5 139.5 A70 70 0 1 1 139.5 139.5" pathLength="100" class="trk"/>
      <path d="M40.5 139.5 A70 70 0 1 1 139.5 139.5" pathLength="100" class="val" stroke-dasharray="{{ $overall }} 100"/>
      <text x="38" y="168" class="lim">0</text><text x="142" y="168" class="lim" text-anchor="end">100</text>
    </svg>
    <div class="dh-num"><b>{{ $overall }}<small>%</small></b><span>Kesiapan</span></div>
  </div>
  <div class="dh-body">
    <div class="dh-eyebrow">Program Studi S1 Informatika</div>
    <h2>Kesiapan Akreditasi</h2>
    <p>Rata-rata isian kriteria, isian narasi, dan kelengkapan dokumen</p>
    <div class="dh-mini">
      @foreach($ringkas as [$label, $v])
      <div class="mc">
        <svg viewBox="0 0 36 36" aria-hidden="true"><circle cx="18" cy="18" r="15.9155" class="r0"/><circle cx="18" cy="18" r="15.9155" class="r1" stroke-dasharray="{{ $v }} 100"/></svg>
        <span class="mc-v">{{ $v }}%</span>
        <div><small>{{ $label }}</small><b>rata-rata {{ $nk }} kriteria</b></div>
      </div>
      @endforeach
    </div>
  </div>
</div>

<div class="dg">
  <div class="card dp">
    <div class="dp-eyebrow">Profil capaian</div>
    <div class="dp-title">Seluruh kriteria sekilas</div>
    @if($nk >= 3)
    <svg viewBox="0 0 260 260" class="radar" role="img" aria-label="Grafik radar capaian per kriteria">
      @foreach([25, 50, 75, 100] as $g)
        <polygon class="grid" points="{{ $rows->values()->map(fn ($r, $i) => implode(',', array_map(fn ($n) => round($n, 1), $titik($i, $g))))->implode(' ') }}"/>
      @endforeach
      @foreach($rows->values() as $i => $r)
        @php [$x, $y] = $titik($i, 100); [$lx, $ly] = $titik($i, 118); @endphp
        <line class="grid" x1="{{ $rc }}" y1="{{ $rc }}" x2="{{ round($x, 1) }}" y2="{{ round($y, 1) }}"/>
        <text x="{{ round($lx, 1) }}" y="{{ round($ly, 1) }}" class="lbl" text-anchor="middle" dominant-baseline="middle">{{ $r['kriteria']->kode }}</text>
      @endforeach
      @foreach($seri as [$key, $nama, $warna])
        <polygon points="{{ $poligon($key) }}" fill="{{ $warna }}" fill-opacity=".14" stroke="{{ $warna }}" stroke-width="2" stroke-linejoin="round"/>
      @endforeach
    </svg>
    <div class="lg">@foreach($seri as [$key, $nama, $warna])<span><i style="background:{{ $warna }}"></i>{{ $nama }}</span>@endforeach</div>
    @else
    <p class="text-muted small mb-0">Grafik radar tampil bila ada minimal 3 kriteria.</p>
    @endif
  </div>

  <div class="card dp">
    <div class="dp-eyebrow">Capaian per kriteria</div>
    <div class="dp-title">Isian, narasi, dan dokumen</div>
    @forelse($rows as $r)
      <a class="kr" href="{{ route('kriteria.show', $r['kriteria']) }}">
        <div class="kr-h"><b>{{ $r['kriteria']->kode }}</b> {{ $r['kriteria']->nama }}<span>{{ $r['jumlah'] }} butir</span></div>
        <div class="kr-b">
          @foreach($seri as [$key, $nama, $warna])
          <div title="{{ $nama }} {{ $r[$key] }}%"><small>{{ $nama }}</small><div class="kb"><i style="width:{{ $r[$key] }}%;background:{{ $warna }}"></i></div><em>{{ $r[$key] }}%</em></div>
          @endforeach
        </div>
      </a>
    @empty
      <p class="text-muted small mb-0">Belum ada kriteria. @auth<a href="{{ route('kriteria.create') }}">Tambah kriteria</a>@endauth</p>
    @endforelse
  </div>
</div>
<p class="text-muted small mt-2">Narasi = butir yang narasinya sudah terisi. Dokumen = butir yang memiliki minimal satu dokumen/link.</p>
@endsection

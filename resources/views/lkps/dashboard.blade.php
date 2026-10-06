@php $lk = \App\Support\LkpsRingkasan::data(); @endphp
@if($lk['tersedia'])
@include('lkps._gaya')
<div class="sec" style="margin-top:26px">Kelengkapan LKPS</div>
<div class="lk-panel mb-3">
  <div class="d-flex justify-content-between flex-wrap gap-2 align-items-baseline mb-2">
    <span><strong>{{ $lk['terisi'] }}</strong> dari {{ $lk['total'] }} tabel LKPS sudah berisi data</span>
    <a href="{{ route('lkps.daftar') }}" class="small">Buka LKPS &rarr;</a>
  </div>
  <div style="max-width:560px">@include('bar', ['v' => $lk['persen']])</div>
</div>
<div class="row g-3">
  @foreach($lk['kelompok'] as $g)
    <div class="col-12 col-xl-6">
      <section class="lk-panel h-100">
        <div class="d-flex justify-content-between align-items-baseline gap-2">
          <h2 class="h6 mb-0 fw-semibold">{{ $g['nama'] }}</h2>
          <span class="small text-secondary text-nowrap">{{ $g['terisi'] }}/{{ count($g['items']) }} terisi</span>
        </div>
        <div class="lk-seg" aria-hidden="true">
          @foreach($g['items'] as $i)<span class="{{ $i['n'] > 0 ? 'isi' : 'kosong' }}" title="{{ $i['judul'] }}"></span>@endforeach
        </div>
        <ul class="lk-list">
          @foreach($g['items'] as $i)
            <li>
              <a href="{{ route('lkps.tabel.index', $i['slug']) }}">{{ $i['judul'] }}</a>
              <span class="lk-status {{ $i['n'] > 0 ? 'isi' : 'kosong' }}">{{ $i['n'] > 0 ? $i['n'] . ' baris' : 'Belum diisi' }}</span>
            </li>
          @endforeach
        </ul>
      </section>
    </div>
  @endforeach
</div>
@endif

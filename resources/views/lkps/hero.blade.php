@php $lkh = \App\Support\LkpsRingkasan::data(); @endphp
@if($lkh['tersedia'])<div><b>{{ $lkh['persen'] }}%</b>Kelengkapan LKPS</div>@endif

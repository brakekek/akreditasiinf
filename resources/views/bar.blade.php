@php $v = (int) $v; $c = $v >= 80 ? 'g' : ($v >= 50 ? 'y' : 'rd'); @endphp
<div class="bw"><div class="bar"><div class="fill {{ $c }}" style="width:{{ $v }}%"></div></div><span>{{ $v }}%</span></div>

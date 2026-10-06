@extends('layout')
@section('title', $def['judul'])

@section('content')
@include('lkps._gaya')
<div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-3">
    <div>
        <p class="lk-crumb"><a href="{{ route('lkps.daftar') }}" class="link-secondary">LKPS</a> / {{ $kelompok }}</p>
        <h1>{{ $def['judul'] }}</h1>
        @if (! empty($def['keterangan']))
            <p class="small text-secondary mb-0 mt-1">{{ $def['keterangan'] }}</p>
        @endif
    </div>
    <div class="d-flex gap-2">
        <a href="{{ route('lkps.tabel.export', $tabel) }}" class="btn btn-sm btn-outline-secondary">
            Ekspor CSV
        </a>
        @auth
            <a href="{{ route('lkps.tabel.create', $tabel) }}" class="btn btn-sm btn-primary">
                Tambah data
            </a>
        @endauth
    </div>
</div>

<form method="GET" class="d-flex gap-2 mb-3" style="max-width: 420px" role="search">
    <label for="cari" class="visually-hidden">Cari di tabel ini</label>
    <input id="cari" name="q" value="{{ $cari }}" class="form-control form-control-sm" placeholder="Cari di tabel ini">
    <button class="btn btn-sm btn-outline-secondary">Cari</button>
    @if ($cari !== '')
        <a href="{{ route('lkps.tabel.index', $tabel) }}" class="btn btn-sm btn-link">Reset</a>
    @endif
</form>

@if ($rows->isEmpty())
    <div class="lk-panel text-center py-5">
        @if ($cari !== '')
            <p class="mb-0">Tidak ada data yang cocok dengan "{{ $cari }}".</p>
        @else
            <p class="mb-3">Tabel ini belum berisi data.</p>
            @auth
                <a href="{{ route('lkps.tabel.create', $tabel) }}" class="btn btn-primary">Tambah data pertama</a>
            @else
                <a href="{{ route('login') }}" class="btn btn-outline-secondary">Masuk untuk menambah data</a>
            @endauth
        @endif
    </div>
@else
    <div class="lk-wrap table-responsive">
        <table class="table table-hover align-middle">
            <thead>
            @foreach ($header['baris'] as $i => $baris)
                <tr>
                    @if ($i === 0)
                        <th rowspan="{{ $header['depth'] }}">No</th>
                    @endif
                    @foreach ($baris as $c)
                        <th colspan="{{ $c['colspan'] }}" rowspan="{{ $c['rowspan'] }}" @class(['text-center' => $c['colspan'] > 1])>{{ $c['label'] }}</th>
                    @endforeach
                    @if ($i === 0)
                        @auth <th rowspan="{{ $header['depth'] }}" class="text-end">Aksi</th> @endauth
                    @endif
                </tr>
            @endforeach
            </thead>
            <tbody>
            @foreach ($rows as $row)
                <tr>
                    <td>{{ $rows->firstItem() + $loop->index }}</td>
                    @foreach ($kolom as $n => $k)
                        @php $v = $row->$n; @endphp
                        <td>
                            @if ($k['type'] === 'check')
                                {{ $v ? '√' : '' }}
                            @elseif ($v === null || $v === '')
                                <span class="text-secondary">–</span>
                            @elseif ($k['type'] === 'file')
                                <a href="{{ \App\Support\Lkps::urlLampiran($tabel, $row->id, $n) }}" target="_blank" rel="noopener" class="text-nowrap">
                                    Lihat bukti
                                </a>
                            @elseif ($k['type'] === 'url' && preg_match('#^https?://#i', $v))
                                <a href="{{ $v }}" target="_blank" rel="noopener">Buka tautan</a>
                            @elseif ($k['type'] === 'textarea')
                                {{ \Illuminate\Support\Str::limit($v, 80) }}
                            @elseif (in_array($k['type'], ['number', 'decimal'], true))
                                {{ \App\Support\Lkps::angka($v) }}
                            @else
                                {{ $v }}
                            @endif
                        </td>
                    @endforeach
                    @auth
                        <td class="text-end text-nowrap">
                            <a href="{{ route('lkps.tabel.edit', [$tabel, $row->id]) }}" class="btn btn-sm btn-outline-secondary">Ubah</a>
                            <form method="POST" action="{{ route('lkps.tabel.destroy', [$tabel, $row->id]) }}" class="d-inline"
                                  onsubmit="return confirm('Hapus baris ini? Data tidak bisa dikembalikan.')">
                                @csrf
                                @method('DELETE')
                                <button class="btn btn-sm btn-outline-danger">Hapus</button>
                            </form>
                        </td>
                    @endauth
                </tr>
            @endforeach
            </tbody>
            @if ($ringkasan)
                <tfoot>
                @foreach ($ringkasan as $labelRingkasan => $nilai)
                    <tr class="ringkasan">
                        <th>{{ $labelRingkasan }}</th>
                        @foreach ($kolom as $n => $k)
                            <td>{{ array_key_exists($n, $nilai) && $nilai[$n] !== null ? \App\Support\Lkps::angka($nilai[$n]) : '' }}</td>
                        @endforeach
                        @auth <td></td> @endauth
                    </tr>
                @endforeach
                </tfoot>
            @endif
        </table>
    </div>
    <div class="mt-3">{{ $rows->links('pagination::bootstrap-5') }}</div>
@endif
@endsection

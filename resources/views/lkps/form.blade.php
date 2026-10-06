@extends('layout')
@section('title', ($row ? 'Ubah data' : 'Tambah data') . ' - ' . $def['judul'])

@section('content')
@include('lkps._gaya')
<p class="lk-crumb"><a href="{{ route('lkps.daftar') }}" class="link-secondary">LKPS</a> / {{ $kelompok }} / {{ $def['judul'] }}</p>
<h1 class="mb-3">{{ $row ? 'Ubah data' : 'Tambah data' }}</h1>

<form method="POST" enctype="multipart/form-data" class="lk-panel" style="max-width: 760px"
      action="{{ $row ? route('lkps.tabel.update', [$tabel, $row->id]) : route('lkps.tabel.store', $tabel) }}">
    @csrf
    @if ($row) @method('PUT') @endif

    @foreach ($kolom as $n => $k)
        @php
            $nilai = old($n, data_get($row, $n));
            $wajib = str_contains($k['rules'], 'required') && ! ($k['type'] === 'file' && $row);
            $tipeInput = ['number' => 'number', 'decimal' => 'number', 'date' => 'date'][$k['type']] ?? 'text';
            $otomatis = array_key_exists($n, $def['total'] ?? []);
        @endphp
        @if ($k['type'] === 'check')
            <div class="form-check mb-3">
                <input type="hidden" name="{{ $n }}" value="0">
                <input class="form-check-input" type="checkbox" id="f_{{ $n }}" name="{{ $n }}" value="1" @checked($nilai)>
                <label class="form-check-label fw-semibold" for="f_{{ $n }}">{{ $k['label'] }}</label>
            </div>
            @continue
        @endif
        <div class="mb-3">
            <label for="f_{{ $n }}" class="form-label fw-semibold">
                {{ $k['label'] }} @if ($wajib)<span class="text-danger" aria-hidden="true">*</span>@endif
            </label>

            @if ($k['type'] === 'textarea')
                <textarea id="f_{{ $n }}" name="{{ $n }}" rows="3" @if ($wajib) required @endif
                          class="form-control @error($n) is-invalid @enderror">{{ $nilai }}</textarea>
            @elseif ($k['type'] === 'select')
                <select id="f_{{ $n }}" name="{{ $n }}" @if ($wajib) required @endif
                        class="form-select @error($n) is-invalid @enderror">
                    <option value="">Pilih salah satu</option>
                    @foreach ($k['options'] as $opsi)
                        <option value="{{ $opsi }}" @selected((string) $nilai === (string) $opsi)>{{ $opsi }}</option>
                    @endforeach
                </select>
            @elseif ($k['type'] === 'file')
                <input id="f_{{ $n }}" name="{{ $n }}" type="file" @if ($wajib) required @endif
                       accept=".pdf,.jpg,.jpeg,.png,.webp,application/pdf,image/*"
                       class="form-control @error($n) is-invalid @enderror">
                <div class="form-text">
                    PDF atau gambar (JPG, PNG, WEBP), maksimal {{ \App\Support\Lkps::MAKS_LAMPIRAN_KB / 1024 }} MB.
                    Lampiran dibuka sebagai pratinjau di browser, bukan diunduh.
                </div>
                @if (\App\Support\Lkps::batasServerMb() < \App\Support\Lkps::MAKS_LAMPIRAN_KB / 1024)
                    <div class="form-text text-danger">
                        Pengaturan PHP server saat ini hanya menerima berkas hingga
                        {{ \App\Support\Lkps::angka(\App\Support\Lkps::batasServerMb()) }} MB.
                        Naikkan upload_max_filesize dan post_max_size (lihat README, bagian batas unggah).
                    </div>
                @endif
                @if ($row && data_get($row, $n))
                    <div class="d-flex flex-wrap align-items-center gap-3 mt-2 small">
                        <a href="{{ \App\Support\Lkps::urlLampiran($tabel, $row->id, $n) }}" target="_blank" rel="noopener">
                            Lihat lampiran saat ini
                        </a>
                        <div class="form-check mb-0">
                            <input class="form-check-input" type="checkbox" name="hapus_{{ $n }}" value="1" id="hapus_{{ $n }}">
                            <label class="form-check-label" for="hapus_{{ $n }}">Hapus lampiran</label>
                        </div>
                        <span class="text-secondary">Pilih berkas baru untuk mengganti.</span>
                    </div>
                @endif
            @elseif ($otomatis)
                <input id="f_{{ $n }}" type="text" value="{{ $nilai }}" class="form-control" readonly>
                <div class="form-text">Dihitung otomatis saat data disimpan.</div>
            @else
                <input id="f_{{ $n }}" name="{{ $n }}" type="{{ $tipeInput }}" value="{{ $nilai }}"
                       @if ($k['type'] === 'decimal') step="0.01" @endif
                       @if ($k['type'] === 'number') step="1" min="0" @endif
                       @if ($wajib) required @endif
                       class="form-control @error($n) is-invalid @enderror">
            @endif

            @error($n)
                <div class="invalid-feedback d-block">{{ $message }}</div>
            @enderror
        </div>
    @endforeach

    <div class="d-flex gap-2 pt-2">
        <button class="btn btn-primary">{{ $row ? 'Simpan perubahan' : 'Simpan data' }}</button>
        <a href="{{ route('lkps.tabel.index', $tabel) }}" class="btn btn-outline-secondary">Batal</a>
    </div>
</form>
@endsection

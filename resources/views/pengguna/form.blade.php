@extends('layout')
@section('title', $u->exists ? 'Ubah Pengguna' : 'Tambah Pengguna')
@section('content')
<h1 class="mb-3">{{ $u->exists ? 'Ubah' : 'Tambah' }} pengguna</h1>
<form method="post" class="card card-body" style="max-width:560px" autocomplete="off"
      action="{{ $u->exists ? route('pengguna.update', $u) : route('pengguna.store') }}">
  @csrf @if($u->exists) @method('PUT') @endif
  <div class="mb-3"><label class="form-label">Nama</label><input name="name" class="form-control" value="{{ old('name', $u->name) }}" required></div>
  <div class="mb-3"><label class="form-label">Email</label><input type="email" name="email" class="form-control" value="{{ old('email', $u->email) }}" required></div>
  <div class="mb-3"><label class="form-label">Kata sandi{{ $u->exists ? ' baru' : '' }}</label><input type="password" name="password" class="form-control" minlength="8" autocomplete="new-password" {{ $u->exists ? '' : 'required' }}>
    @if($u->exists)<div class="form-text">Kosongkan jika tidak ingin mengganti kata sandi.</div>@else<div class="form-text">Minimal 8 karakter.</div>@endif</div>
  <div class="mb-3"><label class="form-label">Ulangi kata sandi</label><input type="password" name="password_confirmation" class="form-control" autocomplete="new-password"></div>
  <div><button class="btn btn-primary">Simpan</button> <a href="{{ route('pengguna.index') }}" class="btn btn-link">Batal</a></div>
</form>
@endsection

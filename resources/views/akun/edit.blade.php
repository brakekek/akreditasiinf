@extends('layout')
@section('title', 'Akun Saya')
@section('content')
<h1 class="mb-3">Akun saya</h1>
<form method="post" action="{{ route('akun.update') }}" class="card card-body" style="max-width:560px" autocomplete="off">
  @csrf @method('PUT')
  <div class="mb-3"><label class="form-label">Nama</label><input name="name" class="form-control" value="{{ old('name', $u->name) }}" required></div>
  <div class="mb-3"><label class="form-label">Email</label><input type="email" name="email" class="form-control" value="{{ old('email', $u->email) }}" required></div>
  <hr>
  <p class="text-muted small mb-2">Ganti kata sandi (kosongkan jika tidak ingin mengganti).</p>
  <div class="mb-3"><label class="form-label">Kata sandi lama</label><input type="password" name="password_lama" class="form-control" autocomplete="current-password"></div>
  <div class="mb-3"><label class="form-label">Kata sandi baru</label><input type="password" name="password" class="form-control" minlength="8" autocomplete="new-password"></div>
  <div class="mb-3"><label class="form-label">Ulangi kata sandi baru</label><input type="password" name="password_confirmation" class="form-control" autocomplete="new-password"></div>
  <div><button class="btn btn-primary">Simpan</button> <a href="{{ route('dashboard') }}" class="btn btn-link">Batal</a></div>
</form>
@endsection

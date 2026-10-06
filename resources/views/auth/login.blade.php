@extends('layout')
@section('title', 'Masuk')
@section('content')
<div class="row justify-content-center"><div class="col-md-5">
  <h4 class="mb-3">Masuk</h4>
  <p class="text-muted">Login diperlukan untuk menambah, mengubah, dan menghapus data.</p>
  <form method="post" action="{{ route('login') }}" class="card card-body">
    @csrf
    <div class="mb-3"><label class="form-label">Email</label><input type="email" name="email" class="form-control" value="{{ old('email') }}" required autofocus></div>
    <div class="mb-3"><label class="form-label">Kata sandi</label><input type="password" name="password" class="form-control" required></div>
    <div class="form-check mb-3"><input type="checkbox" name="remember" value="1" class="form-check-input" id="remember"><label for="remember" class="form-check-label">Ingat saya</label></div>
    <button class="btn btn-primary">Masuk</button>
  </form>
</div></div>
@endsection

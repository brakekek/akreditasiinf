@extends('layout')
@section('title', 'Kelola Pengguna')
@section('content')
<div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
  <div><h1 class="mb-0">Kelola Pengguna</h1><div class="text-muted small">Administrasi &middot; {{ $users->count() }} akun</div></div>
  <a href="{{ route('pengguna.create') }}" class="btn btn-primary">Tambah pengguna</a>
</div>
<form method="get" class="mb-3"><input type="search" name="q" value="{{ $q }}" class="form-control" style="max-width:380px" placeholder="Cari nama atau email..."></form>
<div class="card"><div class="table-responsive"><table class="table align-middle mb-0">
  <thead><tr><th>Nama</th><th>Email</th><th>Peran</th><th>Dibuat</th><th class="text-end">Aksi</th></tr></thead>
  <tbody>
  @forelse($users as $u)
    <tr>
      <td class="fw-medium">{{ $u->name }} @if($u->id == auth()->id())<span class="badge text-bg-light border">Anda</span>@endif</td>
      <td>{{ $u->email }}</td>
      <td>@if(\App\Http\Middleware\HanyaAdmin::adalahAdmin($u))<span class="badge text-bg-primary">Admin</span>@else<span class="badge text-bg-secondary">Pengguna</span>@endif</td>
      <td class="small text-muted">{{ optional($u->created_at)->format('d/m/Y') }}</td>
      <td class="text-end text-nowrap">
        <a href="{{ route('pengguna.edit', $u) }}" class="btn btn-sm btn-outline-secondary">Ubah</a>
        @if($u->id != auth()->id() && $u->id != 1)
        <form action="{{ route('pengguna.destroy', $u) }}" method="post" class="d-inline" onsubmit="return confirm('Hapus pengguna ini?')">@csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Hapus</button></form>
        @endif
      </td>
    </tr>
  @empty
    <tr><td colspan="5" class="text-center text-muted py-4">Tidak ada pengguna.</td></tr>
  @endforelse
  </tbody>
</table></div></div>
<p class="text-muted small mt-2">Admin = akun utama (id 1) dan email yang terdaftar pada ADMIN_EMAILS di berkas .env. Hanya admin yang melihat menu ini.</p>
@endsection

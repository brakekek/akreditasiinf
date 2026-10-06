<?php
use App\Http\Controllers\{AuthController, DashboardController, KriteriaController, IsiKriteriaController, DokumenController};
use Illuminate\Support\Facades\Route;

// Login / logout
Route::middleware('guest')->group(function () {
    Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
    Route::post('/login', [AuthController::class, 'login'])->middleware('throttle:5,1');
});
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth')->name('logout');

// Wajib login: tambah, ubah, hapus (HARUS dideklarasikan sebelum rute publik agar /create tidak tertangkap {param})
Route::middleware('auth')->group(function () {
    Route::resource('kriteria', KriteriaController::class)->except(['index', 'show'])->parameters(['kriteria' => 'kriteria']);
    Route::resource('isi', IsiKriteriaController::class)->except(['index', 'show'])->parameters(['isi' => 'isi']);
    Route::resource('dokumen', DokumenController::class)->only(['create', 'store', 'edit', 'update', 'destroy'])->parameters(['dokumen' => 'dokumen']);
    Route::post('/unggah-gambar', [IsiKriteriaController::class, 'unggahGambar'])->name('unggah.gambar');
});

// Publik: hanya baca
Route::get('/', [DashboardController::class, 'index'])->name('dashboard');
Route::resource('kriteria', KriteriaController::class)->only(['index', 'show'])->parameters(['kriteria' => 'kriteria']);
Route::resource('isi', IsiKriteriaController::class)->only(['show'])->parameters(['isi' => 'isi']);

// ===== Data Induk: baca publik, tambah/ubah/hapus wajib login =====
Route::redirect('/data-induk', '/data-induk/standar-mutu');
Route::prefix('data-induk')->where(['kategori' => implode('|', array_keys(\App\Support\DataInduk::KATEGORI)), 'id' => '[0-9a-fA-F-]{36}'])->group(function () {
    Route::middleware('auth')->group(function () {
        Route::get('{kategori}/create', [\App\Http\Controllers\DataIndukController::class, 'create'])->name('datainduk.create');
        Route::post('{kategori}', [\App\Http\Controllers\DataIndukController::class, 'store'])->name('datainduk.store');
        Route::get('{kategori}/{id}/edit', [\App\Http\Controllers\DataIndukController::class, 'edit'])->name('datainduk.edit');
        Route::put('{kategori}/{id}', [\App\Http\Controllers\DataIndukController::class, 'update'])->name('datainduk.update');
        Route::delete('{kategori}/{id}', [\App\Http\Controllers\DataIndukController::class, 'destroy'])->name('datainduk.destroy');
    });
    Route::get('{kategori}', [\App\Http\Controllers\DataIndukController::class, 'index'])->name('datainduk.index');
});

// ===== Akun saya (semua pengguna login) & Kelola Pengguna (khusus admin) =====
Route::middleware('auth')->group(function () {
    Route::get('/akun', [\App\Http\Controllers\AkunController::class, 'edit'])->name('akun.edit');
    Route::put('/akun', [\App\Http\Controllers\AkunController::class, 'update'])->name('akun.update');
});
Route::middleware(['auth', \App\Http\Middleware\HanyaAdmin::class])
    ->resource('pengguna', \App\Http\Controllers\PenggunaController::class)
    ->except('show')->parameters(['pengguna' => 'pengguna']);

// ===== Gunakan dokumen yang sudah pernah diunggah (wajib login) =====
Route::post('/dokumen-dari-arsip', [\App\Http\Controllers\DokumenArsipController::class, 'store'])
    ->middleware('auth')->name('dokumen.arsip');

// ===== Lihat / pratinjau dokumen (publik) =====
Route::get('/lihat/data-induk/{kategori}/{id}', [\App\Http\Controllers\LihatController::class, 'dataInduk'])
    ->where(['kategori' => implode('|', array_keys(\App\Support\DataInduk::KATEGORI)), 'id' => '[0-9a-fA-F-]{36}'])
    ->name('lihat.datainduk');
Route::get('/lihat/dokumen/{id}', [\App\Http\Controllers\LihatController::class, 'dokumen'])
    ->whereNumber('id')->name('lihat.dokumen');

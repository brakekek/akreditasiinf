# Sistem Informasi Akreditasi Program Studi Teknologi Informasi

Aplikasi web untuk mengelola dokumen dan narasi akreditasi Program Studi Teknologi Informasi, Sekolah Vokasi Universitas Tiga Serangkai, mengacu pada instrumen **LAM Infokom**.

Dibangun dengan **Laravel 11** (PHP 8.2+).

## Fitur

- **Kriteria Akreditasi**: daftar kriteria beserta isi/narasi tiap kriteria (editor TinyMCE, mendukung unggah gambar).
- **Dokumen Pendukung**: unggah berkas (PDF, Office, ZIP, JPG/PNG, maks. 20 MB) atau tautan untuk setiap isi kriteria, serta pakai ulang dokumen yang sudah pernah diunggah.
- **Data Induk**: Dokumen Standar Mutu, Universitas, Fakultas, dan Tambahan (disimpan sebagai JSON di `storage/app/data-induk/`, tanpa tabel database).
- **Pratinjau Dokumen**: tautan "Lihat" untuk PDF, gambar, dan Office tanpa unduhan langsung.
- **Dashboard** capaian pengisian kriteria.
- **Hak akses**: halaman bisa dibaca publik; tambah/ubah/hapus wajib login. Kelola Pengguna khusus admin; setiap pengguna dapat mengubah Akun Saya.
- **LKPS** (Laporan Kinerja Program Studi): isian, lampiran, dan impor/ekspor Excel. *Masih dalam pengembangan, rutenya belum didaftarkan di `routes/web.php`.*

## Kebutuhan

- PHP 8.2+ dengan ekstensi `pdo_mysql`, `mbstring`, `fileinfo`, `zip`, `gd`
- Composer 2
- MySQL/MariaDB
- Node.js 18+ (opsional, hanya untuk build aset Vite)

## Instalasi

```bash
git clone git@github.com:brakekek/akreditasiinf.git
cd akreditasiinf

composer install
cp .env.example .env
php artisan key:generate
```

Atur koneksi database di `.env`:

```env
APP_NAME="Akreditasi TI"
APP_URL=http://akreditasi.test
APP_TIMEZONE=Asia/Jakarta
APP_LOCALE=id

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=akreditasi
DB_USERNAME=root
DB_PASSWORD=
```

Buat database `akreditasi`, lalu:

```bash
php artisan migrate
php artisan db:seed --class=AdminSeeder
php artisan storage:link
php artisan serve
```

Buka http://127.0.0.1:8000 (atau `http://akreditasi.test` bila memakai Laragon).

### Alternatif: import database dari file SQL

Repositori ini menyertakan hasil export database di `database/akreditasi.sql`, berisi struktur semua tabel beserta data kriteria, isi kriteria, dan pengguna. Gunakan cara ini **sebagai pengganti** `php artisan migrate` dan `db:seed` di atas.

1. Buat database kosong:

   ```bash
   mysql -u root -p -e "CREATE DATABASE akreditasi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
   ```

2. Import file SQL:

   ```bash
   mysql -u root -p akreditasi < database/akreditasi.sql
   ```

   Di Laragon, jalankan perintah di atas dari *Terminal* Laragon (pengguna `root` tanpa kata sandi, jadi `-p` boleh dihilangkan). Bisa juga lewat phpMyAdmin/HeidiSQL: pilih database `akreditasi` → *Import* → pilih `database/akreditasi.sql`.

3. Lanjutkan dengan:

   ```bash
   php artisan storage:link
   php artisan serve
   ```

Login memakai akun yang ada di database hasil import. Berkas unggahan (dokumen pendukung, gambar narasi) tidak ikut di file SQL; salin folder `storage/app/` dari server asal bila diperlukan.

Untuk memperbarui file export dari database lokal:

```bash
mysqldump -u root --routines --triggers --no-tablespaces akreditasi > database/akreditasi.sql
```

### Akun admin awal

| Email               | Kata sandi         |
|---------------------|--------------------|
| `admin@example.com` | `GantiSandiIni123` |

> **Segera ganti kata sandi** melalui menu *Akun Saya* setelah login pertama.

### Batas unggah 20 MB

Pastikan `php.ini` mengizinkan berkas besar:

```ini
upload_max_filesize = 20M
post_max_size = 25M
```

## Deploy ke produksi

```bash
composer install --no-dev --optimize-autoloader
php artisan migrate --force
php artisan storage:link
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

Atur `APP_ENV=production` dan `APP_DEBUG=false` di `.env`, arahkan document root web server ke folder `public/`, dan pastikan `storage/` serta `bootstrap/cache/` dapat ditulis oleh web server.

## Installer otomatis

`akreditasi-installer.sh` memasang seluruh fitur ke proyek Laravel 11 yang **masih baru**. Tidak perlu dijalankan pada repositori ini karena kodenya sudah terpasang.

```bash
bash akreditasi-installer.sh --help
```

## Struktur penting

```
app/Http/Controllers/   Controller (Kriteria, IsiKriteria, Dokumen, DataInduk, Lkps*, Pengguna, ...)
app/Support/            Helper DataInduk, Lkps, SumberDokumen
app/Models/             Kriteria, IsiKriteria, Dokumen, User
database/migrations/    Tabel akreditasi & LKPS
database/seeders/       AdminSeeder
database/akreditasi.sql Export database (struktur + data)
resources/views/        Blade view per modul
routes/web.php          Definisi rute
```

## Lisensi

Proyek internal Program Studi Teknologi Informasi, Sekolah Vokasi Universitas Tiga Serangkai. Dibangun di atas [Laravel](https://laravel.com) (lisensi MIT).

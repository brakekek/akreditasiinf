<?php
/*
|--------------------------------------------------------------------------
| Definisi 31 tabel LKPS LAM Infokom (Program Diploma III)
|--------------------------------------------------------------------------
| Mengikuti template "Data_DKPS_TI-D3_2025_New.xlsx": satu tabel database
| per sheet, kolom dan urutannya sama dengan kolom di template.
|
| Format kolom:  'nama_kolom' => [Label, tipe, aturan_validasi, opsi_select]
|   - Label bertingkat ditulis dengan "|" seperti header Excel bertingkat,
|     mis. 'Jumlah Mahasiswa Baru|Reguler|Diterima'.
|   - Tipe: text, textarea, number, decimal, date, select, check, url, file
|     check = kotak centang, ditampilkan dan diekspor sebagai √
|     url   = tautan/teks (mis. Tugas Pokok dan Fungsi)
|   Setiap tabel otomatis mendapat kolom "Lampiran Bukti" (unggah PDF/gambar,
|   dibuka sebagai pratinjau). Kolom Link Bukti di template Excel diisi dengan
|   link pratinjau lampiran tersebut saat ekspor.
| 'ringkasan' => ['jumlah'] / ['jumlah', 'rata'] menampilkan baris Jumlah
|   (dan Rata-rata) di bawah tabel, seperti di template.
| Setelah mengedit, jalankan:  php artisan lkps:sinkron
*/

$ts3   = ['TS-2', 'TS-1', 'TS'];
$ts4   = ['TS-3', 'TS-2', 'TS-1', 'TS'];
$lni   = ['L', 'N', 'I'];

// Tiga kolom TS-2/TS-1/TS dengan grup header opsional.
$perTs = function (string $grup = '', string $tipe = 'number', string $prefix = '') {
    $g = $grup !== '' ? $grup . '|' : '';
    return [
        $prefix . 'ts2' => [$g . 'TS-2', $tipe, 'nullable'],
        $prefix . 'ts1' => [$g . 'TS-1', $tipe, 'nullable'],
        $prefix . 'ts'  => [$g . 'TS', $tipe, 'nullable'],
    ];
};

$sarpras = [
    'nama_prasarana' => ['Nama Prasarana', 'text', 'required'],
    'daya_tampung'   => ['Daya Tampung', 'number', 'nullable'],
    'luas_ruang'     => ['Luas Ruang (m²)', 'decimal', 'nullable'],
    'kepemilikan'    => ['Milik Sendiri (M)/Sewa (W)', 'select', 'nullable', ['M', 'W']],
    'lisensi'        => ['Berlisensi (L)/Public Domain (P)/Tidak Berlisensi (T)', 'select', 'nullable', ['L', 'P', 'T']],
    'perangkat'      => ['Perangkat', 'textarea', 'nullable'],
];

$hibah = fn (string $ketua, string $judul, string $jenis) => array_merge([
    'nama_dtpr'        => [$ketua, 'text', 'required'],
    'judul'            => [$judul, 'text', 'required'],
    'jumlah_mahasiswa' => ['Jumlah Mahasiswa yang Terlibat', 'number', 'nullable'],
    'jenis_hibah'      => [$jenis, 'text', 'nullable'],
    'sumber'           => ['Sumber|L/N/I', 'select', 'nullable', $lni],
    'durasi'           => ['Durasi (tahun)', 'decimal', 'nullable'],
], $perTs('Pendanaan (Rp juta)', 'decimal', 'dana_'));

$kerjasama = array_merge([
    'judul_kerjasama' => ['Judul Kerja Sama', 'text', 'required'],
    'mitra'           => ['Mitra Kerja Sama', 'text', 'required'],
    'sumber'          => ['Sumber|L/N/I', 'select', 'nullable', $lni],
    'durasi'          => ['Durasi (tahun)', 'text', 'nullable'],
], $perTs('Pendanaan (Rp juta)', 'decimal', 'dana_'));

$hki = array_merge([
    'judul'     => ['Judul', 'text', 'required'],
    'jenis_hki' => ['Jenis HKI', 'text', 'required'],
    'nama_dtpr' => ['Nama DTPR', 'text', 'required'],
], $perTs('Tahun Perolehan (√)', 'check'));

$pl = [];
foreach (range(1, 5) as $i) {
    $pl["pl{$i}"] = ["Profil Lulusan (PL)|PL {$i}", 'check', 'nullable'];
}

return [

    'tahun_ts' => env('LKPS_TAHUN_TS', '2025/2026'),

    'kelompok' => [
        'k1' => 'Tabel 1: Pimpinan, Keuangan, SDM & SPMI',
        'k2' => 'Tabel 2: Mahasiswa, Pembelajaran & Lulusan',
        'k3' => 'Tabel 3: Penelitian',
        'k4' => 'Tabel 4: Pengabdian kepada Masyarakat',
        'k5' => 'Tabel 5: Tata Kelola & Sarana Pendidikan',
        'k6' => 'Tabel 6: Visi dan Misi',
    ],

    /*
    | Isian di luar 31 tabel: sheet Identitas dan baris "Jumlah Dosen DTPR"
    | pada Tabel 3.A.3. Format: kunci => [Label, tipe, sheet, sel].
    */
    'isian' => [
        'Identitas Program Studi' => [
            'perguruan_tinggi'   => ['Perguruan Tinggi', 'text', 'Identitas', 'C6'],
            'upps'               => ['Unit Pengelola Program Studi', 'text', 'Identitas', 'C8'],
            'jenis_program'      => ['Jenis Program', 'text', 'Identitas', 'C10'],
            'nama_ps'            => ['Nama Program Studi', 'text', 'Identitas', 'C12'],
            'alamat'             => ['Alamat', 'text', 'Identitas', 'C14'],
            'telepon'            => ['Nomor Telepon', 'text', 'Identitas', 'C16'],
            'email_web'          => ['E-Mail dan Website', 'text', 'Identitas', 'C18'],
            'sk_pendirian_pt'    => ['Nomor SK Pendirian PT', 'text', 'Identitas', 'G6'],
            'tgl_sk_pendirian'   => ['Tanggal SK Pendirian PT', 'text', 'Identitas', 'G8'],
            'tahun_pertama'      => ['Tahun Pertama Menerima Mahasiswa', 'text', 'Identitas', 'G10'],
            'akreditasi_ps'      => ['Akreditasi PS', 'text', 'Identitas', 'G12'],
            'sk_akreditasi'      => ['Nomor SK BAN-PT/LAM', 'text', 'Identitas', 'G14'],
        ],
        'Tabel 3.A.3 Jumlah Dosen DTPR' => [
            'dtpr_ts2' => ['Jumlah Dosen DTPR TS-2', 'number', 'Tabel 3.A.3', 'C5'],
            'dtpr_ts1' => ['Jumlah Dosen DTPR TS-1', 'number', 'Tabel 3.A.3', 'D5'],
            'dtpr_ts'  => ['Jumlah Dosen DTPR TS', 'number', 'Tabel 3.A.3', 'E5'],
        ],
    ],

    'tabel' => [

        // ======================= TABEL 1 =======================
        't1a1_pimpinan' => [
            'judul' => '1.A.1 Tabel Pimpinan dan Tupoksi UPPS dan PS', 'kelompok' => 'k1',
            'kolom' => [
                'unit_kerja'          => ['Unit Kerja', 'text', 'required'],
                'nama_ketua'          => ['Nama Ketua', 'text', 'required'],
                'periode_jabatan'     => ['Periode Jabatan', 'text', 'nullable'],
                'pendidikan_terakhir' => ['Pendidikan Terakhir', 'select', 'nullable', ['Diploma', 'Sarjana', 'Magister', 'Doktor', '-']],
                'jabatan_fungsional'  => ['Jabatan Fungsional', 'select', 'nullable', ['-', 'Tenaga Pengajar', 'Asisten Ahli', 'Lektor', 'Lektor Kepala', 'Guru Besar']],
                'tupoksi'             => ['Tugas Pokok dan Fungsi', 'url', 'nullable'],
            ],
        ],
        't1a2_sumber_dana' => [
            'judul' => '1.A.2 Sumber Pendanaan UPPS/PS', 'kelompok' => 'k1', 'ringkasan' => ['jumlah'],
            'keterangan' => 'Data ditulis dalam jutaan rupiah.',
            'kolom' => array_merge(
                ['sumber_pendanaan' => ['Sumber Pendanaan', 'text', 'required']],
                $perTs('', 'decimal'),
            ),
        ],
        't1a3_penggunaan_dana' => [
            'judul' => '1.A.3 Penggunaan Dana UPPS/PS', 'kelompok' => 'k1', 'ringkasan' => ['jumlah'],
            'keterangan' => 'Data ditulis dalam jutaan rupiah.',
            'kolom' => array_merge(
                ['penggunaan_dana' => ['Penggunaan Dana', 'text', 'required']],
                $perTs('', 'decimal'),
            ),
        ],
        't1a4_ewmp' => [
            'judul' => '1.A.4 Rata-rata Beban DTPR per semester (EWMP) pada TS', 'kelompok' => 'k1',
            'ringkasan' => ['jumlah', 'rata'],
            'kolom' => [
                'nama_dtpr'                => ['Nama DTPR', 'text', 'required'],
                'sks_ps_sendiri'           => ['SKS Pengajaran pada|PS Sendiri', 'decimal', 'nullable'],
                'sks_ps_lain'              => ['SKS Pengajaran pada|PS Lain, PT Sendiri', 'decimal', 'nullable'],
                'sks_pt_lain'              => ['SKS Pengajaran pada|PT Lain', 'decimal', 'nullable'],
                'sks_penelitian'           => ['SKS Penelitian', 'decimal', 'nullable'],
                'sks_pkm'                  => ['SKS Pengabdian kepada Masyarakat', 'decimal', 'nullable'],
                'sks_manajemen_pt_sendiri' => ['SKS Manajemen|PT Sendiri', 'decimal', 'nullable'],
                'sks_manajemen_pt_lain'    => ['SKS Manajemen|PT Lain', 'decimal', 'nullable'],
                'total_sks'                => ['Total SKS', 'decimal', 'nullable'],
            ],
            'total' => ['total_sks' => ['sks_ps_sendiri', 'sks_ps_lain', 'sks_pt_lain', 'sks_penelitian', 'sks_pkm', 'sks_manajemen_pt_sendiri', 'sks_manajemen_pt_lain']],
        ],
        't1a5_tendik' => [
            'judul' => '1.A.5 Kualifikasi Tenaga Kependidikan', 'kelompok' => 'k1', 'ringkasan' => ['jumlah'],
            'kolom' => array_merge(
                ['jenis' => ['Jenis Tenaga Kependidikan', 'select', 'required', ['Pustakawan', 'Laboran/Teknisi', 'Administrasi', 'Lainnya']]],
                (function () {
                    $k = [];
                    foreach (['s3' => 'S3', 's2' => 'S2', 's1' => 'S1', 'd4' => 'D4', 'd3' => 'D3', 'd2' => 'D2', 'd1' => 'D1', 'sma' => 'SMA/SMK/MA', 'smp' => 'SMP', 'sd' => 'SD'] as $n => $l) {
                        $k[$n] = ["Jumlah Tenaga Kependidikan dengan Pendidikan Terakhir|{$l}", 'number', 'nullable'];
                    }
                    return $k;
                })(),
                ['unit_kerja' => ['Unit Kerja', 'textarea', 'nullable']],
            ),
        ],
        't1b_spmi' => [
            'judul' => '1.B Tabel Unit SPMI dan SDM', 'kelompok' => 'k1',
            'kolom' => [
                'unit_spmi'             => ['Unit SPMI', 'select', 'required', ['Universitas/PT', 'UPPS', 'Program Studi']],
                'nama_unit'             => ['Nama Unit SPMI', 'text', 'required'],
                'dokumen_spmi'          => ['Dokumen SPMI', 'textarea', 'nullable'],
                'auditor_internal'      => ['Jumlah Auditor Mutu|Internal', 'number', 'nullable'],
                'auditor_certified'     => ['Jumlah Auditor Mutu|Certified', 'number', 'nullable'],
                'auditor_non_certified' => ['Jumlah Auditor Mutu|Non Certified', 'number', 'nullable'],
                'frekuensi_audit'       => ['Frekuensi Audit/Monev per Tahun', 'text', 'nullable'],
                'bukti_certified'       => ['Bukti Certified Auditor', 'url', 'nullable'],
                'laporan_audit'         => ['Laporan Audit', 'textarea', 'nullable'],
            ],
        ],

        // ======================= TABEL 2 =======================
        't2a1_data_mahasiswa' => [
            'judul' => '2.A.1 Data Mahasiswa', 'kelompok' => 'k2', 'ringkasan' => ['jumlah'],
            'kolom' => [
                'ts'                         => ['TS', 'select', 'required', $ts4],
                'daya_tampung'               => ['Daya Tampung', 'number', 'nullable'],
                'pendaftar'                  => ['Jumlah Calon Mahasiswa|Pendaftar', 'number', 'nullable'],
                'pendaftar_afirmasi'         => ['Jumlah Calon Mahasiswa|Pendaftar Afirmasi', 'number', 'nullable'],
                'pendaftar_kebutuhan_khusus' => ['Jumlah Calon Mahasiswa|Pendaftar Kebutuhan Khusus', 'number', 'nullable'],
                'baru_reguler'               => ['Jumlah Mahasiswa Baru|Reguler|Diterima', 'number', 'nullable'],
                'baru_reguler_afirmasi'      => ['Jumlah Mahasiswa Baru|Reguler|Afirmasi', 'number', 'nullable'],
                'baru_reguler_kk'            => ['Jumlah Mahasiswa Baru|Reguler|Kebutuhan Khusus', 'number', 'nullable'],
                'baru_rpl'                   => ['Jumlah Mahasiswa Baru|RPL|Diterima', 'number', 'nullable'],
                'baru_rpl_afirmasi'          => ['Jumlah Mahasiswa Baru|RPL|Afirmasi', 'number', 'nullable'],
                'baru_rpl_kk'                => ['Jumlah Mahasiswa Baru|RPL|Kebutuhan Khusus', 'number', 'nullable'],
                'aktif_reguler'              => ['Jumlah Mahasiswa Aktif|Reguler|Diterima', 'number', 'nullable'],
                'aktif_reguler_afirmasi'     => ['Jumlah Mahasiswa Aktif|Reguler|Afirmasi', 'number', 'nullable'],
                'aktif_reguler_kk'           => ['Jumlah Mahasiswa Aktif|Reguler|Kebutuhan Khusus', 'number', 'nullable'],
                'aktif_rpl'                  => ['Jumlah Mahasiswa Aktif|RPL|Diterima', 'number', 'nullable'],
                'aktif_rpl_afirmasi'         => ['Jumlah Mahasiswa Aktif|RPL|Afirmasi', 'number', 'nullable'],
                'aktif_rpl_kk'               => ['Jumlah Mahasiswa Aktif|RPL|Kebutuhan Khusus', 'number', 'nullable'],
            ],
        ],
        't2a2_asal_mahasiswa' => [
            'judul' => '2.A.2 Keragaman Asal Mahasiswa', 'kelompok' => 'k2', 'ringkasan' => ['jumlah'],
            'kolom' => array_merge([
                'kategori' => ['Asal Mahasiswa|Kategori', 'select', 'required', ['Kota/Kab sama dengan PS', 'Kota/Kabupaten Lain', 'Provinsi Lain', 'Negara Lain', 'Afirmasi', 'Berkebutuhan Khusus']],
                'asal'     => ['Asal Mahasiswa|Nama Daerah/Negara', 'text', 'nullable'],
            ], $perTs('Jumlah Mahasiswa Baru')),
        ],
        't2a3_kondisi_mahasiswa' => [
            'judul' => '2.A.3 Kondisi Jumlah Mahasiswa', 'kelompok' => 'k2',
            'kolom' => array_merge([
                'kondisi' => ['Kondisi', 'select', 'required', ['Mahasiswa Baru', 'Mahasiswa Aktif pada saat TS', 'Lulus pada saat TS', 'Mengundurkan Diri/DO pada saat TS']],
            ], $perTs(), [
                'jumlah'     => ['Jumlah', 'number', 'nullable'],
            ]),
            'total' => ['jumlah' => ['ts2', 'ts1', 'ts']],
        ],
        't2b1_isi_pembelajaran' => [
            'judul' => '2.B.1 Tabel Isi Pembelajaran', 'kelompok' => 'k2',
            'kolom' => array_merge([
                'kode_mk'  => ['Kode MK', 'text', 'required'],
                'nama_mk'  => ['Mata Kuliah', 'text', 'required'],
                'sks'      => ['SKS', 'number', 'required'],
                'semester' => ['Semester', 'select', 'required', ['I', 'II', 'III', 'IV', 'V', 'VI']],
            ], $pl),
        ],
        't2b2_cpl_pl' => [
            'judul' => '2.B.2 Pemetaan Capaian Pembelajaran Lulusan dan Profil Lulusan', 'kelompok' => 'k2',
            'kolom' => array_merge(['cpl' => ['CPL', 'text', 'required']], array_map(
                fn ($d) => [str_replace('Profil Lulusan (PL)|', '', $d[0]), $d[1], $d[2]], $pl
            )),
        ],
        't2b3_peta_cpl' => [
            'judul' => '2.B.3 Peta Pemenuhan CPL', 'kelompok' => 'k2',
            'kolom' => [
                'cpl'        => ['CPL', 'text', 'required'],
                'cpmk'       => ['CPMK', 'text', 'nullable'],
                'semester_1' => ['Semester 1', 'text', 'nullable'],
                'semester_2' => ['Semester 2', 'text', 'nullable'],
                'semester_3' => ['Semester 3', 'text', 'nullable'],
                'semester_4' => ['Semester 4', 'text', 'nullable'],
                'semester_5' => ['Semester 5', 'text', 'nullable'],
                'semester_6' => ['Semester 6', 'text', 'nullable'],
            ],
        ],
        't2b4_masa_tunggu' => [
            'judul' => '2.B.4 Rata-rata Masa Tunggu Lulusan untuk Bekerja Pertama Kali', 'kelompok' => 'k2',
            'ringkasan' => ['jumlah'],
            'kolom' => [
                'tahun_lulus'      => ['Tahun Lulus', 'select', 'required', $ts3],
                'jumlah_lulusan'   => ['Jumlah Lulusan', 'number', 'required'],
                'terlacak'         => ['Jumlah Lulusan yang Terlacak', 'number', 'required'],
                'rata_masa_tunggu' => ['Rata-rata Waktu Tunggu (Bulan)', 'decimal', 'nullable'],
            ],
        ],
        't2b5_bidang_kerja' => [
            'judul' => '2.B.5 Kesesuaian Bidang Kerja Lulusan', 'kelompok' => 'k2', 'ringkasan' => ['jumlah'],
            'kolom' => [
                'tahun_lulus'          => ['Tahun Lulus', 'select', 'required', $ts3],
                'jumlah_lulusan'       => ['Jumlah Lulusan', 'number', 'required'],
                'terlacak'             => ['Jumlah Lulusan yang Terlacak', 'number', 'required'],
                'profesi_infokom'      => ['Profesi Kerja Bidang Infokom', 'number', 'nullable'],
                'profesi_non_infokom'  => ['Profesi Kerja Bidang Non Infokom', 'number', 'nullable'],
                'tempat_multinasional' => ['Lingkup Tempat Kerja|Multinasional/Internasional', 'number', 'nullable'],
                'tempat_nasional'      => ['Lingkup Tempat Kerja|Nasional', 'number', 'nullable'],
                'tempat_wirausaha'     => ['Lingkup Tempat Kerja|Wirausaha', 'number', 'nullable'],
            ],
        ],
        't2b6_kepuasan_pengguna' => [
            'judul' => '2.B.6 Kepuasan Pengguna Lulusan', 'kelompok' => 'k2', 'ringkasan' => ['jumlah'],
            'kolom' => [
                'jenis_kemampuan' => ['Jenis Kemampuan', 'select', 'required', [
                    'Kerjasama Tim', 'Keahlian di Bidang Prodi', 'Kemampuan Berbahasa Asing (Inggris)',
                    'Kemampuan Berkomunikasi', 'Pengembangan Diri', 'Kepemimpinan', 'Etos Kerja',
                ]],
                'sangat_baik'   => ['Tingkat Kepuasan Pengguna (%)|Sangat Baik', 'decimal', 'nullable'],
                'baik'          => ['Tingkat Kepuasan Pengguna (%)|Baik', 'decimal', 'nullable'],
                'cukup'         => ['Tingkat Kepuasan Pengguna (%)|Cukup', 'decimal', 'nullable'],
                'kurang'        => ['Tingkat Kepuasan Pengguna (%)|Kurang', 'decimal', 'nullable'],
                'tindak_lanjut' => ['Rencana Tindak Lanjut oleh UPPS/PS', 'textarea', 'nullable'],
            ],
        ],
        't2c_fleksibilitas' => [
            'judul' => '2.C Fleksibilitas Dalam Proses Pembelajaran', 'kelompok' => 'k2',
            'kolom' => array_merge([
                'bentuk' => ['Bentuk Pembelajaran', 'select', 'required', [
                    'Jumlah Mahasiswa Aktif', 'Micro-credensial', 'RPL tipe A-2',
                    'Pembelajaran di PS lain', 'Pembelajaran di PT lain', 'CBL/PBL', 'Lainnya',
                ]],
                'keterangan' => ['Keterangan (jika Lainnya)', 'text', 'nullable'],
            ], $perTs('Jumlah Mahasiswa')),
        ],
        't2d_rekognisi_lulusan' => [
            'judul' => '2.D Rekognisi dan Apresiasi Kompetensi Lulusan', 'kelompok' => 'k2', 'ringkasan' => ['jumlah'],
            'kolom' => array_merge([
                'sumber_rekognisi' => ['Sumber Rekognisi', 'select', 'required', ['Masyarakat', 'Dunia Usaha', 'Dunia Industri', 'Dunia Kerja', 'Lainnya']],
                'jenis_pengakuan'  => ['Jenis Pengakuan Lulusan (Rekognisi)', 'text', 'required'],
            ], $perTs('Tahun Akademik')),
        ],

        // ======================= TABEL 3 =======================
        't3a1_sarpras_penelitian' => [
            'judul' => '3.A.1 Sarana dan Prasarana Penelitian', 'kelompok' => 'k3',
            'kolom' => $sarpras,
        ],
        't3a2_penelitian_dtpr' => [
            'judul' => '3.A.2 Penelitian DTPR, Hibah dan Pembiayaan Penelitian', 'kelompok' => 'k3', 'ringkasan' => ['jumlah'],
            'kolom' => $hibah('Nama DTPR (Ketua)', 'Judul Penelitian', 'Jenis Hibah Penelitian'),
        ],
        't3a3_pengembangan_dtpr' => [
            'judul' => '3.A.3 Pengembangan DTPR di Bidang Penelitian', 'kelompok' => 'k3', 'ringkasan' => ['jumlah'],
            'kolom' => array_merge([
                'jenis_pengembangan' => ['Jenis Pengembangan DTPR', 'text', 'required'],
                'nama_dtpr'          => ['Nama DTPR', 'text', 'required'],
            ], $perTs('Tahun Akademik (√)', 'check')),
        ],
        't3c1_kerjasama_penelitian' => [
            'judul' => '3.C.1 Kerjasama Penelitian', 'kelompok' => 'k3', 'ringkasan' => ['jumlah'],
            'kolom' => $kerjasama,
        ],
        't3c2_publikasi' => [
            'judul' => '3.C.2 Publikasi Penelitian', 'kelompok' => 'k3', 'ringkasan' => ['jumlah'],
            'kolom' => array_merge([
                'nama_dtpr'       => ['Nama DTPR', 'text', 'required'],
                'judul_publikasi' => ['Judul Publikasi', 'text', 'required'],
                'jenis_publikasi' => ['Jenis Publikasi (IB/I/S1–S6/T)', 'select', 'required', ['IB', 'I', 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'T']],
            ], $perTs('Tahun Terbit (√)', 'check')),
        ],
        't3c3_hki_penelitian' => [
            'judul' => '3.C.3 Perolehan HKI (Granted)', 'kelompok' => 'k3', 'ringkasan' => ['jumlah'],
            'kolom' => $hki,
        ],

        // ======================= TABEL 4 =======================
        't4a1_sarpras_pkm' => [
            'judul' => '4.A.1 Sarana dan Prasarana PkM', 'kelompok' => 'k4',
            'kolom' => $sarpras,
        ],
        't4a2_pkm_dtpr' => [
            'judul' => '4.A.2 PkM DTPR, Hibah dan Pembiayaan PkM', 'kelompok' => 'k4', 'ringkasan' => ['jumlah'],
            'kolom' => $hibah('Nama DTPR (Sebagai Ketua PkM)', 'Judul PkM', 'Jenis Hibah PkM'),
        ],
        't4c1_kerjasama_pkm' => [
            'judul' => '4.C.1 Kerjasama PkM', 'kelompok' => 'k4', 'ringkasan' => ['jumlah'],
            'kolom' => $kerjasama,
        ],
        't4c2_diseminasi_pkm' => [
            'judul' => '4.C.2 Diseminasi Hasil PkM', 'kelompok' => 'k4', 'ringkasan' => ['jumlah'],
            'kolom' => array_merge([
                'nama_dtpr'  => ['Nama DTPR', 'text', 'required'],
                'judul'      => ['Judul', 'text', 'required'],
                'diseminasi' => ['Diseminasi Hasil PkM (L/N/I)', 'select', 'required', $lni],
            ], $perTs('Tahun (√)', 'check')),
        ],
        't4c3_hki_pkm' => [
            'judul' => '4.C.3 Perolehan HKI PkM', 'kelompok' => 'k4', 'ringkasan' => ['jumlah'],
            'kolom' => $hki,
        ],

        // ======================= TABEL 5 =======================
        't5_1_tata_kelola' => [
            'judul' => '5.1 Sistem Tata Kelola', 'kelompok' => 'k5',
            'kolom' => [
                'jenis_tata_kelola' => ['Jenis Tata Kelola', 'text', 'required'],
                'nama_sistem'       => ['Nama Sistem Informasi', 'text', 'required'],
                'akses'             => ['Akses (Lokal/Internet)', 'select', 'nullable', ['Lokal', 'Internet']],
                'unit_pengelola'    => ['Unit Kerja/SDM Pengelola', 'text', 'nullable'],
            ],
        ],
        't5_2_sarpras_pendidikan' => [
            'judul' => '5.2 Sarana dan Prasarana Pendidikan', 'kelompok' => 'k5',
            'kolom' => $sarpras,
        ],

        // ======================= TABEL 6 =======================
        't6_visi_misi' => [
            'judul' => '6 Kesesuaian Visi, Misi', 'kelompok' => 'k6',
            'kolom' => [
                'visi_pt'       => ['Visi PT', 'textarea', 'required'],
                'visi_upps'     => ['Visi UPPS', 'textarea', 'required'],
                'visi_keilmuan' => ['Visi Keilmuan PS', 'textarea', 'required'],
                'misi_pt'       => ['Misi PT', 'textarea', 'nullable'],
                'misi_upps'     => ['Misi UPPS', 'textarea', 'nullable'],
            ],
        ],
    ],
];

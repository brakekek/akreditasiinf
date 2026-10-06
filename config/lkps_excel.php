<?php
/*
|--------------------------------------------------------------------------
| Pemetaan tabel LKPS ke template Excel LAM Infokom (Data_DKPS ... .xlsx)
|--------------------------------------------------------------------------
| sheet   : nama sheet di template
| mulai   : baris data pertama
| kolom   : nama_kolom_database => huruf kolom Excel
| no      : kolom nomor urut (opsional)
| kunci   : baris tetap yang dicocokkan berdasarkan label (mis. TS-2, TS-1, TS)
| tetap   : baris khusus untuk satu nilai tertentu (2.C Jumlah Mahasiswa Aktif)
| lainnya : nilai di luar pilihan disimpan sebagai "Lainnya" + keterangan
| mode    : 'asal' (2.A.2, dikelompokkan per kategori) atau 'sel' (Tabel 6)
| lampiran_bukti dipetakan ke kolom "Link Bukti" di template: saat ekspor berisi
| link pratinjau lampiran; saat impor kolom ini dilewati (berkas tidak bisa diimpor).
*/

$sarpras = ['mulai' => 5, 'kolom' => [
    'nama_prasarana' => 'A', 'daya_tampung' => 'B', 'luas_ruang' => 'C', 'kepemilikan' => 'D',
    'lisensi' => 'E', 'perangkat' => 'F', 'lampiran_bukti' => 'H',
]];
$hibah = ['mulai' => 6, 'no' => 'A', 'kolom' => [
    'nama_dtpr' => 'B', 'judul' => 'C', 'jumlah_mahasiswa' => 'D', 'jenis_hibah' => 'E', 'sumber' => 'F',
    'durasi' => 'G', 'dana_ts2' => 'H', 'dana_ts1' => 'I', 'dana_ts' => 'J', 'lampiran_bukti' => 'K',
]];
$kerjasama = ['mulai' => 6, 'no' => 'A', 'kolom' => [
    'judul_kerjasama' => 'B', 'mitra' => 'C', 'sumber' => 'D', 'durasi' => 'E',
    'dana_ts2' => 'F', 'dana_ts1' => 'G', 'dana_ts' => 'H', 'lampiran_bukti' => 'I',
]];
$hki = ['mulai' => 6, 'no' => 'A', 'kolom' => [
    'judul' => 'B', 'jenis_hki' => 'C', 'nama_dtpr' => 'D', 'ts2' => 'E', 'ts1' => 'F', 'ts' => 'G', 'lampiran_bukti' => 'H',
]];

return [
    't1a1_pimpinan' => ['sheet' => 'Tabel 1.A.1', 'mulai' => 6, 'kolom' => [
        'unit_kerja' => 'A', 'nama_ketua' => 'B', 'periode_jabatan' => 'C',
        'pendidikan_terakhir' => 'D', 'jabatan_fungsional' => 'E', 'tupoksi' => 'F',
    ]],
    't1a2_sumber_dana' => ['sheet' => 'Tabel 1.A.2', 'mulai' => 5, 'kolom' => [
        'sumber_pendanaan' => 'A', 'ts2' => 'B', 'ts1' => 'C', 'ts' => 'D', 'lampiran_bukti' => 'E',
    ]],
    't1a3_penggunaan_dana' => ['sheet' => 'Tabel 1.A.3', 'mulai' => 5, 'kolom' => [
        'penggunaan_dana' => 'A', 'ts2' => 'B', 'ts1' => 'C', 'ts' => 'D', 'lampiran_bukti' => 'E',
    ]],
    't1a4_ewmp' => ['sheet' => 'Tabel 1.A.4', 'mulai' => 8, 'no' => 'A', 'kolom' => [
        'nama_dtpr' => 'B', 'sks_ps_sendiri' => 'C', 'sks_ps_lain' => 'D', 'sks_pt_lain' => 'E',
        'sks_penelitian' => 'F', 'sks_pkm' => 'G', 'sks_manajemen_pt_sendiri' => 'H',
        'sks_manajemen_pt_lain' => 'I', 'total_sks' => 'J',
    ]],
    't1a5_tendik' => ['sheet' => 'Tabel 1.A.5', 'mulai' => 7,
        'kunci' => ['field' => 'jenis', 'kolom' => 'B'],
        'kolom' => [
            's3' => 'C', 's2' => 'D', 's1' => 'E', 'd4' => 'F', 'd3' => 'G', 'd2' => 'H', 'd1' => 'I',
            'sma' => 'J', 'smp' => 'K', 'sd' => 'L', 'unit_kerja' => 'M',
        ]],
    't1b_spmi' => ['sheet' => 'Tabel 1.B', 'mulai' => 6, 'kolom' => [
        'unit_spmi' => 'A', 'nama_unit' => 'B', 'dokumen_spmi' => 'C', 'auditor_internal' => 'D',
        'auditor_certified' => 'E', 'auditor_non_certified' => 'F', 'frekuensi_audit' => 'G',
        'bukti_certified' => 'H', 'laporan_audit' => 'I',
    ]],
    't2a1_data_mahasiswa' => ['sheet' => 'Tabel 2.A.1', 'mulai' => 7,
        'kunci' => ['field' => 'ts', 'kolom' => 'A'],
        'kolom' => [
            'daya_tampung' => 'B', 'pendaftar' => 'C', 'pendaftar_afirmasi' => 'D', 'pendaftar_kebutuhan_khusus' => 'E',
            'baru_reguler' => 'F', 'baru_reguler_afirmasi' => 'G', 'baru_reguler_kk' => 'H',
            'baru_rpl' => 'I', 'baru_rpl_afirmasi' => 'J', 'baru_rpl_kk' => 'K',
            'aktif_reguler' => 'L', 'aktif_reguler_afirmasi' => 'M', 'aktif_reguler_kk' => 'N',
            'aktif_rpl' => 'O', 'aktif_rpl_afirmasi' => 'P', 'aktif_rpl_kk' => 'Q',
        ]],
    't2a2_asal_mahasiswa' => ['sheet' => 'Tabel 2.A.2', 'mulai' => 6, 'mode' => 'asal',
        'kolom' => ['ts2' => 'B', 'ts1' => 'C', 'ts' => 'D', 'lampiran_bukti' => 'E']],
    't2a3_kondisi_mahasiswa' => ['sheet' => 'Tabel 2.A.3', 'mulai' => 5,
        'kunci' => ['field' => 'kondisi', 'kolom' => 'A'],
        'kolom' => ['ts2' => 'B', 'ts1' => 'C', 'ts' => 'D', 'jumlah' => 'E', 'lampiran_bukti' => 'F'],
    ],
    't2b1_isi_pembelajaran' => ['sheet' => 'Tabel 2.B.1', 'mulai' => 6, 'kolom' => [
        'kode_mk' => 'A', 'nama_mk' => 'B', 'sks' => 'C', 'semester' => 'D',
        'pl1' => 'E', 'pl2' => 'F', 'pl3' => 'G', 'pl4' => 'H', 'pl5' => 'I',
    ]],
    't2b2_cpl_pl' => ['sheet' => 'Tabel 2.B.2', 'mulai' => 5, 'kolom' => [
        'cpl' => 'A', 'pl1' => 'B', 'pl2' => 'C', 'pl3' => 'D', 'pl4' => 'E', 'pl5' => 'F',
    ]],
    't2b3_peta_cpl' => ['sheet' => 'Tabel 2.B.3', 'mulai' => 5, 'kolom' => [
        'cpl' => 'A', 'cpmk' => 'B', 'semester_1' => 'C', 'semester_2' => 'D', 'semester_3' => 'E',
        'semester_4' => 'F', 'semester_5' => 'G', 'semester_6' => 'H',
    ]],
    't2b4_masa_tunggu' => ['sheet' => 'Tabel 2.B.4', 'mulai' => 5,
        'kunci' => ['field' => 'tahun_lulus', 'kolom' => 'A'],
        'kolom' => ['jumlah_lulusan' => 'B', 'terlacak' => 'C', 'rata_masa_tunggu' => 'D']],
    't2b5_bidang_kerja' => ['sheet' => 'Tabel 2.B.5', 'mulai' => 6,
        'kunci' => ['field' => 'tahun_lulus', 'kolom' => 'A'],
        'kolom' => [
            'jumlah_lulusan' => 'B', 'terlacak' => 'C', 'profesi_infokom' => 'D', 'profesi_non_infokom' => 'E',
            'tempat_multinasional' => 'F', 'tempat_nasional' => 'G', 'tempat_wirausaha' => 'H',
        ]],
    't2b6_kepuasan_pengguna' => ['sheet' => 'Tabel 2.B.6', 'mulai' => 6,
        'kunci' => ['field' => 'jenis_kemampuan', 'kolom' => 'B'],
        'kolom' => ['sangat_baik' => 'C', 'baik' => 'D', 'cukup' => 'E', 'kurang' => 'F', 'tindak_lanjut' => 'G']],
    't2c_fleksibilitas' => ['sheet' => 'Tabel 2.C', 'mulai' => 7,
        'kolom' => ['bentuk' => 'A', 'ts2' => 'B', 'ts1' => 'C', 'ts' => 'D', 'lampiran_bukti' => 'E'],
        'tetap' => ['field' => 'bentuk', 'nilai' => 'Jumlah Mahasiswa Aktif', 'baris' => 5],
        'lainnya' => ['field' => 'bentuk', 'keterangan' => 'keterangan'],
    ],
    't2d_rekognisi_lulusan' => ['sheet' => 'Tabel 2.D', 'mulai' => 6, 'kolom' => [
        'sumber_rekognisi' => 'A', 'jenis_pengakuan' => 'B', 'ts2' => 'C', 'ts1' => 'D', 'ts' => 'E', 'lampiran_bukti' => 'F',
    ]],
    't3a1_sarpras_penelitian' => ['sheet' => 'Tabel 3.A.1'] + $sarpras,
    't3a2_penelitian_dtpr' => ['sheet' => 'Tabel 3.A.2'] + $hibah,
    't3a3_pengembangan_dtpr' => ['sheet' => 'Tabel 3.A.3', 'mulai' => 7,
        'kolom' => ['jenis_pengembangan' => 'A', 'nama_dtpr' => 'B', 'ts2' => 'C', 'ts1' => 'D', 'ts' => 'E', 'lampiran_bukti' => 'F'],
    ],
    't3c1_kerjasama_penelitian' => ['sheet' => 'Tabel 3.C.1'] + $kerjasama,
    't3c2_publikasi' => ['sheet' => 'Tabel 3.C.2', 'mulai' => 6, 'no' => 'A',
        'kolom' => [
            'nama_dtpr' => 'B', 'judul_publikasi' => 'C', 'jenis_publikasi' => 'D',
            'ts2' => 'E', 'ts1' => 'F', 'ts' => 'G', 'lampiran_bukti' => 'H',
        ],
    ],
    't3c3_hki_penelitian' => ['sheet' => 'Tabel 3.C.3'] + $hki,
    't4a1_sarpras_pkm' => ['sheet' => 'Tabel 4.A.1'] + $sarpras,
    't4a2_pkm_dtpr' => ['sheet' => 'Tabel 4.A.2'] + $hibah,
    't4c1_kerjasama_pkm' => ['sheet' => 'Tabel 4.C.1'] + $kerjasama,
    't4c2_diseminasi_pkm' => ['sheet' => 'Tabel 4.C.2', 'mulai' => 5, 'no' => 'A',
        'kolom' => [
            'nama_dtpr' => 'B', 'judul' => 'D', 'diseminasi' => 'E',
            'ts2' => 'F', 'ts1' => 'G', 'ts' => 'H', 'lampiran_bukti' => 'I',
        ],
    ],
    't4c3_hki_pkm' => ['sheet' => 'Tabel 4.C.3'] + $hki,
    't5_1_tata_kelola' => ['sheet' => 'Tabel 5.1', 'mulai' => 5, 'no' => 'A', 'kolom' => [
        'jenis_tata_kelola' => 'B', 'nama_sistem' => 'C', 'akses' => 'D', 'unit_pengelola' => 'E', 'lampiran_bukti' => 'F',
    ]],
    't5_2_sarpras_pendidikan' => ['sheet' => 'Tabel 5.2'] + $sarpras,
    't6_visi_misi' => ['sheet' => 'Tabel 6', 'mode' => 'sel', 'sel' => [
        'visi_pt' => 'A5', 'visi_upps' => 'B5', 'visi_keilmuan' => 'C5', 'misi_pt' => 'A7', 'misi_upps' => 'B7',
    ]],
];

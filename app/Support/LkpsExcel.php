<?php

namespace App\Support;

use PhpOffice\PhpSpreadsheet\Cell\DataType;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\RichText\RichText;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

/**
 * Membaca dan menulis 31 tabel LKPS dari/ke template Excel LAM Infokom.
 * Kelas ini tidak menyentuh database: masukan dan keluarannya berupa array
 * [slug_tabel => [ [kolom => nilai], ... ]].
 */
class LkpsExcel
{
    public array $catatan = [];

    /** Isian di luar tabel (sheet Identitas, Jumlah Dosen DTPR) hasil impor terakhir. */
    public array $isian = [];

    private const CENTANG = '√';
    private const PLACEHOLDER = ['link bukti', 'bukti link', 'linik bukti', '…', '...', '-'];
    private const POLA_FOOTER = '/^(jumlah|keterangan|total|rata-rata|persentase|l\s*:\s*lokal|\*)/iu';

    /**
     * @param array $tabel  config('lkps.tabel')
     * @param array $peta   config('lkps_excel')
     * @param array $isian  config('lkps.isian') : [grup => [kunci => [label, tipe, sheet, sel]]]
     */
    public function __construct(private array $tabel, private array $peta, private array $defIsian = [])
    {
    }

    private function semuaIsian(): array
    {
        $hasil = [];
        foreach ($this->defIsian as $daftar) {
            $hasil += $daftar;
        }

        return $hasil;
    }

    // =====================================================================
    // EKSPOR
    // =====================================================================

    public function ekspor(string $template, array $data, array $isian = []): Spreadsheet
    {
        $book = IOFactory::load($template);

        foreach ($this->semuaIsian() as $kunci => [$label, $tipe, $sheet, $sel]) {
            if ($ws = $book->getSheetByName($sheet)) {
                $this->setSel($ws, $sel, $isian[$kunci] ?? null, $tipe);
            }
        }

        foreach ($this->peta as $slug => $p) {
            $ws = $book->getSheetByName($p['sheet']);
            if (! $ws) {
                $this->catatan[] = "Sheet \"{$p['sheet']}\" tidak ada di template, dilewati.";
                continue;
            }
            $rows = array_values($data[$slug] ?? []);

            match ($this->mode($p)) {
                'sel'   => $this->tulisSel($ws, $slug, $p, $rows),
                'kunci' => $this->tulisKunci($ws, $slug, $p, $rows),
                'asal'  => $this->tulisAsal($ws, $slug, $p, $rows),
                default => $this->tulisDaftar($ws, $slug, $p, $rows),
            };
        }

        $book->setActiveSheetIndex(0);

        return $book;
    }

    private function tulisDaftar(Worksheet $ws, string $slug, array $p, array $rows): void
    {
        $kolom = $this->kolom($slug);

        if (isset($p['tetap'])) {
            $t = $p['tetap'];
            foreach ($rows as $i => $r) {
                if (($r[$t['field']] ?? null) === $t['nilai']) {
                    $this->tulisBaris($ws, $t['baris'], $p, $kolom, $r, null, $t['field']);
                    unset($rows[$i]);
                }
            }
            $rows = array_values($rows);
        }

        $lines = array_map(fn ($r) => [null, $r], $rows);
        $this->tulisBlok($ws, $p, $kolom, $lines);
    }

    /** 2.A.2: baris dikelompokkan per kategori asal mahasiswa. */
    private function tulisAsal(Worksheet $ws, string $slug, array $p, array $rows): void
    {
        $kolom = $this->kolom($slug);
        $lines = [];
        foreach ($kolom['kategori']['options'] as $kat) {
            $grup = array_values(array_filter($rows, fn ($r) => ($r['kategori'] ?? '') === $kat));
            $utama = null;
            $anak = [];
            foreach ($grup as $g) {
                if ($utama === null && trim((string) ($g['asal'] ?? '')) === '') {
                    $utama = $g;
                } else {
                    $anak[] = $g;
                }
            }
            $lines[] = [$kat, $utama];
            foreach ($anak as $a) {
                $lines[] = [($a['asal'] ?? '') !== '' ? $a['asal'] : $kat, $a];
            }
        }
        $this->tulisBlok($ws, $p, $kolom, $lines, 'A');
    }

    /** Menulis sekumpulan baris mulai dari $p['mulai'], menyisipkan baris bila perlu. */
    private function tulisBlok(Worksheet $ws, array $p, array $kolom, array $lines, ?string $kolomLabel = null): void
    {
        $mulai = $p['mulai'];
        $n = count($lines);
        $footer = $this->footer($ws, $mulai);

        if ($footer !== null && $n > $footer - $mulai) {
            $sisip = $n - ($footer - $mulai);
            // Sisipkan di atas baris data terakhir agar rumus SUM/AVERAGE ikut melebar.
            $posisi = $footer - 1 > $mulai ? $footer - 1 : $footer;
            $ws->insertNewRowBefore($posisi, $sisip);
            $footer += $sisip;
        }

        $akhir = $footer !== null
            ? $footer - 1
            : max($mulai + $n - 1, $this->barisTerakhirTerisi($ws, $p, $mulai, $kolomLabel));
        $this->kosongkan($ws, $p, $mulai, $akhir, $kolomLabel);

        foreach ($lines as $i => [$label, $r]) {
            $baris = $mulai + $i;
            if ($kolomLabel !== null) {
                $ws->getCell($kolomLabel . $baris)->setValueExplicit((string) $label, DataType::TYPE_STRING);
            }
            if ($r !== null) {
                $this->tulisBaris($ws, $baris, $p, $kolom, $r, $i + 1);
            }
        }
    }

    private function tulisKunci(Worksheet $ws, string $slug, array $p, array $rows): void
    {
        $kolom = $this->kolom($slug);
        $peta = $this->petaLabel($ws, $p);

        foreach ($rows as $r) {
            $label = (string) ($r[$p['kunci']['field']] ?? '');
            $baris = $this->cariLabel($peta, $label);
            if ($baris === null) {
                $this->catatan[] = "{$p['sheet']}: baris \"{$label}\" tidak ada di template, dilewati.";
                continue;
            }
            $this->tulisBaris($ws, $baris, $p, $kolom, $r, null);
        }
    }

    private function tulisSel(Worksheet $ws, string $slug, array $p, array $rows): void
    {
        $kolom = $this->kolom($slug);
        $r = $rows[0] ?? [];
        if (count($rows) > 1) {
            $this->catatan[] = "{$p['sheet']}: hanya baris pertama yang diekspor.";
        }
        foreach ($p['sel'] as $field => $ref) {
            $this->setSel($ws, $ref, $r[$field] ?? null, $kolom[$field]['type'] ?? 'text');
        }
    }

    private function tulisBaris(Worksheet $ws, int $baris, array $p, array $kolom, array $r, ?int $no, ?string $lewati = null): void
    {
        if ($no !== null && isset($p['no'])) {
            $ws->getCell($p['no'] . $baris)->setValue($no);
        }

        foreach ($p['kolom'] as $field => $col) {
            if ($field === $lewati) {
                continue;
            }
            $v = $r[$field] ?? null;
            if (isset($p['lainnya']) && $field === $p['lainnya']['field'] && $v === 'Lainnya'
                && ! empty($r[$p['lainnya']['keterangan']])) {
                $v = $r[$p['lainnya']['keterangan']];
            }
            $this->setSel($ws, $col . $baris, $v, $kolom[$field]['type'] ?? 'text');
        }

        if (isset($p['centang'])) {
            $nilai = $r[$p['centang']['field']] ?? null;
            foreach ($p['centang']['kolom'] as $opsi => $col) {
                $ws->getCell($col . $baris)->setValue($nilai === $opsi ? self::CENTANG : null);
            }
        }

        foreach ($p['jumlah'] ?? [] as $col => $fields) {
            $ada = array_filter($fields, fn ($f) => ($r[$f] ?? null) !== null && $r[$f] !== '');
            $ws->getCell($col . $baris)->setValue(
                $ada ? array_sum(array_map(fn ($f) => (float) ($r[$f] ?? 0), $fields)) : null
            );
        }
    }

    private function setSel(Worksheet $ws, string $ref, mixed $v, string $type): void
    {
        $cell = $ws->getCell($ref);
        if ($type === 'check') {
            $cell->setValue($v ? self::CENTANG : null);
            return;
        }
        if ($v === null || $v === '') {
            $cell->setValue(null);
            return;
        }
        if (in_array($type, ['number', 'decimal'], true) && is_numeric($v)) {
            $cell->setValueExplicit($v + 0, DataType::TYPE_NUMERIC);
            return;
        }
        // Teks selalu ditulis eksplisit agar isian yang diawali "=" tidak menjadi rumus.
        $cell->setValueExplicit((string) $v, DataType::TYPE_STRING);
        if (in_array($type, ['url', 'file'], true) && preg_match('#^https?://\S+$#i', (string) $v)) {
            $cell->getHyperlink()->setUrl((string) $v);
        }
    }

    private function kosongkan(Worksheet $ws, array $p, int $dari, int $sampai, ?string $kolomLabel): void
    {
        $cols = array_values($p['kolom']);
        if (isset($p['no'])) {
            $cols[] = $p['no'];
        }
        if ($kolomLabel) {
            $cols[] = $kolomLabel;
        }
        $cols = array_merge($cols, array_values($p['centang']['kolom'] ?? []), array_keys($p['jumlah'] ?? []));
        for ($r = $dari; $r <= $sampai; $r++) {
            foreach (array_unique($cols) as $c) {
                $ws->getCell($c . $r)->setValue(null);
            }
        }
    }

    private function barisTerakhirTerisi(Worksheet $ws, array $p, int $mulai, ?string $kolomLabel): int
    {
        $cols = array_values($p['kolom']);
        if ($kolomLabel) {
            $cols[] = $kolomLabel;
        }
        $akhir = $mulai - 1;
        $max = min($ws->getHighestDataRow(), $mulai + 5000);
        for ($r = $mulai; $r <= $max; $r++) {
            foreach ($cols as $c) {
                if (trim((string) $this->nilaiMentah($ws, $c . $r)) !== '') {
                    $akhir = $r;
                    break;
                }
            }
        }

        return $akhir;
    }

    // =====================================================================
    // IMPOR
    // =====================================================================

    public function impor(string $file): array
    {
        $reader = IOFactory::createReaderForFile($file);
        $reader->setReadDataOnly(true);
        $book = $reader->load($file);
        $hasil = [];

        $this->isian = [];
        foreach ($this->semuaIsian() as $kunci => [$label, $tipe, $sheet, $sel]) {
            if ($ws = $book->getSheetByName($sheet)) {
                $v = $this->bacaNilai($ws, $sel, $tipe);
                if ($v !== null) {
                    $this->isian[$kunci] = $tipe === 'number' ? $v : (string) $v;
                }
            }
        }

        foreach ($this->peta as $slug => $p) {
            $ws = $book->getSheetByName($p['sheet']);
            if (! $ws) {
                $this->catatan[] = "Sheet \"{$p['sheet']}\" tidak ditemukan di file, dilewati.";
                continue;
            }
            $rows = match ($this->mode($p)) {
                'sel'   => $this->bacaSel($ws, $slug, $p),
                'kunci' => $this->bacaKunci($ws, $slug, $p),
                'asal'  => $this->bacaAsal($ws, $slug, $p),
                default => $this->bacaDaftar($ws, $slug, $p),
            };
            $hasil[$slug] = array_map(fn ($r) => $this->lengkapiKolom($slug, $r), $rows);
        }

        return $hasil;
    }

    private function bacaDaftar(Worksheet $ws, string $slug, array $p): array
    {
        $kolom = $this->kolom($slug);
        $rows = [];

        if (isset($p['tetap'])) {
            $t = $p['tetap'];
            $r = $this->bacaBaris($ws, $t['baris'], $p, $kolom, $t['field']);
            if ($r !== null) {
                $r[$t['field']] = $t['nilai'];
                $rows[] = $r;
            }
        }

        $mulai = $p['mulai'];
        $footer = $this->footer($ws, $mulai);
        $akhir = $footer !== null ? $footer - 1 : min($ws->getHighestDataRow(), $mulai + 5000);
        $kosong = 0;

        for ($b = $mulai; $b <= $akhir; $b++) {
            // Minimal dua isian: baris yang hanya berisi label bawaan template (mis. "Yayasan") dilewati.
            $r = $this->bacaBaris($ws, $b, $p, $kolom, null, 2);
            if ($r === null) {
                if ($footer === null && ++$kosong >= 30) {
                    break;
                }
                continue;
            }
            $kosong = 0;
            if ($this->wajibTerisi($slug, $r, $b, $p['sheet'])) {
                $rows[] = $r;
            }
        }

        return $rows;
    }

    private function bacaKunci(Worksheet $ws, string $slug, array $p): array
    {
        $kolom = $this->kolom($slug);
        $field = $p['kunci']['field'];
        $opsi = [];
        foreach ($kolom[$field]['options'] as $o) {
            $opsi[$this->norm($o)] = $o;
        }

        $rows = [];
        foreach ($this->petaLabel($ws, $p) as $label => $baris) {
            $r = $this->bacaBaris($ws, $baris, $p, $kolom);
            if ($r === null) {
                continue;
            }
            $cocok = $this->cariLabel($opsi, $label);
            $r[$field] = $cocok ?? trim((string) $this->nilaiMentah($ws, $p['kunci']['kolom'] . $baris));
            $rows[] = $r;
        }

        return $rows;
    }

    private function bacaAsal(Worksheet $ws, string $slug, array $p): array
    {
        $kolom = $this->kolom($slug);
        $kategori = [];
        foreach ($kolom['kategori']['options'] as $o) {
            $kategori[$this->norm($o)] = $o;
        }

        $rows = [];
        $sekarang = null;
        $footer = $this->footer($ws, $p['mulai']) ?? $p['mulai'] + 200;
        for ($b = $p['mulai']; $b < $footer; $b++) {
            $label = trim((string) $this->nilaiMentah($ws, 'A' . $b));
            $r = $this->bacaBaris($ws, $b, $p, $kolom);
            $kat = $kategori[$this->norm($label)] ?? null;
            if ($kat !== null) {
                $sekarang = $kat;
                if ($r !== null) {
                    $rows[] = ['kategori' => $kat, 'asal' => null] + $r;
                }
                continue;
            }
            if ($r !== null && $sekarang !== null && ! in_array(mb_strtolower($label), self::PLACEHOLDER, true)) {
                $rows[] = ['kategori' => $sekarang, 'asal' => $label !== '' ? $label : null] + $r;
            }
        }

        return $rows;
    }

    private function bacaSel(Worksheet $ws, string $slug, array $p): array
    {
        $kolom = $this->kolom($slug);
        $r = [];
        foreach ($p['sel'] as $field => $ref) {
            $r[$field] = $this->bacaNilai($ws, $ref, $kolom[$field]['type'] ?? 'text');
        }

        return array_filter($r, fn ($v) => $v !== null) ? [$r] : [];
    }

    /** Mengembalikan null bila semua kolom yang dipetakan kosong. */
    private function bacaBaris(Worksheet $ws, int $baris, array $p, array $kolom, ?string $lewati = null, int $minIsi = 1): ?array
    {
        $r = [];
        $ada = false;
        foreach ($p['kolom'] as $field => $col) {
            if ($field === $lewati || ($kolom[$field]['type'] ?? '') === 'file') {
                continue;
            }
            $v = $this->bacaNilai($ws, $col . $baris, $kolom[$field]['type'] ?? 'text');
            $r[$field] = $v;
            if ($v !== null && $v !== false) {
                $ada = true;
            }
        }

        if (isset($p['centang'])) {
            $r[$p['centang']['field']] = null;
            foreach ($p['centang']['kolom'] as $opsi => $col) {
                if (trim((string) $this->nilaiMentah($ws, $col . $baris)) !== '') {
                    $r[$p['centang']['field']] = $opsi;
                    $ada = true;
                    break;
                }
            }
        }

        // Samakan isian pilihan dengan opsi yang ada (mis. "Universitas / PT" -> "Universitas/PT").
        foreach ($r as $f => $v) {
            $opsi = $kolom[$f]['options'] ?? [];
            if (($kolom[$f]['type'] ?? '') === 'select' && is_string($v) && $opsi && ! in_array($v, $opsi, true)) {
                $cocok = $this->cariLabel(array_combine(array_map(fn ($o) => $this->norm($o), $opsi), $opsi), $v);
                if ($cocok !== null) {
                    $r[$f] = $cocok;
                }
            }
        }

        if (! $ada || count(array_filter($r, fn ($v) => $v !== null && $v !== false && $v !== '')) < $minIsi) {
            return null;
        }

        if (isset($p['lainnya']) && $p['lainnya']['field'] !== $lewati) {
            $f = $p['lainnya']['field'];
            $opsi = $kolom[$f]['options'] ?? [];
            if ($r[$f] !== null && ! in_array($r[$f], $opsi, true)) {
                $cocok = $this->cariLabel(array_combine(array_map(fn ($o) => $this->norm($o), $opsi), $opsi), $this->norm($r[$f]));
                if ($cocok !== null) {
                    $r[$f] = $cocok;
                } else {
                    $r[$p['lainnya']['keterangan']] = $r[$f];
                    $r[$f] = 'Lainnya';
                }
            }
        }

        return $ada ? $r : null;
    }

    private function bacaNilai(Worksheet $ws, string $ref, string $type): mixed
    {
        $v = $this->nilaiMentah($ws, $ref);
        if (is_string($v)) {
            $v = trim($v);
        }
        if ($v === null || $v === '') {
            return $type === 'check' ? false : null;
        }
        if ($type === 'check') {
            return ! in_array(mb_strtolower((string) $v), ['-', '0', 'tidak'], true);
        }
        if (in_array($type, ['number', 'decimal'], true)) {
            if (! is_numeric($v)) {
                $v = str_replace([' ', ','], ['', '.'], (string) $v);
                if (! is_numeric($v)) {
                    return null;
                }
            }
            return $type === 'number' ? (int) round((float) $v) : round((float) $v, 2);
        }
        if (is_float($v) && floor($v) == $v) {
            $v = (int) $v;
        }
        $v = (string) $v;

        return in_array(mb_strtolower($v), self::PLACEHOLDER, true) ? null : $v;
    }

    private function nilaiMentah(Worksheet $ws, string $ref): mixed
    {
        $cell = $ws->getCell($ref);
        $v = $cell->getValue();
        if ($v instanceof RichText) {
            $v = $v->getPlainText();
        }
        if (is_string($v) && str_starts_with($v, '=')) {
            try {
                $v = $cell->getCalculatedValue();
            } catch (\Throwable) {
                $v = null;
            }
        }

        return $v;
    }

    private function wajibTerisi(string $slug, array $r, int $baris, string $sheet): bool
    {
        foreach ($this->kolom($slug) as $n => $k) {
            if (str_contains($k['rules'], 'required') && ! in_array($k['type'], ['file', 'check'], true)
                && (($r[$n] ?? null) === null || $r[$n] === '')) {
                if (array_filter($r, fn ($v) => $v !== null && $v !== false && $v !== '') ) {
                    $this->catatan[] = "{$sheet} baris {$baris}: kolom \"{$k['label']}\" kosong, baris dilewati.";
                }
                return false;
            }
        }

        return true;
    }

    private function lengkapiKolom(string $slug, array $r): array
    {
        $hasil = [];
        foreach ($this->kolom($slug) as $n => $k) {
            $hasil[$n] = $r[$n] ?? ($k['type'] === 'check' ? false : null);
        }
        foreach ($this->tabel[$slug]['total'] ?? [] as $target => $sumber) {
            $hasil[$target] = array_sum(array_map(fn ($c) => (float) ($hasil[$c] ?? 0), $sumber));
        }

        return $hasil;
    }

    // =====================================================================
    // UTILITAS
    // =====================================================================

    private function mode(array $p): string
    {
        return $p['mode'] ?? (isset($p['kunci']) ? 'kunci' : 'daftar');
    }

    private function kolom(string $slug): array
    {
        $hasil = [];
        foreach ($this->tabel[$slug]['kolom'] ?? [] as $n => $d) {
            $hasil[$n] = ['label' => str_replace('|', ' – ', $d[0]), 'type' => $d[1] ?? 'text', 'rules' => $d[2] ?? 'nullable', 'options' => $d[3] ?? []];
        }
        // Lampiran Bukti: saat ekspor berisi link pratinjau, saat impor dilewati.
        $hasil['lampiran_bukti'] ??= ['label' => 'Lampiran Bukti', 'type' => 'file', 'rules' => 'nullable', 'options' => []];

        return $hasil;
    }

    /** Baris pertama (mulai dari $mulai) yang berisi Jumlah/Keterangan/Total di kolom A. */
    private function footer(Worksheet $ws, int $mulai): ?int
    {
        $max = min($ws->getHighestDataRow(), $mulai + 5000);
        for ($r = $mulai; $r <= $max; $r++) {
            $v = trim((string) $this->nilaiMentah($ws, 'A' . $r));
            if ($v !== '' && preg_match(self::POLA_FOOTER, $v)) {
                return $r;
            }
        }

        return null;
    }

    /** [label ternormalisasi => nomor baris] untuk tabel berbaris tetap. */
    private function petaLabel(Worksheet $ws, array $p): array
    {
        $akhir = $this->footer($ws, $p['mulai']) ?? $p['mulai'] + 30;
        $peta = [];
        for ($r = $p['mulai']; $r < $akhir; $r++) {
            $label = $this->norm($this->nilaiMentah($ws, $p['kunci']['kolom'] . $r));
            if ($label !== '' && ! isset($peta[$label])) {
                $peta[$label] = $r;
            }
        }

        return $peta;
    }

    private function cariLabel(array $peta, string $label): mixed
    {
        $label = $this->norm($label);
        if ($label === '') {
            return null;
        }
        if (isset($peta[$label])) {
            return $peta[$label];
        }
        foreach ($peta as $k => $v) {
            if (min(strlen($k), strlen($label)) >= 5 && (str_starts_with($k, $label) || str_starts_with($label, $k))) {
                return $v;
            }
        }

        return null;
    }

    private function norm(mixed $s): string
    {
        return preg_replace('/[^a-z0-9]/', '', mb_strtolower((string) $s)) ?? '';
    }
}

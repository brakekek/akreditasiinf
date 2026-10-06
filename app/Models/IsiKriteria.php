<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class IsiKriteria extends Model {
    protected $table = 'isi_kriteria';
    protected $fillable = ['kriteria_id', 'butir', 'elemen_penilaian', 'narasi', 'persentase'];
    // Tag HTML narasi yang diizinkan (editor TinyMCE); selain ini dibuang demi keamanan (XSS)
    const PURIFY = [
        'HTML.Allowed' => 'p,br,strong,b,em,i,u,s,sub,sup,blockquote,pre,code,h2,h3,h4,ul,ol,li,a[href|title],img[src|alt|width|height],table[border],thead,tbody,tr,th[colspan|rowspan],td[colspan|rowspan]',
        'AutoFormat.RemoveEmpty' => false,
    ];
    public function kriteria() { return $this->belongsTo(Kriteria::class); }
    public function dokumen() { return $this->hasMany(Dokumen::class, 'isi_kriteria_id'); }
}

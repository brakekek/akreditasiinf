<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class Dokumen extends Model {
    protected $table = 'dokumen';
    protected $fillable = ['isi_kriteria_id', 'nama', 'file_path', 'link'];
    public function isi() { return $this->belongsTo(IsiKriteria::class, 'isi_kriteria_id'); }
}

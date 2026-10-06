<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class Kriteria extends Model {
    protected $table = 'kriterias';
    protected $fillable = ['kode', 'nama'];
    public function isi() { return $this->hasMany(IsiKriteria::class, 'kriteria_id'); }
    // Persentase Isian kriteria = rata-rata persentase seluruh butir di dalamnya
    public function getPersentaseAttribute(): int {
        return (int) round($this->isi->avg('persentase') ?? 0);
    }
}

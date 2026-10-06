@extends('layout')
@section('title', $isi->exists ? 'Ubah Isi Kriteria' : 'Tambah Isi Kriteria')
@section('content')
<h4 class="mb-3">{{ $isi->exists ? 'Ubah' : 'Tambah' }} isi kriteria</h4>
<form method="post" class="card card-body" action="{{ $isi->exists ? route('isi.update', $isi) : route('isi.store') }}">
  @csrf @if($isi->exists) @method('PUT') @endif
  <div class="mb-3"><label class="form-label">Kriteria</label>
    <select name="kriteria_id" class="form-select" required>
      @foreach($kriterias as $k)<option value="{{ $k->id }}" @selected(old('kriteria_id', $isi->kriteria_id) == $k->id)>{{ $k->kode }} - {{ $k->nama }}</option>@endforeach
    </select></div>
  <div class="mb-3"><label class="form-label">Butir</label><input name="butir" class="form-control" value="{{ old('butir', $isi->butir) }}" required></div>
  <div class="mb-3"><label class="form-label">Elemen penilaian</label><textarea name="elemen_penilaian" rows="3" class="form-control" required>{{ old('elemen_penilaian', $isi->elemen_penilaian) }}</textarea></div>
  <div class="mb-3"><label class="form-label">Narasi</label><textarea name="narasi" id="narasi" rows="12" class="form-control">{{ old('narasi', $isi->narasi) }}</textarea></div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.8.3/tinymce.min.js" referrerpolicy="origin"></script>
  <script>
    tinymce.init({
      selector: '#narasi',
      height: 460,
      branding: false,
      promotion: false,
      menubar: 'edit insert format table',
      plugins: 'table image lists link code autoresize',
      toolbar: 'undo redo | blocks | bold italic underline | alignleft aligncenter alignright | bullist numlist | table image link | removeformat code',
      relative_urls: false,
      convert_urls: false,
      automatic_uploads: true,
      paste_data_images: true,
      image_title: true,
      file_picker_types: 'image',
      images_upload_handler: function (blobInfo) {
        return new Promise(function (resolve, reject) {
          var fd = new FormData();
          fd.append('file', blobInfo.blob(), blobInfo.filename());
          fetch("{{ route('unggah.gambar') }}", { method: 'POST', headers: { 'X-CSRF-TOKEN': '{{ csrf_token() }}', 'Accept': 'application/json' }, body: fd })
            .then(function (r) { return r.ok ? r.json() : Promise.reject(); })
            .then(function (j) { resolve(j.location); })
            .catch(function () { reject('Gagal mengunggah gambar (maks. 4 MB; jpg, png, gif, webp).'); });
        });
      },
      file_picker_callback: function (cb, value, meta) {
        if (meta.filetype !== 'image') return;
        var i = document.createElement('input'); i.type = 'file'; i.accept = 'image/*';
        i.onchange = function () {
          var f = i.files[0], r = new FileReader();
          r.onload = function () {
            var bc = tinymce.activeEditor.editorUpload.blobCache, bi = bc.create('blob' + Date.now(), f, r.result.split(',')[1]);
            bc.add(bi); cb(bi.blobUri(), { title: f.name });
          };
          r.readAsDataURL(f);
        };
        i.click();
      }
    });
  </script>
  <div class="mb-3"><label class="form-label">Persentase isian (0-100)</label><input type="number" min="0" max="100" name="persentase" class="form-control" value="{{ old('persentase', $isi->persentase) }}" required></div>
  <div><button class="btn btn-primary">Simpan</button> <a href="{{ url()->previous() }}" class="btn btn-link">Batal</a></div>
</form>
@endsection

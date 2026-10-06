<?php
namespace App\Http\Controllers;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class PenggunaController extends Controller {
    public function index(Request $r) {
        $q = trim((string) $r->query('q', ''));
        $users = User::query()
            ->when($q !== '', fn ($x) => $x->where(fn ($w) => $w->where('name', 'like', "%$q%")->orWhere('email', 'like', "%$q%")))
            ->orderBy('name')->get();
        return view('pengguna.index', compact('users', 'q'));
    }
    public function create() { return view('pengguna.form', ['u' => new User]); }

    public function store(Request $r) {
        $d = $r->validate([
            'name'     => 'required|max:255',
            'email'    => 'required|email|max:255|unique:users,email',
            'password' => 'required|min:8|confirmed',
        ]);
        User::create(['name' => $d['name'], 'email' => $d['email'], 'password' => Hash::make($d['password'])]);
        return redirect()->route('pengguna.index')->with('ok', 'Pengguna ditambahkan.');
    }

    public function edit(User $pengguna) { return view('pengguna.form', ['u' => $pengguna]); }

    public function update(Request $r, User $pengguna) {
        $d = $r->validate([
            'name'     => 'required|max:255',
            'email'    => ['required', 'email', 'max:255', Rule::unique('users', 'email')->ignore($pengguna->id)],
            'password' => 'nullable|min:8|confirmed',
        ]);
        $pengguna->name = $d['name'];
        $pengguna->email = $d['email'];
        if (!empty($d['password'])) $pengguna->password = Hash::make($d['password']);
        $pengguna->save();
        return redirect()->route('pengguna.index')->with('ok', 'Pengguna diperbarui.');
    }

    public function destroy(User $pengguna) {
        if ($pengguna->id == auth()->id()) {
            return back()->withErrors(['hapus' => 'Anda tidak dapat menghapus akun Anda sendiri.']);
        }
        if ($pengguna->id == 1) {
            return back()->withErrors(['hapus' => 'Akun admin utama tidak dapat dihapus.']);
        }
        $pengguna->delete();
        return redirect()->route('pengguna.index')->with('ok', 'Pengguna dihapus.');
    }
}

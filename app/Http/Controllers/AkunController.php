<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class AkunController extends Controller {
    public function edit(Request $r) { return view('akun.edit', ['u' => $r->user()]); }

    public function update(Request $r) {
        $u = $r->user();
        $d = $r->validate([
            'name'           => 'required|max:255',
            'email'          => ['required', 'email', 'max:255', Rule::unique('users', 'email')->ignore($u->id)],
            'password_lama'  => 'nullable|required_with:password|current_password',
            'password'       => 'nullable|min:8|confirmed',
        ], ['password_lama.current_password' => 'Kata sandi lama tidak sesuai.']);
        $u->name = $d['name'];
        $u->email = $d['email'];
        if (!empty($d['password'])) $u->password = Hash::make($d['password']);
        $u->save();
        return redirect()->route('akun.edit')->with('ok', 'Akun diperbarui.');
    }
}

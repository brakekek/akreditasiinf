<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller {
    public function showLogin() { return view('auth.login'); }

    public function login(Request $r) {
        $cred = $r->validate(['email' => 'required|email', 'password' => 'required']);
        if (Auth::attempt($cred, $r->boolean('remember'))) {
            $r->session()->regenerate();
            return redirect()->intended(route('dashboard'));
        }
        return back()->withInput($r->only('email'))->withErrors(['email' => 'Email atau kata sandi salah.']);
    }

    public function logout(Request $r) {
        Auth::logout();
        $r->session()->invalidate();
        $r->session()->regenerateToken();
        return redirect()->route('dashboard');
    }
}

<?php
namespace App\Http\Middleware;
use Closure;
use Illuminate\Http\Request;

class HanyaAdmin {
    public static function adalahAdmin($u): bool {
        if (!$u) return false;
        $emails = array_filter(array_map(
            fn ($e) => strtolower(trim($e)),
            explode(',', (string) config('akreditasi.admin_emails', ''))
        ));
        return (int) $u->id === 1 || in_array(strtolower((string) $u->email), $emails, true);
    }
    public function handle(Request $request, Closure $next) {
        abort_unless(self::adalahAdmin($request->user()), 403, 'Hanya admin yang dapat mengelola pengguna.');
        return $next($request);
    }
}

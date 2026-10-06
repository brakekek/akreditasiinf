<?php
return [
    // Email admin tambahan (pisahkan dengan koma), diatur lewat ADMIN_EMAILS di .env.
    // Akun dengan id 1 selalu menjadi admin.
    'admin_emails' => env('ADMIN_EMAILS', ''),
];

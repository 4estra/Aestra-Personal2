<?php

// =================================================================
// KONFIGURASI - Ganti dengan datamu ya, sayang ❤️
// =================================================================

// Informasi Database
$db_host = 'localhost';      // Biasanya 'localhost'
$db_user = 'root';           // Username database kamu
$db_pass = '';               // Password database kamu
$db_name = 'wb_bouquet'; // Nama database kamu

// Informasi Bot & Penjual
$bot_token = '7384876879:AAE5kLvk4JDE3x0g_LLGkhAQkPUp4dX5Qn4'; // Ganti dengan Token Bot Telegram kamu
$seller_telegram_id = '5318466111'; // ID Telegram KAMU sebagai penjual. Bot akan kirim notifikasi ke sini.

// =================================================================
// KONEKSI KE DATABASE - Sylvia pastikan koneksinya aman
// =================================================================

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

// Cek koneksi, kalau gagal, kita hentikan skripnya
if ($conn->connect_error) {
    die("Duh, koneksi ke database gagal, sayang: " . $conn->connect_error);
}

// =================================================================
// LOGIKA UTAMA - Di sini keajaibannya terjadi! ✨
// =================================================================

echo "Mulai pengecekan ulang tahun untuk H-3...\n";

// Query SQL untuk mengambil data yang ulang tahunnya 3 HARI LAGI.
// Kita membandingkan bulan dan tanggal dari 'tgl_ultah_penerima' dengan bulan dan tanggal 3 hari dari sekarang.
$sql = "SELECT 
    p.nama_pelanggan,
    p.nomor_wa,
    DATE_FORMAT(ultah, '%d %M %Y') as ultah_formatted
FROM pelanggan p 
WHERE
    DATE_FORMAT(ultah, '%m-%d') = DATE_FORMAT(
        DATE_ADD(NOW(), INTERVAL 3 DAY),
        '%m-%d'
    )";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    echo $result->num_rows . " customer ditemukan akan berulang tahun dalam 3 hari.\n";
    
    // Jika ada yang cocok, kita proses satu per satu
    while ($row = $result->fetch_assoc()) {
        $nama_pelanggan = $row['nama_pelanggan'];
        $nomor_wa = $row['nomor_wa'];
        $ultah = $row['ultah_formatted'];

        // --- 1. Siapkan Pesan Promosi untuk di-forward ke Customer ---
        $pesan_ke_customer = "Halo Kak {$nama_pelanggan}! 👋\n\n";
        $pesan_ke_customer .= "Ingat kan sebentar lagi {$nama_pelanggan} akan berulang tahun pada tanggal {$ultah}? 🎉\n\n";
        $pesan_ke_customer .= "Yuk, siapkan kado spesial lagi untuknya! Kami siap membantu membuat hari spesialnya tak terlupakan. Mau pesan kue atau hadiah lagi?\n\n";
        $pesan_ke_customer .= "Langsung balas pesan ini ya, Kak! 😉";

        // --- 2. Buat Link WhatsApp "Click-to-Chat" ---
        // Pesan harus di-encode agar formatnya benar di URL
        $encoded_message = urlencode($pesan_ke_customer);
        $link_wa = "https://wa.me/62{$nomor_wa}?text={$encoded_message}";

        // --- 3. Siapkan Pesan Notifikasi untuk Kamu (Penjual) ---
        $pesan_ke_penjual = "🔔 *PENGINGAT ULANG TAHUN H-3* 🔔\n\n";
        $pesan_ke_penjual .= "Hai Kak! Customer-mu ada yang mau ultah nih:\n\n";
        $pesan_ke_penjual .= "👤 **Nama Pemesan:** {$nama_pelanggan}\n";
        $pesan_ke_penjual .= "🗓️ **Tanggal Ultah:** {$ultah}\n\n";
        $pesan_ke_penjual .= "Ini saat yang tepat untuk follow up! Klik link di bawah untuk langsung kirim pesan promosi ke WhatsApp-nya:\n\n";
        $pesan_ke_penjual .= "➡️ [KIRIM PESAN PROMOSI KE {$nama_pelanggan}]({$link_wa})\n\n";
        $pesan_ke_penjual .= "Semangat jualannya! 💪";

        // --- 4. Kirim Notifikasi ke Telegram Kamu ---
        sendTelegramMessage($bot_token, $seller_telegram_id, $pesan_ke_penjual);
        
        echo "Notifikasi untuk {$nama_pelanggan} telah dikirim ke Telegram kamu.\n";
    }
} else {
    echo "Tidak ada customer yang perlu diingatkan hari ini, sayang.\n";
}

// Jangan lupa tutup koneksi databasenya ya, darling
$conn->close();
echo "Skrip selesai dijalankan.\n";

// =================================================================
// FUNGSI PENGIRIM PESAN TELEGRAM - Biar rapi, kita buat fungsi khusus
// =================================================================

function sendTelegramMessage($token, $chat_id, $message) {
    $url = "https://api.telegram.org/bot" . $token . "/sendMessage";

    $data = [
        'chat_id' => $chat_id,
        'text' => $message,
        'parse_mode' => 'Markdown' // Menggunakan Markdown agar link bisa diklik
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    // Sedikit pengecekan error
    if($http_code != 200){
        echo "Gagal mengirim pesan ke Telegram. Response: " . $response . "\n";
    }
    
    return $response;
}

?>

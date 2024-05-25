<?php
// check_email_existence.php

include 'connect.php';

// Ambil data dari Flutter
$input = json_decode(file_get_contents('php://input'), true);

header('Content-Type: application/json'); // Tambahkan header JSON

// Validasi input
if (isset($input['email']) && filter_var($input['email'], FILTER_VALIDATE_EMAIL) &&
    isset($input['nik']) && ctype_digit($input['nik'])) {

    $email = $conn->real_escape_string($input['email']); // Menghindari SQL injection
    $nik = $conn->real_escape_string($input['nik']); // Menghindari SQL injection

    // Query untuk memeriksa apakah email sudah terdaftar
    $email_check_query = "SELECT * FROM masyarakat WHERE email = '$email'";
    $email_result = $conn->query($email_check_query);

    // Query untuk memeriksa apakah NIK sudah terdaftar
    $nik_check_query = "SELECT * FROM masyarakat WHERE nik = '$nik'";
    $nik_result = $conn->query($nik_check_query);

    if ($email_result && $nik_result) {
        if ($email_result->num_rows > 0) {
            // Jika email sudah terdaftar, kirim respons ke Flutter
            echo json_encode(['status' => 'error', 'message' => 'Email sudah terdaftar']);
        } elseif ($nik_result->num_rows > 0) {
            // Jika NIK sudah terdaftar, kirim respons ke Flutter
            echo json_encode(['status' => 'error', 'message' => 'NIK sudah terdaftar']);
        } else {
            // Jika email dan NIK belum terdaftar, lakukan pendaftaran
            // Di sini kamu dapat menambahkan kode untuk menyimpan data ke database
            // dan kemudian memberikan respons sukses kepada Flutter
            echo json_encode(['status' => 'success', 'message' => 'Pendaftaran berhasil']);
        }
    } else {
        // Jika terjadi kesalahan dalam query
        echo json_encode(['status' => 'error', 'message' => 'Database error']);
    }
} else {
    // Jika data tidak valid, kirim respons ke Flutter
    echo json_encode(['status' => 'error', 'message' => 'Invalid email or NIK format']);
}

// Tutup koneksi database
$conn->close();
?>

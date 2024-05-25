<?php
// check_email_existence.php

include 'connect.php';

// Ambil data dari Flutter
$input = json_decode(file_get_contents('php://input'), true);

header('Content-Type: application/json'); // Tambahkan header JSON

// Validasi input
if (isset($input['email']) && filter_var($input['email'], FILTER_VALIDATE_EMAIL)) {
    $email = $conn->real_escape_string($input['email']); // Menghindari SQL injection

    // Query untuk memeriksa apakah email sudah terdaftar
    $check_query = "SELECT * FROM masyarakat WHERE email = '$email'";

    $result = $conn->query($check_query);

    if ($result) {
        if ($result->num_rows > 0) {
            // Jika email sudah terdaftar, kirim respons ke Flutter
            echo json_encode(['status' => 'error', 'message' => 'Email already registered']);
        } else {
            // Jika email belum terdaftar, kirim respons ke Flutter
            echo json_encode(['status' => 'success', 'message' => 'Email tidak terdaftar']);
        }
    } else {
        // Jika terjadi kesalahan dalam query
        echo json_encode(['status' => 'error', 'message' => 'Database error']);
    }
} else {
    // Jika data tidak valid, kirim respons ke Flutter
    echo json_encode(['status' => 'error', 'message' => 'Invalid email format']);
}

// Tutup koneksi database
$conn->close();
?>

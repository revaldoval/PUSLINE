<?php
// update_foto_profil.php

include 'connect.php';

// Ambil data dari Flutter
$data = json_decode(file_get_contents('php://input'), true);

header('Content-Type: application/json'); // Tambahkan header JSON

if (isset($data['kata_sandi']) && isset($data['email'])) {
    $email = $data['email'];
    $kata_sandi = md5($data['kata_sandi']);


    $query = "UPDATE masyarakat
    SET kata_sandi = '$kata_sandi' 
    WHERE email = '$email';
    ";

    if ($conn->query($query) === TRUE) {
        echo json_encode(['status' => 'success', 'message' => ' profil updated successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to update profil: ' . $conn->error]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid data format']);
}

$conn->close();
?>
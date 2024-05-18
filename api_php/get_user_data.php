<?php
// Di dalam get_product_details.php

include 'connect.php';

// Ambil data dari body request
$data = json_decode(file_get_contents("php://input"));

// Pastikan ada data yang dikirim
if(isset($data->id_artikel)) {
    $nik = $data->nik;

    // Query untuk mendapatkan detail produk berdasarkan ID
    $query = "SELECT * FROM masyarakat WHERE nik = $nik";
    $result = $conn->query($query);

    // Pastikan query berhasil
    if($result) {
        // Ambil data produk
        $row = $result->fetch_assoc();

        // Kirim data sebagai response
        echo json_encode($row);
    } else {
        // Jika query gagal
        echo json_encode(['error' => 'Failed to get product details.']);
    }
} else {
    // Jika data tidak lengkap
    echo json_encode(['error' => 'Incomplete data.']);
}
?>
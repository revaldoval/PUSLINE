<?php

// Include file koneksi.php
include 'connect.php';

try {
    // Ambil data dari body request
    $data = json_decode(file_get_contents("php://input"));

    // Periksa apakah data yang dibutuhkan tersedia
    if ($data && property_exists($data, 'nik') && property_exists($data, 'kata_sandi')) {
        $nik = $data->nik;
        $kata_sandi = md5($data->kata_sandi);

        // Query untuk mencari pengguna dengan nik dan kata_sandi yang sesuai
        $query = "SELECT * FROM masyarakat WHERE nik = ? AND kata_sandi = ?";
        $stmt = $conn->prepare($query);
if (!$stmt) {
    throw new Exception("Prepare statement failed: " . $conn->error);
}

$stmt->bind_param("ss", $nik, $kata_sandi); // Bind parameter-query
$stmt->execute(); // Execute statement


        // Ambil hasil query
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        // Cek apakah pengguna ditemukan
        if ($user) {
            $response['status'] = 'success';
            $response['message'] = 'Login successful';
            $response['nik'] = $user['nik'];
            $response['nama'] = $user['nama'];
            $response['tanggal_lahir'] = $user['tanggal_lahir'];
            $response['jenis_kelamin'] = $user['jenis_kelamin'];
            $response['no_telepon'] = $user['no_telepon'];
            $response['img_profil'] = $user['img_profil'];
            $response['kode_otp'] = $user['kode_otp'];
            $response['created_at'] = $user['created_at'];
            $response['updated_at'] = $user['updated_at'];
            // Tambahkan data pengguna lainnya ke $response jika diperlukan
        } else {
            $response['status'] = 'errorValid';
            $response['message'] = 'Invalid nik or kata_sandi';
        }
    } else {
        $response['status'] = 'error';
        $response['message'] = 'Invalid data format';
    }

} catch (PDOException $e) {
    $response['status'] = 'error';
    $response['message'] = 'Database error: ' . $e->getMessage();
} catch (Exception $e) {
    $response['status'] = 'error';
    $response['message'] = 'Error: ' . $e->getMessage();
}

// Mengembalikan response dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);
?>
<?php
// Include koneksi ke database
include 'connect.php';

// Menerima data dari Flutter
$data = json_decode(file_get_contents("php://input"));

// Mendapatkan nilai dari data
$nik = $data->nik;
$nama = $data->nama;
$jenis_kelamin = $data->jenis_kelamin;
$tanggal_lahir = $data->tanggal_lahir;
$no_telepon = $data->no_telepon;
$kata_sandi = md5($data->kata_sandi);
// Masukkan nilai ke dalam database
$query = "INSERT INTO masyarakat (nik, nama, jenis_kelamin, tanggal_lahir, no_telepon, kata_sandi) VALUES ('$nik', '$nama', '$jenis_kelamin', '$tanggal_lahir','$no_telepon', '$kata_sandi')";
$result = mysqli_query($conn, $query);

if ($result) {
    $response['status'] = 'success';
    $response['message'] = 'User registered successfully';
} else {
    $response['status'] = 'error';
    $response['message'] = 'Failed to register user';
}

// Mengembalikan response ke Flutter
echo json_encode($response);
?>
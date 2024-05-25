<?php
// Include koneksi ke database
include 'connect.php';

// Menerima data dari Flutter
$data = json_decode(file_get_contents("php://input"));

// Mendapatkan nilai dari data
$nik = $data->nik;
$email = $data->email;

// Periksa apakah email sudah terdaftar
$email_check_query = "SELECT * FROM masyarakat WHERE email='$email'";
$email_check_result = mysqli_query($conn, $email_check_query);
if(mysqli_num_rows($email_check_result) > 0) {
    $response['status'] = 'error';
    $response['message'] = 'Email already exists';
    echo json_encode($response);
    exit(); // Keluar dari skrip PHP agar tidak melanjutkan proses registrasi
}

// Periksa apakah NIK sudah terdaftar
$nik_check_query = "SELECT * FROM masyarakat WHERE nik='$nik'";
$nik_check_result = mysqli_query($conn, $nik_check_query);
if(mysqli_num_rows($nik_check_result) > 0) {
    $response['status'] = 'error';
    $response['message'] = 'NIK already exists';
    echo json_encode($response);
    exit(); // Keluar dari skrip PHP agar tidak melanjutkan proses registrasi
}

// Jika email dan NIK belum terdaftar, lanjutkan proses registrasi
$nama = $data->nama;
$jenis_kelamin = $data->jenis_kelamin;
$tanggal_lahir = $data->tanggal_lahir;
$no_telepon = $data->no_telepon;
$kata_sandi = md5($data->kata_sandi);

// Masukkan nilai ke dalam database
$query = "INSERT INTO masyarakat (nik, nama, jenis_kelamin, tanggal_lahir, email, no_telepon, kata_sandi) VALUES ('$nik', '$nama', '$jenis_kelamin', '$tanggal_lahir', '$email', '$no_telepon', '$kata_sandi')";
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

<?php
// Include koneksi ke database
include 'connect.php';

// Menerima data dari Flutter
$data = json_decode(file_get_contents("php://input"));

// Mendapatkan nilai dari data
$id_pendaftaran = $data->id_pendaftaran;
$nik = $data->nik;
$id_poli = $data->id_poli;
$tanggal_pendaftaran = $data->tanggal_pendaftaran;
$deskripsi_keluhan = $data->deskripsi_keluhan;
$status_pendaftaran = $data->status_pendaftaran;
$antrian = $data->antrian;

// Masukkan nilai ke dalam database
$query = "INSERT INTO pendaftaran (id_pendaftaran, nik, id_poli, tanggal_pendaftaran, deskripsi_keluhan, status_pendaftaran,antrian) 
VALUES ('$id_pendaftaran','$nik','$id_poli','$tanggal_pendaftaran','$deskripsi_keluhan','$status_pendaftaran','$antrian')";
$result = mysqli_query($conn, $query);

if ($result) {
    $response['status'] = 'success';
    $response['message'] = 'Berhasil menambahkan surat kematian';
} else {
    $response['status'] = 'error';
    $response['message'] = 'gagal menambah surat kematian';
}

// Mengembalikan response ke Flutter
echo json_encode($response);
?>
<?php
// Include koneksi ke database
include 'connect.php';

// Inisialisasi array untuk response
$response = array();

// Mendapatkan data dari Postman dengan metode GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Periksa apakah ID tersedia
    if (isset($_GET['id_pendaftaran'])) {
        $id_pendaftaran = $_GET['id_pendaftaran'];

        // Query untuk mengambil data pendaftaran berdasarkan ID dengan JOIN ke tabel poli_puskesmas dan masyarakat
        $query = "SELECT pendaftaran.id_pendaftaran, pendaftaran.status_pendaftaran, pendaftaran.tanggal_pendaftaran, pendaftaran.antrian, poli_puskesmas.jenis_poli, masyarakat.nama
                  FROM pendaftaran 
                  INNER JOIN poli_puskesmas ON pendaftaran.id_poli = poli_puskesmas.id_poli 
                  INNER JOIN masyarakat ON pendaftaran.nik = masyarakat.nik
                  WHERE pendaftaran.id_pendaftaran = '$id_pendaftaran'";
        $result = mysqli_query($conn, $query);

        if ($result && mysqli_num_rows($result) > 0) {
            $rowData = array();

            // Ambil semua data pada $result lalu simpan pada $rowData
            while ($row = mysqli_fetch_assoc($result)) {
                $rowData[] = $row;
            }

            $response['status'] = 'success';
            $response['data'] = $rowData; // Convert $rowData menjadi array
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Data pendaftaran tidak ditemukan untuk ID yang diberikan';
        }
    } else {
        $response['status'] = 'error';
        $response['message'] = 'ID pendaftaran tidak diterima';
    }
} else {
    $response['status'] = 'error';
    $response['message'] = 'Metode request tidak diizinkan';
}

// Mengembalikan response ke Postman
echo json_encode($response);
?>

<?php
// Include koneksi ke database
include 'connect.php';

// Inisialisasi array untuk response
$response = array();

// Mendapatkan data dari Postman dengan metode GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Periksa apakah NIK tersedia
    if (isset($_GET['nik'])) {
        $nik = $_GET['nik'];

        // Query untuk mengambil data pendaftaran berdasarkan NIK dengan JOIN ke tabel poli_puskesmas
        $query = "SELECT pendaftaran.id_pendaftaran, pendaftaran.status_pendaftaran, pendaftaran.tanggal_pendaftaran, poli_puskesmas.jenis_poli 
                  FROM pendaftaran 
                  INNER JOIN poli_puskesmas ON pendaftaran.id_poli = poli_puskesmas.id_poli 
                  WHERE pendaftaran.nik = '$nik'
                  ORDER BY pendaftaran.tanggal_pendaftaran DESC";
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
            $response['message'] = 'Data pendaftaran tidak ditemukan untuk NIK yang diberikan';
        }
    } else {
        $response['status'] = 'error';
        $response['message'] = 'NIK tidak diterima';
    }
} else {
    $response['status'] = 'error';
    $response['message'] = 'Metode request tidak diizinkan';
}

// Mengembalikan response ke Postman
echo json_encode($response);
?>

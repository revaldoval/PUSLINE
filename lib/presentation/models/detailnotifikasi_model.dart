class DetailNotifikasiModel {
  final String id_pendaftaran;
  final String status_pendaftaran;
  final String nama;
  final String tanggal_pendaftaran;
  final String antrian;
    final String jenis_poli;

  DetailNotifikasiModel({
    required this.id_pendaftaran,
    required this.status_pendaftaran,
    required this.nama,
    required this.tanggal_pendaftaran,
    required this.antrian,
    required this.jenis_poli,
  });

  factory DetailNotifikasiModel.fromJson(Map<String, dynamic> json) {
    return DetailNotifikasiModel(
      id_pendaftaran: json['id_pendaftaran'] ?? '',
      status_pendaftaran: json['status_pendaftaran'] ?? '',
      tanggal_pendaftaran: json['tanggal_pendaftaran'] ?? '',
      nama: json['nama'] ?? '',
      antrian: json['antrian'] ?? '',
      jenis_poli: json['jenis_poli'] ?? '',
    );
  }
}

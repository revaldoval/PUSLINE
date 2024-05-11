class NotifikasiListModel {
  final String id_pendaftaran;
  final String status_pendaftaran;
  final String tanggal_pendaftaran;
  final String jenis_poli;

  NotifikasiListModel({
    required this.id_pendaftaran,
    required this.status_pendaftaran,
    required this.tanggal_pendaftaran,
    required this.jenis_poli,
  });

  factory NotifikasiListModel.fromJson(Map<String, dynamic> json) {
    return NotifikasiListModel(
      id_pendaftaran: json['id_pendaftaran'] ?? '',
      status_pendaftaran: json['status_pendaftaran'] ?? '',
      tanggal_pendaftaran: json['tanggal_pendaftaran'] ?? '',
      jenis_poli: json['jenis_poli'] ?? '',
    );
  }
}

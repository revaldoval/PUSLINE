class UserModelBaru {
  final String nik;
  final String nama;
  final String tanggal_lahir;
  final String jenis_kelamin;
  final String no_telepon;
  final String email;
  final String img_profil; // Ubah menjadi String
  final String? kode_otp; // Ubah menjadi String?
  final String created_at;
  final String updated_at;

  UserModelBaru({
    required this.nik,
    required this.nama,
    required this.tanggal_lahir,
    required this.jenis_kelamin,
    required this.no_telepon,
    required this.email,
    required this.img_profil, // Ubah menjadi String
    this.kode_otp, // Ubah menjadi String?
    required this.created_at,
    required this.updated_at,
  });

  factory UserModelBaru.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['img_profil'] ?? '';

    return UserModelBaru(
      nik: json['nik'] ?? '',
      nama: json['nama'] ?? '',
      tanggal_lahir: json['tanggal_lahir'] ?? '',
      jenis_kelamin: json['jenis_kelamin'] ?? '',
      no_telepon: json['no_telepon'] ?? '',
      email: json['email'] ?? '',
      img_profil: imageUrl,
      kode_otp: json['kode_otp'], // Gunakan String? jika kode_otp dapat null
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
    );
  }
}

class ArtikelListModel {
  final String idArtikel;
  final String judul;
  final String imgArtikel;
  final String isiArtikel; // Menyimpan URL gambar

  ArtikelListModel({
    required this.idArtikel,
    required this.judul,
    required this.imgArtikel,
    required this.isiArtikel,
  });

  factory ArtikelListModel.fromJson(Map<String, dynamic> json) {
    return ArtikelListModel(
      idArtikel: json['id_artikel'] ?? '0',
      judul: json['judul'] ?? '',
      isiArtikel: json['isi_artikel'] ?? '',
      imgArtikel: json['img_artikel'] ??
          '', // Menggunakan URL gambar langsung dari respons API
    );
  }
}

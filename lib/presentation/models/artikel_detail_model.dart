class ArtikelDetailModel {
  final String idArtikel;
  final String judul;
  final String tanggalPublikasi;
  final String imgArtikel; // Menyimpan URL gambar
  final String isiArtikel;
  final String namaPenulis;

  ArtikelDetailModel({
    required this.idArtikel,
    required this.judul,
    required this.tanggalPublikasi,
    required this.imgArtikel,
    required this.isiArtikel,
    required this.namaPenulis,
  });

  factory ArtikelDetailModel.fromJson(Map<String, dynamic> json) {
    // Ambil URL gambar dari respons API
    String imgArtikelUrl = json['img_artikel'] ?? '';

    return ArtikelDetailModel(
      idArtikel: json['id_artikel'] ?? '',
      judul: json['judul'] ?? '',
      tanggalPublikasi: json['tanggal_publikasi'] ?? '',
      imgArtikel: imgArtikelUrl,
      isiArtikel: json['isi_artikel'] ?? '',
      namaPenulis: json['nama_penulis'] ?? '',
    );
  }
}
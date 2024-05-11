import 'package:flutter/material.dart';

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
    String imageUrl =
        json['img_artikel'] ?? ''; // Ambil URL gambar dari respons API

    // Jika URL gambar tidak kosong, tambahkan base URL
    if (imageUrl.isNotEmpty) {
      String baseUrl = 'http://localhost/flutter/gambar_artikel/';
      imageUrl = baseUrl + imageUrl;
    }

    return ArtikelDetailModel(
      idArtikel: json['id_artikel'] ?? '',
      judul: json['judul'] ?? '',
      tanggalPublikasi: json['tanggal_publikasi'] ?? '',
      imgArtikel: imageUrl,
      isiArtikel: json['isi_artikel'] ?? '',
      namaPenulis: json['nama_penulis'] ?? '',
    );
  }
}

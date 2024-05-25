import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/models/artikel_detail_model.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArtikelPage extends StatelessWidget {
  final String artikelId;

  const ArtikelPage({
    Key? key,
    required this.artikelId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(); // Instansiasi ApiService
    final baseUrl = apiService.baseUrl; // Ambil baseUrl dari ApiService

    return FutureBuilder<ArtikelDetailModel?>(
      future: fetchArtikelDetail(baseUrl,
          artikelId), // Mengambil data artikel detail dengan baseUrl dan artikelId
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData) {
          final artikelDetail = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Artikel", style: CustomTextStyles.titleMediumMedium),
              centerTitle: true,
              backgroundColor: Color(0xFF49A18C),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text(
                          artikelDetail.judul,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF398172),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 5),
                            Text(artikelDetail.tanggalPublikasi),
                            SizedBox(width: 20),
                            Icon(Icons.person),
                            SizedBox(width: 5),
                            Text(artikelDetail.namaPenulis),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Menggunakan Image.network untuk mengambil gambar dari jaringan
                        Image.network(
                          'http://puskesline.tifnganjuk.com/${artikelDetail.imgArtikel}',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20),
                        Text(
                          artikelDetail.isiArtikel,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: Text('Artikel tidak ditemukan'));
        }
      },
    );
  }

  Future<ArtikelDetailModel?> fetchArtikelDetail(
      String baseUrl, String artikelId) async {
    try {
      print('artikel id : $artikelId');
      final response = await http
          .get(Uri.parse('$baseUrl/artikel_detail.php?id_artikel=$artikelId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return ArtikelDetailModel.fromJson(responseData['data']);
        } else {
          print(responseData['message']);
          return null; // Handle API errors gracefully
        }
      } else {
        throw Exception(
            'Failed to load article details: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print(error);
      return null;
    }
  }
}

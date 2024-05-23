import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/artikel_2/detail_artikel.dart';
import 'package:tolong_s_application1/presentation/models/artikel_list_model.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Artikel extends StatefulWidget {
  const Artikel({Key? key}) : super(key: key);

  @override
  State<Artikel> createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
  late Future<List<ArtikelListModel>> _artikelList;

  @override
  void initState() {
    super.initState();
    _artikelList = fetchArtikels();
  }

  Future<List<ArtikelListModel>> fetchArtikels() async {
    final apiService = ApiService();
    try {
      final response = await http.get(
          Uri.parse('${apiService.baseUrl}/artikel_list.php?id_artikel=1'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> jsonData = responseData['data'];
          return jsonData
              .map((item) => ArtikelListModel.fromJson(item))
              .toList();
        } else {
          print(responseData['message']);
          return []; // Handle API errors gracefully
        }
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print(error);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Artikel",
            style: CustomTextStyles.titleMediumMedium,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF49A18C),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 3),
          child: FutureBuilder<List<ArtikelListModel>>(
            future: _artikelList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final artikels = snapshot.data!;
                if (artikels.isEmpty) {
                  return Center(child: Text('No articles found'));
                }
                return ListView.builder(
                  itemCount: artikels.length,
                  itemBuilder: (context, index) {
                    final artikel = artikels[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      child: ArtikelBox(
                        artikel: artikel,
                        apiService: ApiService(), // Pass ApiService instance
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class ArtikelBox extends StatelessWidget {
  final ArtikelListModel artikel;
  final ApiService apiService; // Add ApiService field

  const ArtikelBox({Key? key, required this.artikel, required this.apiService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = artikel.imgArtikel.isNotEmpty
        ? Uri.http('192.168.0.104:8080',
                '/flutter/images/artikel/${artikel.imgArtikel}')
            .toString()
        : 'assets/images/chael.jpeg';
// Ganti dengan placeholder image

    return GestureDetector(
      onTap: () {
        print('artikel id from list : ${artikel.judul}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtikelPage(artikelId: artikel.idArtikel),
          ),
        );
      },
      child: Container(
        height: 105,
        decoration: BoxDecoration(
          color: Color(0xffC4EFD2),
          borderRadius: BorderRadius.circular(7.0),
        ),
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Menggunakan Image.network dengan URL yang sudah diformat dengan host
                image: DecorationImage(
                  image: NetworkImage(
                      imageUrl), // Menggunakan URL gambar yang sudah diformat dengan host
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artikel.judul.length > 70
                        ? '${artikel.judul.substring(0, 70)}...'
                        : artikel.judul,
                    style: CustomTextStyles.notifikasi,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

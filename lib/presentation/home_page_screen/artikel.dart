import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/artikel_2/detail_artikel.dart';
import 'package:tolong_s_application1/presentation/models/artikel_list_model.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

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
      final response =
          await http.get(Uri.parse('${apiService.baseUrl}/artikel_list.php'));
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
          padding: EdgeInsets.all(8),
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
                      padding: EdgeInsets.symmetric(vertical: 8),
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
        ? Uri.http('puskesline.tifnganjuk.com', artikel.imgArtikel).toString()
        : 'assets/images/icon_artikel.png';

    return GestureDetector(
      onTap: () {
        print('artikel id from list : ${artikel.judul}');
        Get.to(() => ArtikelPage(artikelId: artikel.idArtikel),
            transition: Transition.fadeIn);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white, // Ubah warna latar belakang card
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artikel.judul,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ubah warna judul
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      artikel.isiArtikel,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

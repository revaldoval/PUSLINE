import 'package:flutter/material.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:get/get.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/notifikasi_model.dart'; // Ubah import sesuai dengan nama file model yang sesuai
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({Key? key}) : super(key: key);

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  late Future<List<NotifikasiListModel>> _NotifikasiList;

  @override
  void initState() {
    super.initState();
    _NotifikasiList = fetchNotiications();
  }

  Future<List<NotifikasiListModel>> fetchNotiications() async {
    final apiService = ApiService();
    UserModelBaru? user =
        Provider.of<UserProvider>(context, listen: false).userBaru;
    final String nik = user!.nik;
    try {
      final response = await http
          .get(Uri.parse('${apiService.baseUrl}/get_notifikasi.php?nik=$nik'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> jsonData = responseData['data'];
          return jsonData
              .map((item) => NotifikasiListModel.fromJson(item))
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
            "Notifikasi",
            style: CustomTextStyles.titleMediumMedium,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF49A18C),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 3),
          child: FutureBuilder<List<NotifikasiListModel>>(
            future: _NotifikasiList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final notifications = snapshot.data!;
                if (notifications.isEmpty) {
                  return Center(child: Text('No notifications found'));
                }
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notifikasi = notifications[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      child: NotifBox(
                        notifikasi: notifikasi,
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

class NotifBox extends StatelessWidget {
  final NotifikasiListModel notifikasi;
  final ApiService apiService; // Add ApiService field

  const NotifBox({Key? key, required this.notifikasi, required this.apiService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath = ''; // Default image path

    // Set image path based on status_pendaftaran
    switch (notifikasi.status_pendaftaran) {
      case 'Ditolak':
        imagePath = 'assets/images/notifditolak.png';
        break;
      case 'Diterima':
        imagePath = 'assets/images/notifselesai.png';
        break;
      case 'Diproses':
        imagePath = 'assets/images/notifproses.png';
        break;
      default:
        // Default image if status_pendaftaran is not recognized
        imagePath = 'assets/images/default.png';
    }

    return GestureDetector(
      onTap: () {
        // Add navigation functionality if needed
      },
      child: Container(
        height: 111,
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
                image: DecorationImage(
                  image:
                      AssetImage(imagePath), // Use AssetImage for local images
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pendaftaran Anda " + notifikasi.status_pendaftaran,
                    style: notifikasi.status_pendaftaran == "Diproses"
                        ? CustomTextStyles.notifikasi
                        : notifikasi.status_pendaftaran == "Ditolak"
                            ? CustomTextStyles.notifikasiditolak
                            : CustomTextStyles.notifikaditerima,
                  ),

                  Text(
                    notifikasi.tanggal_pendaftaran,
                    style: CustomTextStyles.poppin12black,
                  ),
                  SizedBox(height: 5),
                  Text(
                    notifikasi.jenis_poli,
                    style: CustomTextStyles.poppin12black,
                  ),
                  SizedBox(height: 5),
                  // Implementasi berdasarkan nilai status_pendaftaran
                  if (notifikasi.status_pendaftaran == 'Ditolak')
                    SizedBox(), // Tidak ada widget di sini
                  if (notifikasi.status_pendaftaran == 'Diterima')
                    SizedBox(), // Tidak ada widget di sini
                  if (notifikasi.status_pendaftaran == 'Diproses')
                    SizedBox(), // Tidak ada widget di sini
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

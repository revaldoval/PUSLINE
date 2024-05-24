import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';
import '../models/detailnotifikasi_model.dart';
import 'package:http/http.dart' as http;

class DetailNotifikasi extends StatefulWidget {
  final String id_pendaftaran;
  const DetailNotifikasi({Key? key, required this.id_pendaftaran})
      : super(key: key);

  @override
  State<DetailNotifikasi> createState() => _DetailNotifikasiState();
}

class _DetailNotifikasiState extends State<DetailNotifikasi> {
  Future<DetailNotifikasiModel?> fetchDetailNotifikasi(
      String baseUrl, String id_pendaftaran) async {
    try {
      print('id_pendaftaran : $id_pendaftaran');
      final response = await http.get(Uri.parse(
          '$baseUrl/detailnotifikasi.php?id_pendaftaran=$id_pendaftaran'));
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('status') &&
            responseData['status'] == 'success' &&
            responseData.containsKey('data')) {
          return DetailNotifikasiModel.fromJson(responseData['data'][0]);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to load article details: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final baseUrl = apiService.baseUrl;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF49A18C),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Detail Notifikasi',
                  style: CustomTextStyles.detailnotif,
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 30,
              right: 30,
              height: 550,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FutureBuilder<DetailNotifikasiModel?>(
                  future: fetchDetailNotifikasi(baseUrl, widget.id_pendaftaran),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error.toString()}'));
                    } else {
                      if (snapshot.hasData && snapshot.data != null) {
                        final detail = snapshot.data!;
                        Color textColor;
                        Icon IconAsset;
                        if (detail.status_pendaftaran == 'Diterima') {
                          textColor = Colors.green;
                          IconAsset = Icon(Icons.check_circle,
                              color: Colors.green, size: 80);
                          // imageAsset = 'assets/images/notifselesai.png';
                        } else if (detail.status_pendaftaran == 'Ditolak') {
                          textColor = Colors.red;
                          IconAsset =
                              Icon(Icons.error, color: Colors.red, size: 80);
                          // imageAsset = 'assets/images/notifditolak.png';
                        } else if (detail.status_pendaftaran == 'Diproses') {
                          textColor = Colors.amber;
                          IconAsset = Icon(Icons.watch_later,
                              color: Colors.amber, size: 80);
                          // imageAsset = 'assets/images/notifproses.png';
                        } else {
                          textColor = Colors.black;
                          IconAsset = Icon(Icons.disabled_by_default_outlined,
                              color: Colors.black); // Default color
                          // imageAsset =
                          //     'assets/images/notifdefault.png'; // Default image
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 41, // Padding kiri
                                ),
                                child: IconAsset,
                              ),
                            ),
                            SizedBox(height: 0),
                            Text(
                              detail.status_pendaftaran,
                              style: CustomTextStyles.detailnotif2
                                  .copyWith(color: textColor),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Text "Nama Lengkap"
                            Row(
                              children: [
                                SizedBox(width: 35), // Padding kiri
                                Opacity(
                                  opacity: 0.5, // Set transparansi menjadi 50%
                                  child: Text('Nama Lengkap'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 35), // Padding kiri
                                Text(detail.nama,
                                    style: CustomTextStyles.notifikasi),
                              ],
                            ),
                            SizedBox(height: 15),
                            // Text "Jenis Poli"
                            Row(
                              children: [
                                SizedBox(width: 35), // Padding kiri
                                Opacity(
                                  opacity: 0.5, // Set transparansi menjadi 50%
                                  child: Text('Jenis Poli'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 35), // Padding kiri
                                Text(detail.jenis_poli,
                                    style: CustomTextStyles.notifikasi),
                              ],
                            ),
                            SizedBox(height: 15),
                            // Text "Status"
                            Row(
                              children: [
                                SizedBox(width: 35), // Padding kiri
                                Opacity(
                                  opacity: 0.5, // Set transparansi menjadi 50%
                                  child: Text('Status'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 35), // Padding kiri
                                Text(
                                  detail.status_pendaftaran,
                                  style: CustomTextStyles.notifikaditerima
                                      .copyWith(color: textColor),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Text "Tanggal" and "Antrian" side by side
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Opacity(
                                        opacity: 0.5,
                                        child: Text('Tanggal'),
                                      ),
                                      SizedBox(height: 10),
                                      Text(detail.tanggal_pendaftaran,
                                          style: CustomTextStyles.notifikasi),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 35),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Opacity(
                                        opacity: 0.5,
                                        child: Text('Antrian'),
                                      ),
                                      SizedBox(height: 10),
                                      Text(detail.antrian,
                                          style: CustomTextStyles.notifikasi),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Center(child: Text('Data is null'));
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: null,
      ),
    );
  }
}

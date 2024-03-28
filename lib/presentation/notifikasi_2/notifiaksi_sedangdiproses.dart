import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/home_page_screen.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import '../home_page_screen/beranda.dart';
import '../home_page_screen/home_page_screen.dart';

class Diproses extends StatefulWidget {
  const Diproses({Key? key}) : super(key: key);

  @override
  State<Diproses> createState() => _DiprosesState();
}

class _DiprosesState extends State<Diproses> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF49A18C),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            // Content
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
              top: 100, // 12 is half of the font size
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
              left: 8,
              right: 8,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 41, // Padding kiri
                        ),
                        child: Image.asset(
                          'assets/images/notifproses.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),

                    SizedBox(height: 0),
                    Text('SEDANG DI PROSES', style: CustomTextStyles.detailnotifRED),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
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
                          child: Text(
                            'Nama Lengkap',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Text "Michael Revaldo" (huruf tebal)
                    Row(
                      children: [
                        SizedBox(width: 35), // Padding kiri
                        Text('MICHAEL REVALDO',
                            style: CustomTextStyles.notifikasi),
                      ],
                    ),
                    SizedBox(height: 15),

                    // Text "NIK"
                    Row(
                      children: [
                        SizedBox(width: 35), // Padding kiri
                        Opacity(
                          opacity: 0.5, // Set transparansi menjadi 50%
                          child: Text(
                            'NIK',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Text "1234567890123456" (huruf tebal)
                    Row(
                      children: [
                        SizedBox(width: 35), // Padding kiri
                        Text('1234567890123456',
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
                          child: Text(
                            'Status',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Text "Telah Diterima" (huruf tebal dan warna hijau)
                    Row(
                      children: [
                        SizedBox(width: 35), // Padding kiri
                        Text('Sedang Di Proses',
                            style: CustomTextStyles.notifikasimerah),
                      ],
                    ),
                    SizedBox(height: 15),

                    // Garis
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Text "Tanggal"
                    Row(
                      children: [
                        SizedBox(width: 35), // Padding kiri
                        Opacity(
                          opacity: 0.5, // Set transparansi menjadi 50%
                          child: Text(
                            'Tanggal',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Text "19 Maret 2024" (huruf tebal)
                    Row(
                      children: [
                        SizedBox(width: 35), // Padding kiri
                        Text('19 Maret 2024',
                            style: CustomTextStyles.notifikasi),
                      ],
                    ),
                  ],
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

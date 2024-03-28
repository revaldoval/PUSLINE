import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/artikel_2/detail_artikel.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import '../notifikasi_2/notifikasi_selesai.dart';
import '../notifikasi_2/notifikasi_ditolak.dart';
import '../notifikasi_2/notifiaksi_sedangdiproses.dart';
import 'package:get/get.dart';

class Artikel extends StatefulWidget {
  const Artikel({Key? key}) : super(key: key);

  @override
  State<Artikel> createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {
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
          padding: EdgeInsets.only(top: 3), // Jarak antara app bar dan body
          child: ListView.builder(
            itemCount: 3, // Jumlah kotak notifikasi
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 6), // Jarak antara kotak notifikasi
                child: ArtikelBox(index: index),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ArtikelBox extends StatelessWidget {
  final int index;

  const ArtikelBox({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "";
    String subTitle1 = "";
    String subTitle2 = "";
    String image = "";

    if (index == 0) {
      title = "Pentingnya Imunisasi";
      subTitle1 = "11 Maret 2024";
      subTitle2 = "Imunisasi..";
      image = "assets/images/refi.jpeg";
    } else if (index == 1) {
      title = "Pentingnya Imunisasi";
      subTitle1 = "11 Maret 2024";
      subTitle2 = "Imunisasi..";
      image = "assets/images/eva.jpeg";
    } else {
      title = "Pentingnya Imunisasi";
      subTitle1 = "11 Maret 2024";
      subTitle2 = "Imunisasi..";
      image = "assets/images/renaldi.jpeg";
    }

    return GestureDetector(
      onTap: () {
        if (title == "Pentingnya Imunisasi") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ArtikelPage()),
          // );
          Get.to(ArtikelPage());
        } else if (title == "Pentingnya Imunisasi") {
          Get.to(ArtikelPage());
        } else if (title == "Pentingnya Imunisasi") {
          Get.to(ArtikelPage());
        }
      },
      child: Container(
        height: 100,
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
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTextStyles.notifikasi,
                ),
                Text(subTitle1),
                Text(subTitle2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import '../notifikasi_2/notifikasi_selesai.dart';
import '../notifikasi_2/notifikasi_ditolak.dart';
import '../notifikasi_2/notifiaksi_sedangdiproses.dart';
import 'package:get/get.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({Key? key}) : super(key: key);

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
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
          padding: EdgeInsets.only(top: 3), // Jarak antara app bar dan body
          child: ListView.builder(
            itemCount: 3, // Jumlah kotak notifikasi
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 6), // Jarak antara kotak notifikasi
                child: NotifikasiBox(index: index),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotifikasiBox extends StatelessWidget {
  final int index;

  const NotifikasiBox({
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
      title = "Selesai";
      subTitle1 = "Puskesman Gento";
      subTitle2 = "Poli Gigi";
      image = "assets/images/bhit.jpeg";
    } else if (index == 1) {
      title = "Sedang Diproses";
      subTitle1 = "Puskesman Wong Magetan";
      subTitle2 = "Imunisasi";
      image = "assets/images/itsme.jpeg";
    } else {
      title = "Ditolak Karena Berbahaya";
      subTitle1 = "Gasthof zum Pommer";
      subTitle2 = "Vienna Academy of Fine Arts";
      image = "assets/images/renaldi.jpeg";
    }

    return GestureDetector(
      onTap: () {
        if (title == "Selesai") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Selesai()),
          // );
          Get.to(
            Selesai(),
            transition: Transition.fadeIn,
          );
        } else if (title == "Sedang Diproses") {
          Get.to(Diproses(),transition: Transition.fadeIn,);
        } else if (title == "Ditolak Karena Berbahaya") {
          Get.to(Ditolak(),transition: Transition.fadeIn,);
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

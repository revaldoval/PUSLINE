import 'package:flutter/material.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';

class ArtikelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Artikel", style: CustomTextStyles.titleMediumMedium),
        centerTitle: true,
        backgroundColor: Color(0xFF49A18C),
        iconTheme: IconThemeData(color: Colors.white),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Mengatasi Stress dengan Bermain Game, Emang Bisa?",
                    textAlign: TextAlign
                        .center, // Mengatur teks berada di tengah secara horizontal
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF15AFA7)),
                    overflow: TextOverflow
                        .ellipsis, // Jika lebih dari 12 karakter, ditampilkan ...
                    maxLines: 1, // Hanya satu baris
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 5),
                      Text("11/03/2024"),
                      SizedBox(width: 20),
                      Icon(Icons.person),
                      SizedBox(width: 5),
                      Text("Renaldi Diii"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/saberijo.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Bermain game dapat menjadi cara yang efektif untuk mengurangi stres bagi sebagian orang. Namun, pengalaman bermain game bisa berbeda tergantung pada jenis game yang dimainkan. Sebagai contoh, game seperti Mobile Legends dengan sifatnya yang sangat kompetitif dan atmosfer yang seringkali toksik dapat meningkatkan tingkat stres daripada menguranginya. Oleh karena itu, penting untuk memilih game yang memberikan kesenangan dan relaksasi yang sehat bagi pikiran dan tubuh Anda.",
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
  }
}

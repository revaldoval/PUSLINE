import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';

class UbahProfil extends StatefulWidget {
  const UbahProfil({Key? key}) : super(key: key);

  @override
  State<UbahProfil> createState() => _UbahProfilState();
}

class _UbahProfilState extends State<UbahProfil> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            
            Center(
              child: Container(
                width: 180,
                height: 187,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logokemenkes.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 37, bottom: 710),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 16,
                  decoration: BoxDecoration(
                    color: Color(0xff15AFA7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90, // 90 dari atas layar
              left: (MediaQuery.of(context).size.width - 87) /
                  2, // Pusat secara horizontal
              child: ClipOval(
                child: Container(
                  width: 87,
                  height: 87,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // Warna border putih
                      width: 3, // Ketebalan border 5
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/renaldi.jpeg', // Ganti dengan path foto Anda
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Mengubah widget Text menjadi Column
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7), // Jarak antara teks dan kotak
                  Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Color(0xff15AFA7),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Michael Jordan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    'NIK',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7), // Jarak antara teks dan kotak
                  Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Color(0xff15AFA7),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '3321110902070002',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    'Tanggal Lahir',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7), // Jarak antara teks dan kotak
                  Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Color(0xff15AFA7),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '17 Agustus 1945',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7), // Jarak antara teks dan kotak
                  Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Color(0xff15AFA7),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Laki - Laki',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    'Nomor Telepon',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7), // Jarak antara teks dan kotak
                  Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Color(0xff15AFA7),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '081348526548',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Action ketika tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        minimumSize: Size(400, 60),
                        backgroundColor: Color(0xFF15AFA7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Simpan Profil',
                        style: CustomTextStyles.poppins13
                            .copyWith(color: Colors.white),
                      ),
                    ),
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

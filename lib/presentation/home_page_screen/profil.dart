import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tolong_s_application1/presentation/models/user_model_baru.dart';
import 'package:tolong_s_application1/presentation/ubah_profil/ubahprofil.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late UserModelBaru _user = UserModelBaru(
    nik: '',
    nama: '',
    tanggal_lahir: '',
    jenis_kelamin: '',
    no_telepon: '',
    email: '',
    img_profil: '',
    kode_otp: '',
    created_at: '',
    updated_at: '',
  );

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    UserModelBaru? user =
        Provider.of<UserProvider>(context, listen: false).userBaru;
    final String nik = user!.nik;
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.0.104:8080/flutter/profil_read.php?nik=$nik'));

      print('STATUS CODE : ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          _user = UserModelBaru.fromJson(responseData['data']);
        });

        print(responseData['data']);
      } else {
        setState(() {});
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100), // Added margin bottom here
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 70), // Added margin top for the profile photo
                  ClipOval(
                    child: Container(
                      width: 87,
                      height: 87,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: _user.img_profil.isNotEmpty
                            ? Image.network(
                                'http://192.168.0.104:8080/flutter/images/profil/${_user.img_profil}',
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/null.jpg',
                                fit: BoxFit.cover,
                              ), // Placeholder image
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7),
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
                        _user.nama,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                  Text(
                    'NIK',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7),
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
                        _user.nik,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                  Text(
                    'Tanggal Lahir',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7),
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
                        _user?.tanggal_lahir ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                  Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7),
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
                        _user?.jenis_kelamin ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 7),
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
                        _user.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 58),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UbahProfil(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      minimumSize: Size(MediaQuery.of(context).size.width - 32,
                          60), // Updated minimumSize value
                      backgroundColor: Color(0xFF15AFA7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Ubah Profil',
                      style: CustomTextStyles.poppins13
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

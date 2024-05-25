import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/profil.dart';
import 'package:tolong_s_application1/presentation/ubah_profil/ProfilUpdate_OTP.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:tolong_s_application1/widgets/buttondaftarpasien.dart';
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';

class UbahProfil extends StatefulWidget {
  const UbahProfil({Key? key}) : super(key: key);

  @override
  State<UbahProfil> createState() => _UbahProfilState();
}

class _UbahProfilState extends State<UbahProfil> {
  final ApiService apiService = ApiService();
  File? _imageFile;
  String? fotoProfile;
  final picker = ImagePicker();
  Map<String, dynamic>? _profilData;
  Map<String, TextEditingController> _controllers = {};
  TextEditingController _tanggalLahirController =
      TextEditingController(); // Tambahkan baris ini
  String? _selectedJenisKelamin;

  @override
  void initState() {
    super.initState();
    _fetchProfilData();
  }

  Future<void> _fetchProfilData() async {
    try {
      final apiService = ApiService();
      UserModelBaru? user =
          Provider.of<UserProvider>(context, listen: false).userBaru;
      final String nik = user!.nik;
      final response = await http.get(Uri.parse(
          'http://puskesline.tifnganjuk.com/MobileApi/profil_update.php?nik=$nik'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('on success');
        setState(() {
          _profilData = jsonData['data'];
          if (_profilData?['img_profil'] == null ||
              _profilData?['img_profil'] == '') {
            fotoProfile =
                'http://puskesline.tifnganjuk.com/MobileApi/images/foto_profil/null.jpg';
          } else {
            fotoProfile =
                'http://puskesline.tifnganjuk.com/MobileApi/images/foto_profil/${_profilData!['img_profil'] ?? ''}';
          }
          print('foto profile : $fotoProfile');
          _imageFile = null;
          _controllers = {
            'nama': TextEditingController(text: _profilData?['nama'] ?? ''),
            'nik': TextEditingController(text: _profilData?['nik'] ?? ''),
            'tanggal_lahir': TextEditingController(
                text: _profilData?['tanggal_lahir'] ?? ''),
            'jenis_kelamin': TextEditingController(
                text: _profilData?['jenis_kelamin'] ?? ''),
            'email': TextEditingController(text: _profilData?['email'] ?? ''),
          };
        });
        _tanggalLahirController.text =
            _profilData?['tanggal_lahir'] ?? ''; // Set default date value
        _selectedJenisKelamin = _profilData?['jenis_kelamin'] ??
            ''; // Set default jenis kelamin value
      } else {
        print('on failure');
        _imageFile = null;
        _profilData = null;
        throw Exception('Failed to load profile data: ${response.statusCode}');
      }
    } catch (error) {
      print('on exception : ${error.toString()}');
      _imageFile = null;
      _profilData = null;
      print(error);
      // Handle errors
    }
  }

  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        fotoProfile = null;
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
        _imageFile = null;
      }
    });
  }

  Future<http.Client> createHttpClient() async {
    final ioClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    return IOClient(ioClient);
  }

  Future<void> updateProfile() async {
    final url = Uri.parse(
        'https://puskesline.tifnganjuk.com/MobileApi/profil_update.php');
    final httpClient = await createHttpClient();
    final request = http.MultipartRequest('POST', url)
      ..fields['nama'] = _controllers['nama']?.text ?? ''
      ..fields['nik'] = _controllers['nik']?.text ?? ''
      ..fields['tanggal_lahir'] = _tanggalLahirController.text
      ..fields['jenis_kelamin'] = _selectedJenisKelamin ?? ''
      ..fields['email'] = _controllers['email']?.text ?? '';

    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'img_profil', // Match the PHP code
        _imageFile!.path,
        filename: 'img_profil', // Match the PHP code
      ));
    }

    try {
      final streamedResponse = await httpClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);

        if (responseData['status'] == 'success') {
          alert(context, "Berhasil mengubah profil", "Berhasil!", Icons.check,
              Colors.green);
          setState(() {
            _fetchProfilData();
          });
        } else {
          throw Exception('Gagal mengubah profil: ${responseData['message']}');
        }
      } else {
        throw Exception('Gagal mengubah profil: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      alert(
          context, "Gagal mengubah profil", "Gagal!", Icons.error, Colors.red);
    }
  }

  void _showAlert(BuildContext context, String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          title: Text(
            message,
            style: TextStyle(color: Colors.white), // Warna teks putih
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (message == 'Berhasil mengubah profil') {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Profil()),
                  // );
                }
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 50), // Add bottom margin
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 480,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF49A18C),
                          borderRadius: BorderRadius.circular(
                              7), // Set the desired radius here
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28, left: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset:
                            Offset(0, 30), // Move the circle down by 30 pixels
                        child: GestureDetector(
                          onTap: getImage,
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
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      fotoProfile != null || _imageFile != null
                                          ? ClipOval(
                                              child: CircleAvatar(
                                                radius: 43.5,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: fotoProfile !=
                                                        null
                                                    ? NetworkImage(fotoProfile!)
                                                        as ImageProvider<Object>
                                                    : _imageFile != null
                                                        ? FileImage(_imageFile!)
                                                            as ImageProvider<
                                                                Object>
                                                        : null,
                                                child: null,
                                              ),
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Colors.white,
                                            ),
                                      // Adding the camera icon
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 20,
                                            color: Color(0xFF49A18C),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IgnorePointer(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          controller: _controllers['nama'],
                        ),
                      ),
                      SizedBox(height: 23),
                      IgnorePointer(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'NIK',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          controller: _controllers['nik'],
                        ),
                      ),
                      SizedBox(height: 23),
                      IgnorePointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Tanggal Lahir',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          controller: _tanggalLahirController,
                        ),
                      ),
                      SizedBox(height: 23),
                      IgnorePointer(
                        child: IgnorePointer(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Jenis Kelamin',
                              labelStyle:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            value: _selectedJenisKelamin,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedJenisKelamin = newValue;
                              });
                            },
                            dropdownColor: Colors
                                .grey, // Ubah warna latar belakang dropdown di sini
                            items: [
                              DropdownMenuItem(
                                value: 'Laki-laki',
                                child: Text(
                                  'Laki-laki',
                                  style: TextStyle(
                                      color: Colors
                                          .grey), // Ubah warna teks di sini
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Perempuan',
                                child: Text(
                                  'Perempuan',
                                  style: TextStyle(
                                      color: Colors
                                          .grey), // Ubah warna teks di sini
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 23),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 16),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: _controllers['email'],
                      ),
                      SizedBox(height: 80),

                      // width: 600,
                      // height: 50,
                      // updateProfile();
                      Container(
                        width: 480,
                        child: ButtonDaftarPasien(
                          text: 'Simpan Profil',
                          onPressed: () async {
                            // Mendapatkan email sebelumnya dari profil data
                            String? previousEmail = _profilData?['email'];

                            // Membandingkan email sebelumnya dengan email yang baru
                            bool emailChanged =
                                previousEmail != _controllers['email']?.text;

                            // Membandingkan gambar profil sebelumnya dengan gambar profil yang baru
                            bool imageChanged = _imageFile != null;

                            // Membandingkan nilai-nilai lainnya dengan nilai-nilai sebelumnya
                            bool otherChanges = _controllers['nama']?.text !=
                                    _profilData?['nama'] ||
                                _controllers['nik']?.text !=
                                    _profilData?['nik'] ||
                                _tanggalLahirController.text !=
                                    _profilData?['tanggal_lahir'] ||
                                _selectedJenisKelamin !=
                                    _profilData?['jenis_kelamin'];

                            // Jika tidak ada perubahan pada email dan gambar profil serta nilai-nilai lainnya
                            if (!emailChanged &&
                                !imageChanged &&
                                !otherChanges) {
                              alert(context, "Tidak ada data yang dirubah",
                                  "Gagal!", Icons.error, Colors.red);
                            } else {
                              // Jika ada perubahan pada salah satu data, lanjutkan dengan proses sesuai kondisi sebelumnya
                              if (emailChanged) {
                                // Proses jika ada perubahan pada email
                                if (!_isValidEmail(
                                    _controllers['email']?.text ?? '')) {
                                  alert(context, "Format Email tidak valid",
                                      "Gagal!", Icons.error, Colors.red);
                                } else {
                                  try {
                                    Map<String, dynamic> responseData =
                                        await apiService.beforenext3(
                                            _controllers['email']?.text ?? '');
                                    if (responseData['status'] == 'error') {
                                      alert(context, responseData['message'],
                                          "Gagal!", Icons.error, Colors.red);
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfilOTP(
                                            nama: _controllers['nama']?.text ??
                                                '',
                                            nik:
                                                _controllers['nik']?.text ?? '',
                                            tanggal_lahir:
                                                _tanggalLahirController.text,
                                            jenis_kelamin:
                                                _selectedJenisKelamin ?? '',
                                            email:
                                                _controllers['email']?.text ??
                                                    '',
                                            imageFile: _imageFile,
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print("Error: $e");
                                    alert(
                                        context,
                                        "Terjadi kesalahan saat memeriksa email",
                                        "Gagal!",
                                        Icons.error,
                                        Colors.red);
                                  }
                                }
                              } else {
                                // Proses jika tidak ada perubahan pada email
                                updateProfile();
                              }
                            }
                          },
                          buttonStyle: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            // Sesuaikan padding dengan gaya pada halaman Imunisasi
                            primary: Color(
                                0xFF49A18C), // Sesuaikan warna latar belakang tombol dengan gaya pada halaman Imunisasi
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  4), // Sesuaikan border radius dengan gaya pada halaman Imunisasi
                            ),
                          ),
                        ),
                      ),
                      // child: ElevatedButton(
                      // onPressed: () {
                      //   updateProfile();
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     padding: EdgeInsets.symmetric(horizontal: 50),
                      //     backgroundColor: Color(0xFF15AFA7),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(4),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     'Simpan Profil',
                      //     style: CustomTextStyles.poppins13
                      //         .copyWith(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool _isValidEmail(String email) {
  // Menggunakan regular expression untuk memeriksa format email
  // Ini adalah contoh regular expression yang sederhana, Anda dapat menyesuaikan sesuai kebutuhan Anda
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

void alert(BuildContext context, String message, String title, IconData icon,
    Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context, message, title, icon, color),
      );
    },
  );
}

Widget contentBox(BuildContext context, String message, String title,
    IconData icon, Color color) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
          left: 20,
          top: 45,
          right: 20,
          bottom: 20,
        ),
        margin: EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 22),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OKE',
                  style: TextStyle(color: Color(0xFF49A18C)),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 20,
        right: 20,
        child: CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    ],
  );
}

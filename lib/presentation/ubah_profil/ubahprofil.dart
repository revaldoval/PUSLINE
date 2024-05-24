import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/profil.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
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
          _showAlert(context, 'Berhasil mengubah profil', Colors.green);
        } else {
          throw Exception(
              'Failed to update profile: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      _showAlert(context, 'Gagal mengubah profil', Colors.red);
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
          child: Stack(
            children: [
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
                top: 40,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 90,
                left: (MediaQuery.of(context).size.width - 87) / 2,
                child: GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 43.5, // Setengah dari lebar Container
                    backgroundColor:
                        Colors.transparent, // Atur latar belakang transparan
                    backgroundImage: fotoProfile != null
                        ? NetworkImage(fotoProfile!) as ImageProvider<Object>
                        : _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider<Object>
                            : null,
                    child: fotoProfile == null && _imageFile == null
                        ? Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ) // Tampilkan ikon jika tidak ada gambar
                        : null, // Kosong jika ada gambar
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 20,
                right: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IgnorePointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          labelStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: _controllers['nama'],
                      ),
                    ),
                    SizedBox(height: 23),
                    IgnorePointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'NIK',
                          labelStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: _controllers['nik'],
                      ),
                    ),
                    SizedBox(height: 23),
                    IgnorePointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          labelStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        controller: _tanggalLahirController,
                      ),
                    ),
                    SizedBox(height: 23),
                    IgnorePointer(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Jenis Kelamin',
                          labelStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        value: _selectedJenisKelamin,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedJenisKelamin = newValue;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'Laki-laki',
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: 'Perempuan',
                            child: Text('Perempuan'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 23),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        alignLabelWithHint: true, // Mengatur label rata tengah
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      textAlign:
                          TextAlign.left, // Mengatur isian teks rata kiri
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _controllers['email'],
                    ),
                    SizedBox(height: 58),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                        onPressed: () {
                          updateProfile();
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
      ),
    );
  }
}

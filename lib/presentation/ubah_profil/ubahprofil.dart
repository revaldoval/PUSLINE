import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/profil.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';

class UbahProfil extends StatefulWidget {
  const UbahProfil({Key? key}) : super(key: key);

  @override
  State<UbahProfil> createState() => _UbahProfilState();
}

class _UbahProfilState extends State<UbahProfil> {
  File? _imageFile;
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
      final response = await http.get(
          Uri.parse('http://172.16.104.49/flutter/profil_update.php?nik=1'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('on success');
        setState(() {
          _profilData = jsonData['data'];
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
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
        _imageFile = null;
      }
    });
  }

  Future<void> updateProfile() async {
    final url = Uri.parse('https://172.16.104.49/flutter/profil_update.php');
    final request = http.MultipartRequest('POST', url);
    request.fields['nama'] = _controllers['nama']?.text ?? '';
    request.fields['nik'] = _controllers['nik']?.text ?? '';
    request.fields['tanggal_lahir'] = _tanggalLahirController.text;
    request.fields['jenis_kelamin'] = _selectedJenisKelamin ?? '';
    request.fields['email'] = _controllers['email']?.text ?? '';
    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _imageFile!.path,
        filename: 'image.jpg',
      ));
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);

        // Check if the response contains 'success' message
        if (responseData['status'] == 'success') {
          // Show success alert and navigate to Profil.dart
          _showAlert(context, 'Berhasil mengubah profil', Colors.green);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Profil()),
          );
        } else {
          throw Exception(
              'Failed to update profile: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      // Show error alert
      _showAlert(context, 'Gagal mengubah profil', Colors.red);
    }
  }

  void _showAlert(BuildContext context, String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (message == 'Berhasil mengubah data') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Profil()),
                  );
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
                  child: ClipOval(
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
                      child: _imageFile != null
                          ? Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            )
                          : (_profilData != null &&
                                  _profilData!['image'] != null)
                              ? CachedNetworkImage(
                                  imageUrl:
                                      'http://172.16.104.49/flutter/foto_profil/${_profilData!['image']}',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) {
                                    debugPrint('Error loading image: $url');
                                    debugPrint('Error details: $error');
                                    return Icon(Icons.error);
                                  },
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/icon_profil.png',
                                  fit: BoxFit.cover,
                                ),
                    ),
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
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
                      controller: _controllers['nama'],
                    ),
                    SizedBox(height: 23),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'NIK',
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
                      controller: _controllers['nik'],
                    ),
                    SizedBox(height: 23),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Tanggal Lahir',
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        alignLabelWithHint: true, // Mengatur label rata tengah
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      textAlign: TextAlign.left, // Mengatur teks rata kiri
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _tanggalLahirController,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            // Format tanggal untuk menampilkan hanya tanggal tanpa waktu
                            String formattedDate =
                                '${picked.year}-${picked.month}-${picked.day}';
                            _tanggalLahirController.text =
                                formattedDate; // Update text field value
                          });
                        }
                      },
                    ),
                    SizedBox(height: 23),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Jenis Kelamin',
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        alignLabelWithHint: true, // Mengatur label rata tengah
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      value: _selectedJenisKelamin,
                      hint: Text(
                          'Pilih Jenis Kelamin'), // Label default jika belum dipilih
                      items: [
                        DropdownMenuItem(
                          value: 'Laki-laki',
                          child: Text(
                            'Laki-laki',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Perempuan',
                          child: Text(
                            'Perempuan',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          _selectedJenisKelamin = newValue;
                        });
                      },
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
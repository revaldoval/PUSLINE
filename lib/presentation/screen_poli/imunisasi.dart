import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/home_page_screen.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:tolong_s_application1/widgets/buttondaftarpasien.dart';
import '../home_page_screen/beranda.dart';
import '../home_page_screen/home_page_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tolong_s_application1/theme/ApiService.dart';
import '../models/user_model.dart';
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart'; // Import library untuk menggunakan Timer

class Imunisasi extends StatefulWidget {
  const Imunisasi({Key? key}) : super(key: key);

  @override
  State<Imunisasi> createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {
  String selectedPoli = 'POLI06';
  String _statuspendaftaran = 'Diproses';

  late TextEditingController _dateController;
  late TextEditingController _complaintController;
  TextEditingController logonikregisterpageController = TextEditingController();

  final List<DateTime> _holidays = [];

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _complaintController = TextEditingController();
  }

// Variabel untuk melacak nomor antrian saat ini
  String NoAntrian = ''; // Variabel untuk menyimpan nomor antrian

  bool isHoliday(DateTime date) {
    if (date.weekday == DateTime.sunday) {
      return true;
    }
    for (DateTime holiday in _holidays) {
      if (date.year == holiday.year &&
          date.month == holiday.month &&
          date.day == holiday.day) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('id'),
      ],
      // other MaterialApp properties...
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Imunisasi",
          style: CustomTextStyles.titleMediumMedium,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF49A18C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(Duration(milliseconds: 300));
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Tanggal Periksa",
                  hintStyle: CustomTextStyles.poppins13,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF15AFA7)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF15AFA7)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF15AFA7)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      // Intl.defaultLocale =
                      //     'id_ID'; // Atur lokal ke bahasa Indonesia

                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        // locale: const Locale('id', 'ID'),
                      );

                      if (pickedDate != null) {
                        if (isHoliday(pickedDate)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Tidak bisa memilih hari Minggu.',
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            _dateController.text =
                                DateFormat('yyyy-MM-dd', 'id_ID')
                                    .format(pickedDate);
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _complaintController,
                decoration: InputDecoration(
                  hintText: "Keluhan",
                  hintStyle: CustomTextStyles.poppins13,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF15AFA7)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF15AFA7)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF15AFA7)),
                  ),
                ),
              ),
              SizedBox(height: 350),
              ButtonDaftarPasien(
                text: 'Daftar Pasien',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: Container(
                          height: 200,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF49A18C),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Daftar Pasien',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Yakin Ingin Daftar Imunisasi?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            color: Color(0xFF49A18C)),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      child: Text(
                                        'Tidak',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_dateController.text.isEmpty) {
                                        // Tampilkan pesan kesalahan jika _dateController kosong
                                        alert(
                                          context,
                                          "Tanggal harus diisi.",
                                          "Gagal!",
                                          Icons.error,
                                          Colors.red,
                                        );
                                      } else if (_complaintController
                                          .text.isEmpty) {
                                        // Tampilkan pesan kesalahan jika _complaintController kosong
                                        alert(
                                          context,
                                          "Keluhan harus diisi.",
                                          "Gagal!",
                                          Icons.error,
                                          Colors.red,
                                        );
                                      } else {
                                        // Lanjutkan proses jika kedua controller tidak kosong
                                        datarpoliimunisasi(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF49A18C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 45, vertical: 15),
                                      child: Text(
                                        'Ya',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void datarpoliimunisasi(BuildContext context) async {
    UserModelBaru? user =
        Provider.of<UserProvider>(context, listen: false).userBaru;

    String nik = user!.nik;
    String id_poli = 'POLI06';
    String tanggal_pendaftaran = _dateController.text;
    String deskripsi_keluhan = _complaintController.text;
    String antrian = NoAntrian;
    String status_pendaftaran = 'Diproses';

    try {
      ApiService apiService = new ApiService();
      Map<String, dynamic> response = await apiService.daftarpoli(nik, id_poli,
          tanggal_pendaftaran, deskripsi_keluhan, status_pendaftaran, antrian);

      print('Response from server: $response');

      if (response['status'] == 'success') {
        print('Success registering');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(),
          ),
        );
        alert(
          context,
          "Berhasil mendaftar.",
          "Berhasil!",
          Icons.check,
          Colors.green,
        );
      } else {
        print('Registration failed: ${response['message']}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _complaintController.dispose();
    super.dispose();
  }
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

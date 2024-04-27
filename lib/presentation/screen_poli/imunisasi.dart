import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/home_page_screen.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
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

class Imunisasi extends StatefulWidget {
  const Imunisasi({Key? key}) : super(key: key);

  @override
  State<Imunisasi> createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {
  String selectedPoli = 'POLI01';
  String selectedantrian = 'POLI01';
  late String antrian;
  late TextEditingController _dateController;
  // late TextEditingController _timeController;
  late TextEditingController _complaintController;
  TextEditingController logonikregisterpageController = TextEditingController();
  // TextEditingController _NamaDokterController =
  //     TextEditingController(text: 'Dr. Michael Revaldo');

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    // _timeController = TextEditingController();
    _complaintController = TextEditingController();
    nomorantrian();
    // _NamaDokterController = TextEditingController(text: 'Dr. Michael Revaldo');
  }

  void nomorantrian() {
    antrian = generateAntrian().toString();
  }

  String generateAntrian() {
    List<int> antrianList = [];
    Random random = Random();

    // Generate nomor antrian
    for (int i = 1; i <= 10; i++) {
      antrianList.add(i);
    }

    // Ambil nomor antrian secara acak dari daftar antrianList
    int randomIndex = random.nextInt(antrianList.length);
    return antrianList[randomIndex].toString();
  }

  String _generateRandomFormat() {
    List<String> formats = [
      'A',
      'B',
      'C',
      'D'
    ]; // Ganti dengan format yang diinginkan
    Random random = Random();
    return formats[random.nextInt(formats.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Poli Imunisasi",
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
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text =
                              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        });
                      }
                    },
                  ),
                ),
              ),
              // SizedBox(height: 20),
              // TextFormField(
              //   controller: _timeController,
              //   readOnly: true,
              //   decoration: InputDecoration(
              //     hintText: "Jam Periksa",
              //     hintStyle: CustomTextStyles.poppins13,
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF15AFA7)),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF15AFA7)),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF15AFA7)),
              //     ),
              //     suffixIcon: IconButton(
              //       icon: Icon(Icons.access_time),
              //       onPressed: () async {
              //         final TimeOfDay? pickedTime = await showTimePicker(
              //           context: context,
              //           initialTime: TimeOfDay.now(),
              //         );
              //         if (pickedTime != null) {
              //           setState(() {
              //             _timeController.text =
              //                 "${pickedTime.hour}:${pickedTime.minute}";
              //           });
              //         }
              //       },
              //     ),
              //   ),
              // ),
              // SizedBox(height: 20),
              // TextFormField(
              //   // controller: _NamaDokterController,
              //   readOnly: true, // Membuat input tidak dapat diedit
              //   decoration: InputDecoration(
              //     hintText: "Dr. Michael Revaldo",
              //     hintStyle: CustomTextStyles.poppins13,
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF15AFA7)),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF15AFA7)),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF15AFA7)),
              //     ),
              //   ),
              // ),

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
              SizedBox(height: 220),
              ElevatedButton(
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
                                  color: Color(0xFF15AFA7),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Daftar Pasien Poli Imunisasi',
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
                                  'Yakin Ingin Daftar Poli Imunisasi?',
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
                                      //
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            color: Color(0xFF15AFA7)),
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
                                      // datarpoliimunisasi(context);
                                      datarpoliimunisasi(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF15AFA7),
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
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  minimumSize: Size(double.infinity, 80),
                  backgroundColor: Color(0xFF15AFA7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Daftar Pasien',
                  style:
                      CustomTextStyles.poppins13.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//NANDO
  void datarpoliimunisasi(BuildContext context) async {
    UserModelBaru? user =
        Provider.of<UserProvider>(context, listen: false).userBaru;

    // String nik = logonikregisterpageController.text;
    String id_poli = selectedPoli.toString();
    String tanggal_pendaftaran = _dateController.text;
    String deskripsi_keluhan = _complaintController.text;
    String antrian = selectedantrian.toString();

    // Validasi form, misalnya memastikan semua field terisi dengan benar

    try {
      ApiService apiService = new ApiService();
      Map<String, dynamic> response = await apiService.daftarpoli(
          user!.nik, id_poli, tanggal_pendaftaran, deskripsi_keluhan, antrian);

      print('Response from server: $response'); // Cetak respons ke konsol

      if (response['status'] == 'success') {
        print('sukses mengirim');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Beranda(),
          ),
        );
        // Tambahkan logika navigasi atau tindakan setelah login berhasil

        // Set the user data using the provider
      } else if (response['status'] == 'errorValid') {
      } else {
        print('Login failed: ${response['message']}');
      }
    } catch (e) {
      print('Error during login: $e');
      // Tambahkan logika penanganan jika terjadi error
    }
  }

// CODE KE 2 GONE ALVIAN
  // Future<void> showAlert(
  //     BuildContext context, String title, String content) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //       );
  //     },
  //   );

  //   await Future.delayed(Duration(seconds: 2));
  //   Navigator.of(context).pop();
  // }

  // Future<void> pendaftaranpoli() async {
  //   // UserModelBaru? user =
  //   //     Provider.of<UserProvider>(context, listen: false).userBaru;

  //   if (logonikregisterpageController.text.isEmpty ||
  //       selectedPoli.isEmpty ||
  //       _dateController.text.isEmpty ||
  //       _complaintController.text.isEmpty ||
  //       nomorantrian.toString().isEmpty) {
  //     showAlert(context, "Gagal", "Semua field harus diisi");
  //   } else {
  //     // if (!RegExp(r'^[0-9]{10,15}$')
  //     //     .hasMatch(iconnomorteleponregisterController.text)) {
  //     //   showAlert(context, "Gagal", "Format Nomor Telepon tidak valid");
  //     //   return;
  //     // }

  //     try {
  //       final String apiUrl = ApiService.url('pendaftaranpoli.php').toString();

  //       final response = await http.post(
  //         Uri.parse(apiUrl),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //         },
  //         body: jsonEncode({
  //           "nik": logonikregisterpageController.text,
  //           "id_poli": selectedPoli,
  //           "jenis_kelamin": _dateController.text,
  //           "tanggal_lahir": _complaintController.text,
  //           "antrian": nomorantrian.toString(),
  //         }),
  //       );

  //       if (response.statusCode == 200) {
  //         print("Reponse = " + response.body.toString());
  //         Future.delayed(Duration(seconds: 2), () {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => Beranda()),
  //           );
  //         });
  //       } else {
  //         final errorMessage =
  //             jsonDecode(response.body)['message'] ?? "Gagal mendaftarkan user";
  //         showAlert(context, "Gagal", errorMessage);
  //         print("error" + response.body.toString());
  //       }
  //     } catch (e) {
  //       showAlert(
  //           context, "Error", "Terjadi kesalahan. Silakan coba lagi nanti.");
  //     }
  //   }
  // }

  @override
  void dispose() {
    _dateController.dispose();
    // _timeController.dispose();
    _complaintController.dispose();

    super.dispose();
  }
}

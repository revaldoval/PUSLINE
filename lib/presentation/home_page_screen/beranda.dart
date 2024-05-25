import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import '../screen_poli/poliumum.dart';
import '../screen_poli/poligigi.dart';
import '../screen_poli/poligizi.dart';
import '../screen_poli/polikia.dart';
import '../screen_poli/polimtbs.dart';
import '../screen_poli/imunisasi.dart';
import '../login_page_screen/login_page_screen.dart';
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  DateTime today = DateTime.now();
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
          'http://puskesline.tifnganjuk.com/MobileApi/profil_read.php?nik=$nik'));

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

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  String _getGreeting(DateTime now) {
    var hour = now.hour;
    print("SEKARANG ADALAH JAM: " + hour.toString());
    if (hour < 10) {
      return "Selamat Pagi!";
    } else if (hour < 15) {
      return "Selamat Siang!";
    } else if (hour < 18) {
      return "Selamat Sore!";
    } else {
      return "Selamat Malam!";
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    UserModelBaru? user = context.watch<UserProvider>().userBaru;
    var now = DateTime.now();
    var greeting = _getGreeting(now);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('id'),
      ],
      theme: ThemeData(scaffoldBackgroundColor: Color(0XFF49A18C)),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 98,
                      width: double.infinity,
                      color: Color(0XFF49A18C),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 28),
                        Padding(
                          padding: const EdgeInsets.all(21),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: user != null && user.img_profil != null
                                      ? ClipOval(
                                          child: Image.network(
                                            'http://puskesline.tifnganjuk.com/MobileApi/images/foto_profil/${_user.img_profil}',
                                            width: 45,
                                            height: 45,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              print(
                                                  'Error loading image: $error');
                                              return Image.asset(
                                                'assets/images/null.jpg',
                                                width: 45,
                                                height: 45,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        )
                                      : ClipOval(
                                          child: Image.asset(
                                            'assets/images/null.jpeg',
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                SizedBox(width: 11),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    // '$greeting '
                                    'Selamat Datang! ' +
                                        (_user.nama.toString().length > 10
                                            ? _user.nama
                                                    .toString()
                                                    .substring(0, 10) +
                                                "..."
                                            : _user.nama.toString()),
                                    style: CustomTextStyles.poppin15,
                                  ),
                                ),
                              ]),
                              Container(
                                alignment: Alignment.topRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showPopUpLogout(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: SizedBox(height: 113),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TableCalendar(
                              rowHeight: 43,
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                              ),
                              availableGestures: AvailableGestures.all,
                              locale: 'id_ID',
                              selectedDayPredicate: (day) =>
                                  isSameDay(day, today),
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: today,
                              onDaySelected: _onDaySelected,
                              calendarStyle: CalendarStyle(
                                weekendTextStyle: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        SizedBox(
                          height: 250,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Category(
                                    imagePath: "assets/images/PoliUmumBG.png",
                                    title: "Poli Umum",
                                    onPressed: () {
                                      Get.to(() => PoliUmum(),
                                          transition: Transition.fadeIn);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => PoliUmum(),
                                      //   ),
                                      // );
                                    },
                                  ),
                                  Category(
                                    imagePath: "assets/images/GigiBG.png",
                                    title: "Poli Gigi",
                                    onPressed: () {
                                      Get.to(() => PoliGigi(),
                                          transition: Transition.fadeIn);
                                    },
                                  ),
                                  Category(
                                    imagePath: "assets/images/PoliUmumBG.png",
                                    title: "Poli KIA",
                                    onPressed: () {
                                      Get.to(() => PoliKIA(),
                                          transition: Transition.fadeIn);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Category(
                                    imagePath: "assets/images/GiziBG.png",
                                    title: "Poli Gizi",
                                    onPressed: () {
                                      Get.to(() => PoliGizi(),
                                          transition: Transition.fadeIn);
                                    },
                                  ),
                                  Category(
                                    imagePath: "assets/images/MtbsBG.png",
                                    title: "Poli MTBS",
                                    onPressed: () {
                                      Get.to(() => PoliMTBS(),
                                          transition: Transition.fadeIn);
                                    },
                                  ),
                                  Category(
                                    imagePath: "assets/images/ImunisasiBG.png",
                                    title: "Imunisasi",
                                    onPressed: () {
                                      Get.to(() => Imunisasi(),
                                          transition: Transition.fadeIn);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showPopUpLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 200,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
                  'Konfirmasi',
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Apakah Anda yakin ingin keluar?',
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Color(0xFF15AFA7)),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Text(
                        'Batal',
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
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPageScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF15AFA7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 15),
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
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onPressed;

  const Category({
    Key? key,
    required this.imagePath,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
            width: 120,
            height: 114,
            color: Color(0XFF45A28C).withOpacity(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, width: 80),
                Text(
                  title,
                  style: CustomTextStyles.poppin14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

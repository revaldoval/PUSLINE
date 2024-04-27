import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/artikel.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/beranda.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/notifikasi.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/profil.dart';
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    UserModelBaru? user = context.watch<UserProvider>().userBaru;
    final _listPage = <Widget>[
      Beranda(),
      Notifikasi(),
      Artikel(),
      Profil(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.notifications), label: 'Notifikasi'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.article), label: 'Artikel'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
    ];

    final _bottomNavBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0XFFE8E8E8),
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      unselectedItemColor: Color(0XFF959595),
      selectedItemColor: Color(0XFF45A28C),
      onTap: _onNavBarTapped,
    );

    return Scaffold(
      body: Center(
        child: _listPage[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}

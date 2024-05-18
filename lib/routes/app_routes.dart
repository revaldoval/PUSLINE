import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/notifikasi_2/detail_notifikasi.dart';
import 'package:tolong_s_application1/presentation/screen_poli/poliumum.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/register_page_screen/register_page_screen.dart';
import '../presentation/welcome_page_screen/welcome_page_screen.dart';
import '../presentation/login_page_screen/login_page_screen.dart';
import '../presentation/lupa_password_nomor_telepon_screen/lupa_password_nomor_telepon_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/screen_poli/poliumum.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String registerPageScreen = '/register_page_screen';

  static const String welcomePageScreen = '/welcome_page_screen';

  static const String loginPageScreen = '/login_page_screen';

  static const String lupaPasswordNomorTeleponScreen =
      '/lupa_password_nomor_telepon_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String poliUmum = '/poliumum';
    static const String detailNotifikasi = '/detail_notifikasi';
  
  

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    registerPageScreen: (context) => RegisterPageScreen(),
    welcomePageScreen: (context) => WelcomePageScreen(),
    loginPageScreen: (context) => LoginPageScreen(),
    lupaPasswordNomorTeleponScreen: (context) =>
        LupaPasswordNomorTeleponScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    poliUmum: (context) => PoliUmum(),
    // detailNotifikasi: (context) => DetailNotifikasi(),
  };
}

import 'dart:convert';

import 'package:tolong_s_application1/presentation/home_page_screen/home_page_screen.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class LoginPageScreen extends StatefulWidget {
  LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  TextEditingController logonikloginpageController = TextEditingController();

  TextEditingController logokatasandiloginpageController =
      TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final String nik = logonikloginpageController.text;
    final String kata_sandi = logokatasandiloginpageController.text;


    final url =
        'http://172.16.110.31/projek/connect.php'; // Ganti dengan URL login.php Anda

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'nik': nik,
          'kata_sandi': kata_sandi,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          // Login berhasil, lakukan navigasi ke halaman berikutnya
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePageScreen()));
        } else {
          // Login gagal, tampilkan pesan kesalahan
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Gagal'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        throw Exception('Gagal melakukan request ke server');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  _buildSelamatDatang(context),
                  SizedBox(height: 6.v),
                  Container(
                      width: 264.h,
                      margin: EdgeInsets.symmetric(horizontal: 48.h),
                      decoration: AppDecoration.outlineBlack90035,
                      child: Text("Masuk dengan NIK dan Kata Sandi",
                          maxLines: null,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleSmallSemiBold)),
                  SizedBox(height: 20.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 88.h),
                          child:
                              Text("NIK", style: theme.textTheme.titleSmall))),
                  Padding(
                      padding: EdgeInsets.only(left: 45.h, right: 44.h),
                      child: CustomTextFormField(
                          controller: logonikloginpageController,
                          prefix: Container(
                              margin: EdgeInsets.fromLTRB(17.h, 9.v, 30.h, 9.v),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgLogonikloginpage,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize)),
                          prefixConstraints: BoxConstraints(maxHeight: 42.v),
                          borderDecoration:
                              TextFormFieldStyleHelper.outlineOnPrimaryTL21)),
                  SizedBox(height: 16.v),
                  _buildSignUp(context),
                  SizedBox(height: 5.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            onTapTxtLupaKataSandi(context);
                          },
                          child: Container(
                              width: 116.h,
                              margin: EdgeInsets.only(left: 86.h),
                              decoration: AppDecoration.outlineBlack90035,
                              child: Text("Lupa Kata Sandi?",
                                  maxLines: null,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelLarge)))),
                  SizedBox(height: 12.v),
                  CustomElevatedButton(
                    text: "MASUK",
                    margin: EdgeInsets.only(left: 45.h, right: 44.h),
                    onPressed: () {
                      _login();
                    },
                  ),
                  SizedBox(height: 18.v),
                  GestureDetector(
                      onTap: () {
                        onTapTxtBelumpunyaakun(context);
                      },
                      child: Container(
                          width: 255.h,
                          margin: EdgeInsets.only(left: 52.h, right: 53.h),
                          decoration: AppDecoration.outlineBlack90035,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Belum Punya Akun ?  ",
                                    style: CustomTextStyles.titleSmallffffffff),
                                TextSpan(
                                    text: "Daftar Akun",
                                    style: CustomTextStyles.titleSmallffefaf00)
                              ]),
                              textAlign: TextAlign.left))),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  Widget _buildSelamatDatang(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 96.h, vertical: 14.v),
        decoration: AppDecoration.fillLightGreen
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL46),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 25.v),
          Text("Selamat Datang!", style: theme.textTheme.titleMedium),
          SizedBox(height: 9.v),
          CustomImageView(
              imagePath: ImageConstant.imgImage1478,
              height: 198.v,
              width: 164.h)
        ]));
  }

  /// Section Widget
  Widget _buildSignUp(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 44.h),
        decoration: AppDecoration.outlineBlack,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(left: 43.h),
              child: Text("Kata Sandi", style: theme.textTheme.titleSmall)),
          SizedBox(height: 1.v),
          CustomTextFormField(
              controller: logokatasandiloginpageController,
              textInputAction: TextInputAction.done,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(17.h, 9.v, 30.h, 9.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgLogokatasandiloginpage,
                      height: 24.adaptSize,
                      width: 24.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 42.v),
              obscureText: true,
              borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL21)
        ]));
  }

  /// Navigates to the lupaPasswordNomorTeleponScreen when the action is triggered.
  onTapTxtLupaKataSandi(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.lupaPasswordNomorTeleponScreen);
  }

  /// Navigates to the registerPageScreen when the action is triggered.
  onTapTxtBelumpunyaakun(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerPageScreen);
  }
}

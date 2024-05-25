import 'dart:convert';

import 'package:tolong_s_application1/presentation/home_page_screen/beranda.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/home_page_screen.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:tolong_s_application1/theme/ApiService.dart';
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';

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
  final ApiService apiService = ApiService();

  void _login(BuildContext context) async {
    String nik = logonikloginpageController.text;
    String kata_sandi = logokatasandiloginpageController.text;

    // Validasi form, misalnya memastikan semua field terisi dengan benar

    try {
      Map<String, dynamic> response = await apiService.login(nik, kata_sandi);

      print('Response from server: $response'); // Cetak respons ke konsol

      if (response['status'] == 'success') {
        print('Login successful');
        // Tambahkan logika navigasi atau tindakan setelah login berhasil

        // Set the user data using the provider
        context.read<UserProvider>().setUserBaru(
              UserModelBaru(
                nik: response['nik'] ?? '',
                nama: response['nama'] ?? '',
                tanggal_lahir: response['tanggal_lahir'] ?? '',
                jenis_kelamin: response['jenis_kelamin'] ?? '',
                email: response['email'] ?? '',
                no_telepon: response['no_telepon'] ?? '',
                img_profil: response['img_profil'] ?? '',
                kode_otp: response['kode_otp'] ?? '',
                created_at: response['created_at'] ?? '',
                updated_at: response['updated_at'] ??
                    '', // Pastikan urutan parameter sesuai
              ),
            );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(),
          ),
        );
      } else if (response['status'] == 'errorValid') {
        alert(context, "NIK atau sandi tidak valid");
      } else {
        print('Login failed: ${response['message']}');

        alert(context, "terjadi kesalahan pada jaringan");
      }
    } catch (e) {
      print('Error during login: $e');
      // Tambahkan logika penanganan jika terjadi error
    }
  }

  void alert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context, message),
        );
      },
    );
  }

  Widget contentBox(BuildContext context, String message) {
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
                'Gagal Masuk!',
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
            backgroundColor: Colors.redAccent,
            radius: 30,
            child: Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                              child: Text("NIK",
                                  style: theme.textTheme.titleSmall))),
                      Padding(
                          padding: EdgeInsets.only(left: 45.h, right: 44.h),
                          child: CustomTextFormField(
                              textStyle: TextStyle(color: Colors.white),
                              // allowOnlyNumbers: true,
                              controller: logonikloginpageController,
                              prefix: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(17.h, 9.v, 30.h, 9.v),
                                  child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgLogonikloginpage,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize)),
                              allowOnlyNumbers: true,
                              prefixConstraints:
                                  BoxConstraints(maxHeight: 42.v),
                              borderDecoration: TextFormFieldStyleHelper
                                  .outlineOnPrimaryTL21)),
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
                            if (logonikloginpageController.text.isEmpty ||
                                logokatasandiloginpageController.text.isEmpty) {
                              alert(context, "Isi semua data terlebih dahulu");
                            } else if (logonikloginpageController.text.length !=
                                16) {
                              alert(context,
                                  "NIK harus terdiri dari 16 karakter");
                            } else {
                              _login(context);
                            }
                          }

                          // onPressed: () {
                          //   _login(context);
                          // },
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
                                        style: CustomTextStyles
                                            .titleSmallffffffff),
                                    TextSpan(
                                        text: "Daftar Akun",
                                        style:
                                            CustomTextStyles.titleSmallffefaf00)
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
  bool isObscureKatasandi = true;
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
            textStyle: TextStyle(color: Colors.white),
            controller: logokatasandiloginpageController,
            textInputAction: TextInputAction.done,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(17.h, 9.v, 30.h, 9.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgLogokatasandiloginpage,
                    height: 24.adaptSize,
                    width: 24.adaptSize)),
            suffix: IconButton(
              icon: Icon(
                  isObscureKatasandi ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isObscureKatasandi = !isObscureKatasandi;
                });
              },
              color: Colors.white,
            ),
            obscureText: isObscureKatasandi,
            prefixConstraints: BoxConstraints(maxHeight: 36.v),
            // prefixConstraints: BoxConstraints(maxHeight: 42.v),
            // obscureText: true,
            borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL21)
      ]),
    );
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

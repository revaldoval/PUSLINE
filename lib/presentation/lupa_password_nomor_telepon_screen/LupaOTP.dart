import 'dart:convert';
import 'package:tolong_s_application1/presentation/home_page_screen/beranda.dart';
import 'package:tolong_s_application1/presentation/home_page_screen/home_page_screen.dart';
import 'package:tolong_s_application1/presentation/login_page_screen/login_page_screen.dart';
import 'package:tolong_s_application1/presentation/lupa_password_nomor_telepon_screen/sandi_baru.dart';
import 'package:tolong_s_application1/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:tolong_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:tolong_s_application1/theme/ApiService.dart';
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';
import '../login_page_screen/login_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';

// ignore_for_file: must_be_immutable
class LupaOtp extends StatefulWidget {
  final String email;

  const LupaOtp({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<LupaOtp> createState() => _LupaOtpState();
}

class _LupaOtpState extends State<LupaOtp> {
  TextEditingController otpController = TextEditingController();
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  EmailOTP myauth = EmailOTP();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildMasukkanKodeOtp(context),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child:
                          Text("Kode Otp", style: theme.textTheme.titleSmall),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: List.generate(6, (index) {
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: TextFormField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onChanged: (String value) {
                                if (value.isNotEmpty) {
                                  if (index < 5) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index + 1]);
                                  } else {
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                                otpController.text = controllers
                                    .map((controller) => controller.text)
                                    .join();
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                        height:
                            10), // Tambahkan jarak antara kolom pertama dan kedua
                    // Pindahkan Align ke atas CustomElevatedButton
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () async {
                          myauth.setConfig(
                              appEmail: "chaoscode814@gmail.com",
                              appName: "PUSLINE",
                              userEmail: widget.email,
                              otpLength: 6,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP telah terkirim"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Ups, pengiriman OTP gagal"),
                            ));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                              .transparent), // Membuat warna latar belakang tombol menjadi transparan
                          elevation: MaterialStateProperty.all<double>(
                              0), // Menghilangkan efek naik tombol saat ditekan
                        ),
                        child: Container(
                          // width: 255,
                          // margin: EdgeInsets.only(left: 5, right: 150),
                          // decoration: AppDecoration.outlineBlack90035,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Kirim Kode OTP",
                                  style: CustomTextStyles.titleSmallffefaf00,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 30), // Tambahkan jarak antara teks dan tombol
                    CustomElevatedButton(
                      onPressed: () async {
                        if (await myauth.verifyOTP(otp: otpController.text) ==
                            true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("OTP berhasil diverifikasi"),
                          ));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SandiBaru(email: widget.email),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("OTP Tidak Valid"),
                          ));
                        }
                      },
                      text: "VERIFIKASI",
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

  /// Section Widget
  Widget _buildMasukkanKodeOtp(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 38.v),
        decoration: AppDecoration.outlineBlack900351
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL46),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomAppBar(
              leadingWidth: double.maxFinite,
              leading: AppbarLeadingIconbutton(
                  imagePath: ImageConstant.imgButtonKembaliReset,
                  margin: EdgeInsets.only(left: 12.h, right: 327.h),
                  onTap: () {
                    Navigator.pop(context);
                  })),
          SizedBox(height: 19.v),
          Container(
              alignment: Alignment.center,
              width: 277.h,
              margin: EdgeInsets.symmetric(horizontal: 55.h),
              decoration: AppDecoration.outlineBlack90035,
              child: Text("Masukkan Kode OTP",
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium)),
          SizedBox(height: 36.v),
          CustomImageView(
              imagePath: ImageConstant.imgImage4, height: 177.v, width: 175.h),
          SizedBox(height: 9.v)
        ]));
  }

  /// Navigates to the loginPageScreen when the action is triggered.
  onTapBUTTONKEMBALIRESET(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.lupaPasswordNomorTeleponScreen);
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
}

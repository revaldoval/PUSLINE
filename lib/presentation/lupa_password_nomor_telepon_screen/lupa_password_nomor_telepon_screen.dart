import 'package:tolong_s_application1/presentation/lupa_password_nomor_telepon_screen/LupaOTP.dart';
import 'package:tolong_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:tolong_s_application1/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
import 'package:email_otp/email_otp.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';

// ignore_for_file: must_be_immutable
class LupaPasswordNomorTeleponScreen extends StatelessWidget {
  LupaPasswordNomorTeleponScreen({Key? key}) : super(key: key);

  TextEditingController iconEmailResetController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  _buildMasukkanEmail(context),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 44.h, vertical: 55.v),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 43.h),
                                child: Text("Email",
                                    style: theme.textTheme.titleSmall)),
                            SizedBox(height: 1.v),
                            CustomTextFormField(
                                textStyle: TextStyle(color: Colors.white),
                                controller: iconEmailResetController,
                                textInputAction: TextInputAction.done,
                                prefix: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        17.h, 9.v, 30.h, 9.v),
                                    child: CustomImageView(
                                        imagePath: ImageConstant.imgIconEmail,
                                        height: 16.adaptSize,
                                        width: 24.adaptSize)),
                                prefixConstraints:
                                    BoxConstraints(maxHeight: 42.v),
                                borderDecoration: TextFormFieldStyleHelper
                                    .outlineOnPrimaryTL21),
                            SizedBox(height: 54.v),
                            CustomElevatedButton(
                                text: "KIRIM",
                                // margin: EdgeInsets.only(left: 45.h, right: 44.h, bottom: 53.v),
                                onPressed: () async {
                                  if (iconEmailResetController.text.isEmpty) {
                                    alert(context, "Isi Email terlebih dahulu",
                                        "Gagal!", Icons.error, Colors.red);
                                  } else if (!_isValidEmail(
                                      iconEmailResetController.text)) {
                                    alert(context, "Format Email tidak valid",
                                        "Gagal!", Icons.error, Colors.red);
                                  } else {
                                    try {
                                      Map<String, dynamic> responseData =
                                          await apiService.beforenext(
                                              iconEmailResetController.text);
                                      if (responseData['status'] == 'success') {
                                        // Email is found, display error message
                                        alert(context, responseData['message'],
                                            "Gagal!", Icons.error, Colors.red);
                                      } else {
                                        // Email is not found, proceed to OTP page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LupaOtp(
                                              email:
                                                  iconEmailResetController.text,
                                            ),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      // Handle errors
                                      print("Error: $e");
                                      alert(
                                          context,
                                          "Terjadi kesalahan saat memeriksa email",
                                          "Gagal!",
                                          Icons.error,
                                          Colors.red);
                                    }
                                  }
                                }
                                ),
                            SizedBox(height: 5.v)
                          ]))
                ]))));
  }

  bool _isValidEmail(String email) {
    // Menggunakan regular expression untuk memeriksa format email
    // Ini adalah contoh regular expression yang sederhana, Anda dapat menyesuaikan sesuai kebutuhan Anda
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
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

  /// Section Widget
  Widget _buildMasukkanEmail(BuildContext context) {
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
                    onTapBUTTONKEMBALIRESET(context);
                  })),
          SizedBox(height: 19.v),
          Container(
              alignment: Alignment.center,
              width: 277.h,
              margin: EdgeInsets.symmetric(horizontal: 55.h),
              decoration: AppDecoration.outlineBlack90035,
              child: Text("Masukkan Email",
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
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }
}

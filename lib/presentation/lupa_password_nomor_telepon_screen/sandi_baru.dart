import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
import 'package:tolong_s_application1/presentation/login_page_screen/login_page_screen.dart';
import 'package:tolong_s_application1/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:tolong_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';

class SandiBaru extends StatefulWidget {
  final String email;
  const SandiBaru({Key? key, required this.email}) : super(key: key);

  @override
  State<SandiBaru> createState() => _SandiBaruState();
}

class _SandiBaruState extends State<SandiBaru> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ApiService apiService = ApiService();

  @override
  bool isObscureKatasandi = true;
  bool isObscureKonfirmKatasandi = true;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildBuatSandiBaru(context),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Kata Sandi Baru",
                          style: theme.textTheme.titleSmall),
                    ),
                    SizedBox(height: 1),
                    CustomTextFormField(
                      textStyle: TextStyle(color: Colors.white),
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(17, 9, 30, 9),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconkatasandiregisterpag,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      suffix: IconButton(
                        icon: Icon(isObscureKatasandi
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isObscureKatasandi = !isObscureKatasandi;
                          });
                        },
                        color: Colors.white,
                      ),
                      obscureText: isObscureKatasandi,
                      prefixConstraints: BoxConstraints(maxHeight: 42),
                      borderDecoration:
                          TextFormFieldStyleHelper.outlineOnPrimaryTL21,
                    ),
                    SizedBox(
                        height:
                            16), // Tambahkan jarak antara kolom pertama dan kedua
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Konfirmasi Kata Sandi Baru",
                          style: theme.textTheme.titleSmall),
                    ),
                    SizedBox(height: 1),
                    CustomTextFormField(
                      textStyle: TextStyle(color: Colors.white),
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(17, 9, 30, 9),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconkatasandiregisterpag,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      suffix: IconButton(
                        icon: Icon(isObscureKonfirmKatasandi
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isObscureKonfirmKatasandi =
                                !isObscureKonfirmKatasandi;
                          });
                        },
                        color: Colors.white,
                      ),
                      obscureText: isObscureKonfirmKatasandi,
                      prefixConstraints: BoxConstraints(maxHeight: 42),
                      borderDecoration:
                          TextFormFieldStyleHelper.outlineOnPrimaryTL21,
                    ),
                    SizedBox(height: 54),
                    CustomElevatedButton(
                      onPressed: () async {
                        // Regex untuk memeriksa minimal satu huruf besar dan satu angka
                        RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*\d).+$');

                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          alert(
                              context,
                              "Kata sandi dan konfirmasi sandi tidak sesuai!",
                              "Gagal!",
                              Icons.error,
                              Colors.red);
                        } else if (_passwordController.text.length < 8 ||
                            _confirmPasswordController.text.length < 8 ||
                            !regex.hasMatch(_passwordController.text) ||
                            !regex.hasMatch(_confirmPasswordController.text)) {
                          alert(
                              context,
                              "Kata sandi minimal 8 karakter dengan setidaknya 1 huruf besar dan 1 angka diperlukan.",
                              "Gagal!",
                              Icons.error,
                              Colors.red);
                        } else {
                          try {
                            Map<String, dynamic> result = await ApiService()
                                .updateSandi(widget.email,
                                    _confirmPasswordController.text);

                            // Lakukan penanganan hasil jika diperlukan
                            print('Update successful: $result');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPageScreen(),
                              ),
                            );
                            alert(context, "Berhasil Mengubah Kata Sandi.",
                                "Berhasil!", Icons.done, Colors.green);
                            // Tambahkan navigasi atau tindakan lain setelah berhasil diunggah
                          } catch (e) {
                            print('Error$e');
                            // Tambahkan penanganan kesalahan jika diperlukan
                          }
                        }
                      },
                      text: "SIMPAN",
                    ),
                    SizedBox(height: 5),
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
  Widget _buildBuatSandiBaru(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 38.v),
        decoration: AppDecoration.outlineBlack900351
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL46),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // CustomAppBar(
          //     leadingWidth: double.maxFinite,
          //     leading: AppbarLeadingIconbutton(
          //         imagePath: ImageConstant.imgButtonKembaliReset,
          //         margin: EdgeInsets.only(left: 12.h, right: 327.h),
          //         onTap: () {
          //           onTapBUTTONKEMBALIRESET(context);
          //         })
          //         ),
          SizedBox(height: 19.v),
          Container(
              alignment: Alignment.center,
              width: 277.h,
              margin: EdgeInsets.symmetric(horizontal: 55.h),
              decoration: AppDecoration.outlineBlack90035,
              child: Text("Buat Kata Sandi Baru",
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
    // Navigator.pushNamed(context, AppRoutes.Otp);
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

  void succesalert(BuildContext context, String message, String title,
      IconData icon, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: succescontentBox(context, message, title, icon, color),
        );
      },
    );
  }

  Widget succescontentBox(BuildContext context, String message, String title,
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPageScreen(),
                      ),
                    );
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

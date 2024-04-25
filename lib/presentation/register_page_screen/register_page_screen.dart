import 'package:tolong_s_application1/presentation/login_page_screen/login_page_screen.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tolong_s_application1/theme/ApiService.dart';

// ignore_for_file: must_be_immutable
class RegisterPageScreen extends StatefulWidget {
  RegisterPageScreen({Key? key}) : super(key: key);

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  TextEditingController logonikregisterpageController = TextEditingController();

  TextEditingController logonamaregisterpagController = TextEditingController();

  TextEditingController _jenisKelaminController = TextEditingController();

  TextEditingController _TanggalLahirController = TextEditingController();

  TextEditingController iconnomorteleponregisterController =
      TextEditingController();

  TextEditingController iconkatasandiregisterpagController =
      TextEditingController();

  bool isObscure = true;
  FocusNode _nikFocus = FocusNode();
  FocusNode _namaFocus = FocusNode();
  FocusNode _jeniskelaminFocus = FocusNode();
  FocusNode _tanggallahirFocus = FocusNode();
  FocusNode _noteleponFocus = FocusNode();
  FocusNode _katasandiFocus = FocusNode();

  RegExp noteleponValidator = RegExp(
    r'^[0-9]{10,15}$',
  );

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _nikFocus.dispose();
    _namaFocus.dispose();
    _jeniskelaminFocus.dispose();
    _tanggallahirFocus.dispose();
    _noteleponFocus.dispose();
    _katasandiFocus.dispose();
    super.dispose();
  }

  Future<void> showAlert(
      BuildContext context, String title, String content) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );

    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pop();
  }

  Future<void> registerUser() async {
    if (logonikregisterpageController.text.isEmpty ||
        logonamaregisterpagController.text.isEmpty ||
        _jenisKelaminController.text.isEmpty ||
        selectedDate.toString().isEmpty ||
        iconnomorteleponregisterController.text.isEmpty ||
        iconkatasandiregisterpagController.text.isEmpty) {
      showAlert(context, "Gagal", "Semua field harus diisi");
    } else {
      // if (!RegExp(r'^[0-9]{10,15}$')
      //     .hasMatch(iconnomorteleponregisterController.text)) {
      //   showAlert(context, "Gagal", "Format Nomor Telepon tidak valid");
      //   return;
      // }

      try {
      final String apiUrl = ApiService.url('register.php').toString();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "nik": logonikregisterpageController.text,
          "nama": logonamaregisterpagController.text,
          "jenis_kelamin": _jenisKelaminController.text,
          "tanggal_lahir": selectedDate.toString(),
          "no_telepon": iconnomorteleponregisterController.text,
          "kata_sandi": iconkatasandiregisterpagController.text,
        }),
      );

      if (response.statusCode == 200) {
        print("Reponse = " + response.body.toString());
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPageScreen()),
          );
        });
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? "Gagal mendaftarkan user";
        showAlert(context, "Gagal", errorMessage);
        print("error" + response.body.toString());
      }
      } catch (e) {

        showAlert(
            context, "Error", "Terjadi kesalahan. Silakan coba lagi nanti.");
      }
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 5.v),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildSilahkanMendaftar(context),
                              SizedBox(height: 22.v),
                              Container(
                                  width: 315.h,
                                  margin:
                                      EdgeInsets.only(left: 32.h, right: 13.h),
                                  decoration: AppDecoration.outlineBlack90035,
                                  child: Text(
                                      "Silahkan mendaftarkan data diri anda\n                         di bawah ini",
                                      maxLines: null,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          CustomTextStyles.titleMediumMedium)),
                              SizedBox(height: 7.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 96.h),
                                      child: Text("NIK",
                                          style: theme.textTheme.titleSmall))),
                              _buildLogonikregisterpage(context),
                              SizedBox(height: 8.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 96.h),
                                      child: Text("Nama Lengkap",
                                          style: theme.textTheme.titleSmall))),
                              _buildLogonamaregisterpag(context),
                              SizedBox(height: 6.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 96.h),
                                      child: Text("Jenis Kelamin",
                                          style: theme.textTheme.titleSmall))),
                              _buildDropdownJenisKelamin(
                                  context, _jenisKelaminController),
                              SizedBox(height: 8.v),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 96.h),
                                  child: Text(
                                    "Tanggal Lahir",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  height: 72.v,
                                  width: 277.h,
                                  margin: EdgeInsets.only(right: 32.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 17.h, vertical: 2.v),
                                  decoration:
                                      AppDecoration.outlineOnPrimary.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder18,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant
                                            .imgIcontanggallahirRegisterpag,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                        alignment: Alignment.centerLeft,
                                      ),
                                      SizedBox(
                                          width:
                                              30.h), // Tambahkan jarak di sini
                                      Expanded(
                                        child: TextField(
                                          controller: _TanggalLahirController,
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0,
                                                  0), // Warna teks hitam
                                              fontWeight: FontWeight.normal,
                                              fontSize: 13),
                                          textAlign: TextAlign.left,
                                          readOnly: true,
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                            hintStyle: TextStyle(
                                              color: Colors
                                                  .black, // Warna teks hitam
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 96.h),
                                      child: Text("Nomor Telepon",
                                          style: theme.textTheme.titleSmall))),
                              _buildIconnomorteleponregister(context),
                              SizedBox(height: 6.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 96.h),
                                      child: Text("Kata Sandi",
                                          style: theme.textTheme.titleSmall))),
                              _buildIconkatasandiregisterpag(context),
                              SizedBox(height: 18.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                      onTap: () {
                                        navigateTo(context);
                                      },
                                      child: Container(
                                          width: 255.h,
                                          margin: EdgeInsets.only(
                                              left: 54.h, right: 51.h),
                                          decoration:
                                              AppDecoration.outlineBlack90035,
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Sudah Punya Akun? ",
                                                    style: CustomTextStyles
                                                        .titleSmallffffffff),
                                                TextSpan(
                                                    text: "Masuk Akun",
                                                    style: CustomTextStyles
                                                        .titleSmallffefaf00)
                                              ]),
                                              textAlign: TextAlign.left))))
                            ])))),
            bottomNavigationBar: _buildDaftar(context)));
  }

  /// Section Widget
  Widget _buildSilahkanMendaftar(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 39.h, vertical: 11.v),
        decoration: AppDecoration.fillLightGreen
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL46),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 28.v),
          Container(
              decoration: AppDecoration.outlineBlack90035,
              child: Text("Silahkan Mendaftar Di Bawah Ini",
                  style: CustomTextStyles.titleMedium18)),
          SizedBox(height: 16.v),
          CustomImageView(
              imagePath: ImageConstant.imgImage1481,
              height: 195.v,
              width: 270.h)
        ]));
  }

  /// Section Widget
  Widget _buildLogonikregisterpage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 51.h, right: 32.h),
        child: CustomTextFormField(
            controller: logonikregisterpageController,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 8.v, 30.h, 7.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgLogonikregisterpage,
                    height: 21.v,
                    width: 25.h)),
            prefixConstraints: BoxConstraints(maxHeight: 36.v)));
  }

  /// Section Widget
  Widget _buildLogonamaregisterpag(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 51.h, right: 32.h),
        child: CustomTextFormField(
            controller: logonamaregisterpagController,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(21.h, 6.v, 30.h, 6.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgLogonamaregisterpag,
                    height: 24.adaptSize,
                    width: 24.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 36.v)));
  }

  Widget _buildDropdownJenisKelamin(
      BuildContext context, TextEditingController controller) {
    String dropdownValue = controller.text.isNotEmpty
        ? controller.text
        : 'laki-laki'; // Default value, you can change it if needed

    return Container(
      margin: EdgeInsets.only(left: 51.h, right: 32.h),
      padding: EdgeInsets.symmetric(horizontal: 17.h, vertical: 6.v),
      alignment: Alignment.centerLeft,
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder18,
      ),
      child: DropdownButton<String>(
        alignment: Alignment.centerLeft,
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          // Update state when the dropdown value changes
          setState(() {
            dropdownValue = newValue!;
            controller.text = newValue; // Update controller value
          });
        },
        items: <String>['laki-laki', 'perempuan']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Align items center left
              children: [
                CustomImageView(
                  // You can replace this with your actual image paths
                  imagePath: value == 'laki-laki'
                      ? ImageConstant.imgIconjeniskelaminRegisterpag
                      : ImageConstant.imgIconjeniskelaminRegisterpag,
                  height: value == 'laki-laki' ? 25.v : 26.adaptSize,
                  width: value == 'laki-laki' ? 22.h : 26.adaptSize,

                  margin: EdgeInsets.only(
                    left: value == 'laki-laki' ? 1.h : 0,
                    top: value == 'laki-laki' ? 1.v : 0,
                  ),
                ),
                SizedBox(width: 10), // Adjust as needed
                Text(value),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Section Widget
  Widget _buildIconnomorteleponregister(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 51.h, right: 32.h),
        child: CustomTextFormField(
            controller: iconnomorteleponregisterController,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(21.h, 6.v, 30.h, 6.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgIconnomorteleponregister,
                    height: 24.adaptSize,
                    width: 24.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 36.v)));
  }

  /// Section Widget
  Widget _buildIconkatasandiregisterpag(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 51.h, right: 32.h),
        child: CustomTextFormField(
            controller: iconkatasandiregisterpagController,
            textInputAction: TextInputAction.done,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(19.h, 6.v, 30.h, 6.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgIconkatasandiregisterpag,
                    height: 24.adaptSize,
                    width: 24.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 36.v)));
  }

  /// Section Widget
  Widget _buildDaftar(BuildContext context) {
    return CustomElevatedButton(
        text: "Daftar",
        margin: EdgeInsets.only(left: 45.h, right: 44.h, bottom: 53.v),
        onPressed: () {
          registerUser();
        });
  }

  /// Navigates to the loginPageScreen when the action is triggered.
  navigateTo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }

  /// Navigates to the loginPageScreen when the action is triggered.
  onTapDaftar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }
}

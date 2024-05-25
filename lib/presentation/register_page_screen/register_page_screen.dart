import 'package:tolong_s_application1/presentation/login_page_screen/login_page_screen.dart';
import 'package:tolong_s_application1/presentation/register_page_screen/RegisterOtp1.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
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

  TextEditingController iconnemailregisterController = TextEditingController();

  TextEditingController iconnomorteleponregisterController =
      TextEditingController();

  TextEditingController iconkatasandiregisterpagController =
      TextEditingController();
  TextEditingController iconkonfirmkatasandiregisterpagController =
      TextEditingController();

  final ApiService apiService = ApiService();

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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  margin:
                                      EdgeInsets.only(right: 32.h, left: 70),
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
                                                  .white, // Warna teks hitam
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
                                      child: Text("Email",
                                          style: theme.textTheme.titleSmall))),
                              _buildEmailregister(context),
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
                              SizedBox(height: 6.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 96.h),
                                      child: Text("Konfirmasi Kata Sandi",
                                          style: theme.textTheme.titleSmall))),
                              _buildIconkonfirmkatasandiregisterpag(context),
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
              child: Text(
                "Silahkan Mendaftar\n Di Bawah Ini",
                style: CustomTextStyles.titleMedium18,
                textAlign: TextAlign.center,
              )),
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
            textStyle: TextStyle(color: Colors.white),
            controller: logonikregisterpageController,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 8.v, 30.h, 7.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgLogonikregisterpage,
                    height: 21.v,
                    width: 25.h)),
            allowOnlyNumbers: true,
            prefixConstraints: BoxConstraints(maxHeight: 36.v)));
  }

  /// Section Widget
  Widget _buildLogonamaregisterpag(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 51.h, right: 32.h),
        child: CustomTextFormField(
          textStyle: TextStyle(color: Colors.white),
          controller: logonamaregisterpagController,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(21.h, 6.v, 30.h, 6.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLogonamaregisterpag,
                  height: 24.adaptSize,
                  width: 24.adaptSize)),
          prefixConstraints: BoxConstraints(maxHeight: 36.v),
          allowOnlyLetters: true,
        ));
  }

  Widget _buildDropdownJenisKelamin(
      BuildContext context, TextEditingController controller) {
    String? dropdownValue = controller.text.isNotEmpty ? controller.text : null;

    return Container(
      margin: EdgeInsets.only(left: 51.h, right: 32.h),
      padding: EdgeInsets.symmetric(horizontal: 17.h, vertical: 6.v),
      alignment: Alignment.centerLeft,
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder18,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          alignment: Alignment.centerLeft,
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 30,
          elevation: 16,
          dropdownColor:
              Color(0xFF49A18C), // Set dropdown background color to black
          style: TextStyle(
            color: dropdownValue != null
                ? Colors.white
                : Colors.white, // Adjusting the hint text color
          ),
          onChanged: (String? newValue) {
            // Update state when the dropdown value changes
            setState(() {
              dropdownValue = newValue;
              controller.text = newValue ?? ''; // Update controller value
            });
          },
          items: <String?>[
            null,
            'Laki-Laki',
            'Perempuan'
          ] // Adding null as the first item for the hint text
              .map<DropdownMenuItem<String>>((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: value != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Align items center left
                      children: [
                        CustomImageView(
                          // You can replace this with your actual image paths
                          imagePath: value == 'Laki-Laki'
                              ? ImageConstant.imgIconjeniskelaminRegisterpag
                              : ImageConstant.imgIconjeniskelaminRegisterpag,
                          height: value == 'Laki-Laki' ? 25.v : 26.adaptSize,
                          width: value == 'Laki-Laki' ? 22.h : 26.adaptSize,
                          margin: EdgeInsets.only(
                            left: value == 'Laki-Laki' ? 1.h : 0,
                            top: value == 'Laki-Laki' ? 1.v : 0,
                          ),
                        ),
                        SizedBox(width: 10), // Adjust as needed
                        Text(value, style: TextStyle(color: Colors.white)),
                      ],
                    )
                  : Row(
                      children: [
                        CustomImageView(
                          imagePath:
                              ImageConstant.imgIconjeniskelaminRegisterpag,
                          height: 25.v,
                          width: 22.h,
                          margin: EdgeInsets.only(right: 10),
                        ),
                        Text(
                          // Displaying hint text
                          'Pilih Jenis Kelamin',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmailregister(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 51.h, right: 32.h),
        child: CustomTextFormField(
            textStyle: TextStyle(color: Colors.white),
            controller: iconnemailregisterController,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(21.h, 6.v, 30.h, 6.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgIconEmail,
                    height: 16.adaptSize,
                    width: 24.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 36.v)));
  }

  Widget _buildIconnomorteleponregister(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 51.h, right: 32.h),
        child: CustomTextFormField(
            textStyle: TextStyle(color: Colors.white),
            controller: iconnomorteleponregisterController,
            allowOnlyNumbers: true,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(21.h, 6.v, 30.h, 6.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgIconnomorteleponregister,
                    height: 24.adaptSize,
                    width: 24.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 36.v)));
  }

  /// Section Widget

  /// Section Widget
// Variabel untuk menyimpan status isObscure untuk setiap field
  bool isObscureKatasandi = true;
  bool isObscureKonfirmKatasandi = true;

  Widget _buildIconkatasandiregisterpag(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 51.h, right: 32.h),
      child: CustomTextFormField(
        textStyle: TextStyle(color: Colors.white),
        controller: iconkatasandiregisterpagController,
        textInputAction: TextInputAction.done,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(19.h, 6.v, 30.h, 6.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgIconkatasandiregisterpag,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
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
      ),
    );
  }

  Widget _buildIconkonfirmkatasandiregisterpag(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 51.h, right: 32.h),
      child: CustomTextFormField(
        textStyle: TextStyle(color: Colors.white),
        controller: iconkonfirmkatasandiregisterpagController,
        textInputAction: TextInputAction.done,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(19.h, 6.v, 30.h, 6.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgIconkatasandiregisterpag,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
        suffix: IconButton(
          icon: Icon(isObscureKonfirmKatasandi
              ? Icons.visibility
              : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isObscureKonfirmKatasandi = !isObscureKonfirmKatasandi;
            });
          },
          color: Colors.white,
        ),
        obscureText: isObscureKonfirmKatasandi,
        prefixConstraints: BoxConstraints(maxHeight: 36.v),
      ),
    );
  }

  void _register() async {
    String nik = logonikregisterpageController.text;
    String nama = logonamaregisterpagController.text;
    String jenis_kelamin = _jenisKelaminController.text;
    String tanggal_lahir = selectedDate.toString();
    String email = iconnemailregisterController.text;
    String no_telepon = iconnomorteleponregisterController.text;
    String kata_sandi = iconkatasandiregisterpagController.text;
    String konfirmasi_kata_sandi =
        iconkonfirmkatasandiregisterpagController.text;

    // Validasi form, misalnya memastikan semua field terisi dengan benar
    if (nik.isEmpty ||
        nama.isEmpty ||
        jenis_kelamin.isEmpty ||
        tanggal_lahir.isEmpty ||
        email.isEmpty ||
        no_telepon.isEmpty ||
        kata_sandi.isEmpty ||
        konfirmasi_kata_sandi.isEmpty) {
      // Tampilkan pesan alert jika ada field yang kosong
      alert(context, "Harap lengkapi semua data.", "gagal mendaftar!",
          Icons.error, Colors.red);
      return;
    } else if (kata_sandi == konfirmasi_kata_sandi) {
      try {
        Map<String, dynamic> response = await apiService.register(nik, nama,
            jenis_kelamin, tanggal_lahir, email, no_telepon, kata_sandi);

        if (response['status'] == 'success') {
          print('Registration successful');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPageScreen(),
            ),
          );
          alert(context, "Silahkan Masuk", "Berhasil Mendaftar!", Icons.check,
              Colors.green);
        } else {
          print('Registration failed: ${response['message']}');
          // Tambahkan logika penanganan jika registrasi gagal
        }
      } catch (e) {
        print('Error during registration: $e');
        // Tambahkan logika penanganan jika terjadi error
      }
    } else {
      alert(context, "Sandi dan konfirmasi sandi tidak sesuai.",
          "gagal mendaftar!", Icons.error, Colors.red);
    }
  }

  /// Section Widget
  Widget _buildDaftar(BuildContext context) {
    return CustomElevatedButton(
        text: "Daftar",
        margin: EdgeInsets.only(left: 45.h, right: 44.h, bottom: 53.v),
        onPressed: () async {
          RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*\d).+$');

          if (logonikregisterpageController.text.isEmpty ||
              logonamaregisterpagController.text.isEmpty ||
              _jenisKelaminController.text.isEmpty ||
              selectedDate.toString().isEmpty ||
              iconnemailregisterController.text.isEmpty ||
              iconnomorteleponregisterController.text.isEmpty ||
              iconkatasandiregisterpagController.text.isEmpty ||
              iconkonfirmkatasandiregisterpagController.text.isEmpty) {
            alert(context, "Isi semua data terlebih dahulu", "Gagal!",
                Icons.error, Colors.red);
          } else if (logonikregisterpageController.text.length != 16) {
            alert(context, "NIK harus terdiri dari 16 karakter", "Gagal!",
                Icons.error, Colors.red);
          } else if (!_isValidEmail(iconnemailregisterController.text)) {
            alert(context, "Format Email tidak valid", "Gagal!", Icons.error,
                Colors.red);
          } else if (iconkatasandiregisterpagController.text !=
              iconkonfirmkatasandiregisterpagController.text) {
            alert(context, "Sandi dan konfirmasi sandi tidak sesuai", "Gagal!",
                Icons.error, Colors.red);
          } else if (iconnomorteleponregisterController.text.length < 11 ||
              iconnomorteleponregisterController.text.length > 13) {
            alert(
                context,
                "Nomor telepon harus terdiri dari 11 hingga 13 digit",
                "Gagal!",
                Icons.error,
                Colors.red);
          } else if (iconkatasandiregisterpagController.text.length < 8 ||
              iconkonfirmkatasandiregisterpagController.text.length < 8 ||
              !regex.hasMatch(iconkatasandiregisterpagController.text) ||
              !regex.hasMatch(iconkonfirmkatasandiregisterpagController.text)) {
            alert(
                context,
                "Password harus memiliki 8 karakter, termasuk satu huruf besar dan satu angka.",
                "Gagal!",
                Icons.error,
                Colors.red);
          } else {
            try {
              Map<String, dynamic> responseData = await apiService.beforenext2(
                  iconnemailregisterController.text,
                  logonikregisterpageController.text);
              if (responseData['status'] == 'error') {
                // Menampilkan pesan kesalahan yang sesuai dengan respons dari backend
                String errorMessage = responseData['message'];
                if (errorMessage == 'Email sudah terdaftar') {
                  // Menampilkan alert jika email sudah terdaftar
                  alert(context, "Email sudah terdaftar.", "Gagal!",
                      Icons.error, Colors.red);
                } else if (errorMessage == 'NIK sudah terdaftar') {
                  // Menampilkan alert jika NIK sudah terdaftar
                  alert(context, "NIK sudah terdaftar.", "Gagal!", Icons.error,
                      Colors.red);
                } else {
                  // Menampilkan pesan kesalahan umum
                  alert(
                      context, errorMessage, "Gagal!", Icons.error, Colors.red);
                }
              } else {
                // Email is not found, proceed to OTP page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterOtp(
                      nik: logonikregisterpageController.text,
                      nama: logonamaregisterpagController.text,
                      jenis_kelamin: _jenisKelaminController.text,
                      tanggal_lahir: selectedDate.toString(),
                      email: iconnemailregisterController.text,
                      no_telepon: iconnomorteleponregisterController.text,
                      kata_sandi: iconkatasandiregisterpagController.text,
                    ),
                  ),
                );
              }
            } catch (e) {
              // Handle errors
              print("Error: $e");
              alert(context, "Terjadi kesalahan saat memeriksa email", "Gagal!",
                  Icons.error, Colors.red);
            }
          }
        });
  }
}

/// Navigates to the loginPageScreen when the action is triggered.
navigateTo(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.loginPageScreen);
}

/// Navigates to the loginPageScreen when the action is triggered.
onTapDaftar(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.loginPageScreen);
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

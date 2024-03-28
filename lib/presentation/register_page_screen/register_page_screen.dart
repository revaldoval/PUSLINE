import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class RegisterPageScreen extends StatelessWidget {
  RegisterPageScreen({Key? key}) : super(key: key);

  TextEditingController logonikregisterpageController = TextEditingController();

  TextEditingController logonamaregisterpagController = TextEditingController();

  TextEditingController iconnomorteleponregisterController =
      TextEditingController();

  TextEditingController iconkatasandiregisterpagController =
      TextEditingController();

  @override
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
                              Container(
                                  margin:
                                      EdgeInsets.only(left: 51.h, right: 32.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.h, vertical: 1.v),
                                  decoration: AppDecoration.outlineOnPrimary
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder18),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomImageView(
                                            imagePath: ImageConstant
                                                .imgIconjeniskelaminRegisterpag,
                                            height: 25.v,
                                            width: 22.h,
                                            margin: EdgeInsets.only(
                                                left: 13.h, top: 1.v)),
                                        CustomImageView(
                                            imagePath: ImageConstant
                                                .imgDropdownJeniskelamin,
                                            height: 26.adaptSize,
                                            width: 26.adaptSize)
                                      ])),
                              SizedBox(height: 8.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 96.h),
                                      child: Text("Tanggal Lahir",
                                          style: theme.textTheme.titleSmall))),
                              Container(
                                  height: 36.v,
                                  width: 277.h,
                                  margin: EdgeInsets.only(right: 32.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 17.h, vertical: 2.v),
                                  decoration: AppDecoration.outlineOnPrimary
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.circleBorder18),
                                  child: CustomImageView(
                                      imagePath: ImageConstant
                                          .imgIcontanggallahirRegisterpag,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                      alignment: Alignment.centerLeft)),
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
          onTapDaftar(context);
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

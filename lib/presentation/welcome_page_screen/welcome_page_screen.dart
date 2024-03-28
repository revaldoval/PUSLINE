import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:tolong_s_application1/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';

class WelcomePageScreen extends StatelessWidget {
  const WelcomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  _buildPUSLINE(context),
                  SizedBox(height: 39.v),
                  Text("PUSLINE", style: theme.textTheme.titleLarge),
                  SizedBox(height: 18.v),
                  Container(
                      width: 331.h,
                      margin: EdgeInsets.only(left: 12.h, right: 15.h),
                      child: Text(
                          "Akses layanan periksa kesehatan Puskesmas di ujung jarimu. Jadwalkan periksa, dapatkan informasi kesehatan terkini, dan jaga kebugaranmu dengan mudah. ",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.labelLargeOnPrimary)),
                  SizedBox(height: 44.v),
                  CustomElevatedButton(
                      text: "MASUK",
                      margin: EdgeInsets.only(left: 44.h, right: 45.h),
                      onPressed: () {
                        onTapMASUK(context);
                      }),
                  SizedBox(height: 17.v),
                  CustomOutlinedButton(
                      text: "DAFTAR",
                      margin: EdgeInsets.only(left: 44.h, right: 45.h),
                      onPressed: () {
                        onTapDAFTAR(context);
                      }),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  Widget _buildPUSLINE(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 53.v),
        decoration: AppDecoration.outlineBlack900351
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL46),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: AppDecoration.outlineBlack90035,
                  child: Text("PUSLINE",
                      style: CustomTextStyles.displayMediumBold)),
              SizedBox(height: 30.v),
              CustomImageView(
                  imagePath: ImageConstant.imgImage1477,
                  height: 196.v,
                  width: 302.h),
              SizedBox(height: 5.v)
            ]));
  }

  /// Navigates to the loginPageScreen when the action is triggered.
  onTapMASUK(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }

  /// Navigates to the registerPageScreen when the action is triggered.
  onTapDAFTAR(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerPageScreen);
  }
}

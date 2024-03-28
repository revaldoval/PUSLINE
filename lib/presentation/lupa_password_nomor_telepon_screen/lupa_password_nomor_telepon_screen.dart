import 'package:tolong_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:tolong_s_application1/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:tolong_s_application1/widgets/custom_text_form_field.dart';
import 'package:tolong_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';

// ignore_for_file: must_be_immutable
class LupaPasswordNomorTeleponScreen extends StatelessWidget {
  LupaPasswordNomorTeleponScreen({Key? key}) : super(key: key);

  TextEditingController iconnomorteleponlupapasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  _buildMasukkanNomorTelepon(context),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 44.h, vertical: 55.v),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 43.h),
                                child: Text("Nomor Telepon",
                                    style: theme.textTheme.titleSmall)),
                            SizedBox(height: 1.v),
                            CustomTextFormField(
                                controller:
                                    iconnomorteleponlupapasswordController,
                                textInputAction: TextInputAction.done,
                                prefix: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        17.h, 9.v, 30.h, 9.v),
                                    child: CustomImageView(
                                        imagePath: ImageConstant
                                            .imgIconnomorteleponregister,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize)),
                                prefixConstraints:
                                    BoxConstraints(maxHeight: 42.v),
                                borderDecoration: TextFormFieldStyleHelper
                                    .outlineOnPrimaryTL21),
                            SizedBox(height: 54.v),
                            CustomElevatedButton(text: "KIRIM"),
                            SizedBox(height: 5.v)
                          ]))
                ]))));
  }

  /// Section Widget
  Widget _buildMasukkanNomorTelepon(BuildContext context) {
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
              width: 277.h,
              margin: EdgeInsets.symmetric(horizontal: 55.h),
              decoration: AppDecoration.outlineBlack90035,
              child: Text("Masukkan Nomor Telepon",
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

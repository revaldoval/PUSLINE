import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/app_export.dart';
import 'package:tolong_s_application1/presentation/welcome_page_screen/welcome_page_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePageScreen()),
      );
    });

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: theme.colorScheme.onPrimary,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgSplashScreen,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 52.h,
                vertical: 244.v,
              ),
              decoration: AppDecoration.gradientTealAToGray,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoKemenkes1,
                    height: 140.v,
                    width: 140.h,
                  ),
                  SizedBox(height: 4.v),
                  Container(
                    decoration: AppDecoration.outlineBlack,
                    child: Text(
                      "PUSLINE",
                      style: theme.textTheme.displayMedium,
                    ),
                  ),
                  Text(
                    "#SehatBersama #PuskemasOnline",
                    style: CustomTextStyles.titleSmallOnPrimaryContainer,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

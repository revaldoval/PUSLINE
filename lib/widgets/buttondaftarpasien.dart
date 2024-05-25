import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'base_button.dart';

class ButtonDaftarPasien extends BaseButton {
  ButtonDaftarPasien({
    Key? key,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    bool? isDisabled,
    double? height,
    double? width,
    required String text,
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          height: height,
          width: width,
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle ??
          ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20),
            minimumSize: Size(double.infinity, 80),
            backgroundColor:
                isDisabled ?? false ? Colors.grey : Color(0xFF49A18C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
        child: Text(
          text,
          style: TextStyle(
            color: isDisabled ?? false ? Colors.black87 : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

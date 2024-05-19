import 'package:flutter/material.dart';
import 'package:tolong_s_application1/core/utils/size_utils.dart';
import 'package:tolong_s_application1/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Display text style
  static get displayMediumBold => theme.textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get detailnotif => theme.textTheme.displayMedium!
      .copyWith(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white);
  static get detailnotif2 => theme.textTheme.displayMedium!
      .copyWith(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.green);
  static get detailnotifRED => theme.textTheme.displayMedium!
      .copyWith(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.red);
  // Label text style
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 12.fSize,
      );
  // Title text style
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get notifikasi => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize, fontWeight: FontWeight.w500, color: Colors.black);
  static get notifikaditerima => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize, fontWeight: FontWeight.w500, color: Colors.green);
  static get notifikasiditolak => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize, fontWeight: FontWeight.w500, color: Colors.red);
        static get notifikasidiproses => theme.textTheme.titleMedium!.copyWith(
      fontSize: 16.fSize, fontWeight: FontWeight.w500, color: Colors.amber);

  static get poppin15 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get poppin14 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get poppin14black => theme.textTheme.titleMedium!.copyWith(
      fontSize: 14.fSize, fontWeight: FontWeight.w500, color: Colors.black);

  static get Poli => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );
  static get poppin12 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
      );
  static get poppin12black => theme.textTheme.titleMedium!.copyWith(
      fontSize: 12.fSize, fontWeight: FontWeight.w500, color: Colors.black);
  static get titleSmallOnPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallSemiBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleSmallffefaf00 => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFFEFAF00),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallffffffff => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFFFFFFFF),
        fontWeight: FontWeight.w600,
      );
  static get poppins13 => theme.textTheme.titleSmall!.copyWith(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );

  static get regular13 => theme.textTheme.titleSmall!.copyWith(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

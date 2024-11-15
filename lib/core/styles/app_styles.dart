import 'package:flutter/material.dart';
import 'package:questions_200/core/strings/app_strings.dart';

class AppStyles {
  static const EdgeInsets mainPadding = EdgeInsets.all(16);
  static const EdgeInsets mainPaddingMini = EdgeInsets.all(8);

  static const EdgeInsets paddingMiniWithoutBottom = EdgeInsets.only(left: 8, top: 8, right: 8);
  static const EdgeInsets paddingWithoutTop = EdgeInsets.only(left: 16, bottom: 16, right: 16);

  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingHorizontalMini = EdgeInsets.symmetric(horizontal: 8);

  static const EdgeInsets paddingBottom = EdgeInsets.only(bottom: 16);
  static const EdgeInsets paddingBottomMini = EdgeInsets.only(bottom: 8);

  static const EdgeInsets paddingRight = EdgeInsets.only(right: 16);
  static const EdgeInsets paddingRightMini = EdgeInsets.only(right: 8);

  static const EdgeInsets mainPaddingTopMini = EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16);

  static const RoundedRectangleBorder mainShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(25),
    ),
  );

  static const RoundedRectangleBorder mainShapeTop = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
  );

  static const mainTextStyle17 = TextStyle(
    fontSize: 17.0,
    fontFamily: AppStrings.fontRaleway,
  );

  static const mainTextStyle17Bold = TextStyle(
    fontSize: 17.0,
    fontFamily: AppStrings.fontRaleway,
    fontWeight: FontWeight.bold,
  );

  static const BorderRadius mainBorderRadius = BorderRadius.all(
    Radius.circular(25),
  );

  static const List<String> contentFonts = [
    'Gilroy',
    'Montserrat',
    'Raleway',
  ];

  static const List<String> textSizes = [
    'Маленький',
    'Нормальный',
    'Средний',
    'Большой',
    'Очень большой',
  ];

  static const List<String> appThemes = [
    'Светлая',
    'Тёмная',
    'Система',
  ];

  static const List<double> textValues = [
    16.0,
    18.0,
    22.0,
    30.0,
    60.0,
  ];

  static const List<TextAlign> textAligns = [
    TextAlign.left,
    TextAlign.center,
    TextAlign.right,
    TextAlign.justify,
  ];

  static const List<IconData> textAlignIcons = [
    Icons.format_align_left_rounded,
    Icons.format_align_center_rounded,
    Icons.format_align_right_rounded,
    Icons.format_align_justify_rounded,
  ];
}

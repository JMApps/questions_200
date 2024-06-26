import 'package:flutter/material.dart';

class AppStyles {
  static const EdgeInsets mainPadding = EdgeInsets.all(16);
  static const EdgeInsets mainPaddingMini = EdgeInsets.all(8);
  static const EdgeInsets mainMargin = EdgeInsets.all(16);
  static const EdgeInsets mainMarginMini = EdgeInsets.all(8);
  static const EdgeInsets mainPaddingWithoutTop = EdgeInsets.only(left: 8, right: 8, bottom: 22);

  static const RoundedRectangleBorder mainShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(25),
    ),
  );

  static const BorderRadius mainBorderRadius = BorderRadius.all(
    Radius.circular(25),
  );

  static const List<String> getFont = [
    'Gilroy',
    'Montserrat',
    'Raleway',
  ];

  static const List<TextAlign> getAlign = [
    TextAlign.left,
    TextAlign.center,
    TextAlign.right,
    TextAlign.justify,
  ];
}

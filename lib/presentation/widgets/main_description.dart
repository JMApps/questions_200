import 'package:flutter/material.dart';

import '../../core/styles/app_styles.dart';

class MainDescriptionText extends StatelessWidget {
  const MainDescriptionText({
    super.key,
    required this.descriptionText,
  });

  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.mainPadding,
      alignment: Alignment.center,
      child: Text(
        descriptionText,
        style: TextStyle(
          fontSize: 17.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

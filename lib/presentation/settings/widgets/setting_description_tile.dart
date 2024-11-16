import 'package:flutter/material.dart';
import 'package:questions_200/core/strings/app_strings.dart';

class SettingDescriptionTile extends StatelessWidget {
  const SettingDescriptionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AppStrings.textSize),
      leading: Icon(Icons.text_fields_rounded),
    );
  }
}

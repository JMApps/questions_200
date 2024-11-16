import 'package:flutter/material.dart';

import '../../../core/strings/app_strings.dart';

class SettingDescriptionTile extends StatelessWidget {
  const SettingDescriptionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(AppStrings.textSize),
      leading: Icon(Icons.text_fields_rounded),
    );
  }
}

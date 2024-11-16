import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/app_settings_state.dart';

class TextColorPickers extends StatefulWidget {
  const TextColorPickers({super.key});

  @override
  State<TextColorPickers> createState() => _TextColorPickersState();
}

class _TextColorPickersState extends State<TextColorPickers> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      title: const Text(
        AppStrings.textColor,
        style: AppStyles.mainTextStyle17,
      ),
      trailing: Consumer<AppSettingsState>(
        builder: (context, appSettingsState, _) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filledTonal(
                onPressed: () {
                  _showColorPicker(isDark: false, appSettingsState: appSettingsState);
                },
                tooltip: AppStrings.forLightTheme,
                icon: Icon(
                  Icons.palette,
                  color: Color(appSettingsState.getLightTextColor),
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  _showColorPicker(isDark: true, appSettingsState: appSettingsState);
                },
                tooltip: AppStrings.forDarkTheme,
                icon: Icon(
                  Icons.palette,
                  color: Color(appSettingsState.getDarkTextColor),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showColorPicker({required bool isDark, required AppSettingsState appSettingsState}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        actionsPadding: AppStyles.mainPaddingMini,
        title: Text(
          isDark ? AppStrings.forDarkTheme : AppStrings.forLightTheme,
          style: AppStyles.mainTextStyle17Bold,
        ),
        content: Material(
          color: Colors.transparent,
          child: MaterialColorPicker(
            alignment: WrapAlignment.center,
            iconSelected: Icons.check_circle,
            elevation: 0.5,
            onlyShadeSelection: true,
            onColorChange: (Color? color) => isDark ? appSettingsState.setDarkColor = color!.value : appSettingsState.setLightColor = color!.value,
            selectedColor: Color(isDark ? appSettingsState.getDarkTextColor : appSettingsState.getLightTextColor),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              AppStrings.close,
              style: AppStyles.mainTextStyle17,
            ),
          ),
        ],
      ),
    );
  }
}

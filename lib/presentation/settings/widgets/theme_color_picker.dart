import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/app_settings_state.dart';

class ThemeColorPicker extends StatefulWidget {
  const ThemeColorPicker({super.key});

  @override
  State<ThemeColorPicker> createState() => _ThemeColorPickerState();
}

class _ThemeColorPickerState extends State<ThemeColorPicker> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      title: const Text(
        AppStrings.themeColor,
        style: AppStyles.mainTextStyle17,
      ),
      trailing: Consumer<AppSettingsState>(
        builder: (context, appSettingsState, _) {
          return IconButton.filledTonal(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  alignment: Alignment.center,
                  actionsPadding: AppStyles.mainPaddingMini,
                  title: const Text(
                    AppStrings.selectThemeColor,
                    style: AppStyles.mainTextStyle17Bold,
                  ),
                  content: Material(
                    color: Colors.transparent,
                    child: MaterialColorPicker(
                      alignment: WrapAlignment.center,
                      iconSelected: Icons.check_circle,
                      elevation: 0.5,
                      onColorChange: (Color? color) => appSettingsState.setAppThemeColor = color!.value,
                      selectedColor: Color(appSettingsState.getAppThemeColor),
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
            },
            tooltip: AppStrings.forLightTheme,
            icon: Icon(
              Icons.palette,
              color: Color(appSettingsState.getAppThemeColor),
            ),
          );
        },
      ),
    );
  }
}

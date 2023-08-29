import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/content_settings_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/application/styles/app_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: SingleChildScrollView(
        padding: AppStyles.mainPadding,
        child: Consumer<ContentSettingsState>(
          builder: (context, settingsState, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppStrings.textFont,
                  style: appTheme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(4),
                  children: <int, Widget>{
                    0: Text(
                      'Gilroy',
                      style: appTheme.textTheme.headlineMedium,
                    ),
                    1: Text(
                      'Montserrat',
                      style: appTheme.textTheme.headlineMedium,
                    ),
                    2: Text(
                      'Nexa',
                      style: appTheme.textTheme.headlineMedium,
                    ),
                  },
                  groupValue: settingsState.getFontIndex,
                  onValueChanged: (int? index) {
                    settingsState.changeFontIndex = index!;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.alignText,
                  style: appTheme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(4),
                  children: const <int, Widget>{
                    0: Icon(CupertinoIcons.text_alignleft),
                    1: Icon(CupertinoIcons.text_aligncenter),
                    2: Icon(CupertinoIcons.text_alignright),
                    3: Icon(CupertinoIcons.text_justify),
                  },
                  groupValue: settingsState.getTextAlignIndex,
                  onValueChanged: (int? index) {
                    settingsState.changeTextAlignIndex = index!;
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.textSize,
                  style: appTheme.textTheme.headlineMedium,
                ),
                Slider(
                  value: settingsState.getTextSize,
                  min: 14,
                  max: 100,
                  divisions: 100,
                  label: settingsState.getTextSize.round().toString(),
                  onChanged: (double? size) {
                    settingsState.changeTextSize = size!;
                  },
                ),
                Card(
                  shape: AppStyles.mainShape,
                  child: ListTile(
                    shape: AppStyles.mainShape,
                    contentPadding: AppStyles.mainPaddingMini,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text(
                      AppStrings.textColor,
                      style: appTheme.textTheme.headlineMedium,
                    ),
                    leading: Icon(
                      Icons.palette_outlined,
                      color: appTheme.brightness == Brightness.dark
                          ? settingsState.getDarkTextColor
                          : settingsState.getLightTextColor,
                    ),
                    trailing: Card(
                      shape: AppStyles.mainShape,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                      AppStrings.forLightTheme,
                                      textAlign: TextAlign.center,
                                    ),
                                    shape: AppStyles.mainShape,
                                    content: Material(
                                      color: Colors.transparent,
                                      child: MaterialColorPicker(
                                        onlyShadeSelection: true,
                                        onColorChange: (Color color) {
                                          settingsState.changeLightColor =
                                              color;
                                        },
                                        selectedColor:
                                            settingsState.getLightTextColor,
                                      ),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        shape: AppStyles.mainShape,
                                        child: const Text(
                                          AppStrings.close,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    settingsState.getLightTextColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                      AppStrings.forDarkTheme,
                                      textAlign: TextAlign.center,
                                    ),
                                    shape: AppStyles.mainShape,
                                    content: Material(
                                      color: Colors.transparent,
                                      child: MaterialColorPicker(
                                        onlyShadeSelection: true,
                                        onColorChange: (Color color) {
                                          settingsState.changeArabicDarkColor =
                                              color;
                                        },
                                        selectedColor:
                                            settingsState.getDarkTextColor,
                                      ),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        shape: AppStyles.mainShape,
                                        child: const Text(
                                          AppStrings.close,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: settingsState.getDarkTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SwitchListTile(
                  value: settingsState.getAdaptiveTheme,
                  onChanged: (bool? onChanged) {
                    settingsState.changeAdaptiveTheme = onChanged!;
                  },
                  shape: AppStyles.mainShape,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppStrings.adaptiveTheme,
                    style: appTheme.textTheme.headlineMedium,
                  ),
                ),
                SwitchListTile(
                  value: settingsState.getDarkTheme,
                  onChanged: settingsState.getAdaptiveTheme ? null : (bool? onChanged) {
                    settingsState.changeDarkTheme = onChanged!;
                  },
                  shape: AppStyles.mainShape,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppStrings.darkTheme,
                    style: appTheme.textTheme.headlineMedium,
                  ),
                ),
                SwitchListTile(
                  value: settingsState.getWakeLock,
                  onChanged: (bool? onChanged) {
                    settingsState.changeWakeLock = onChanged!;
                  },
                  shape: AppStyles.mainShape,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppStrings.displayAlways,
                    style: appTheme.textTheme.headlineMedium,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

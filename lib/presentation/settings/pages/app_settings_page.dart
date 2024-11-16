import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/app_settings_state.dart';
import '../widgets/text_aligns_drop_down.dart';
import '../widgets/text_color_pickers.dart';
import '../widgets/text_fonts_drop_down.dart';
import '../widgets/text_sizes_drop_down.dart';
import '../widgets/theme_color_picker.dart';
import '../widgets/theme_mode_drop_down.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: SingleChildScrollView(
        padding: AppStyles.mainPadding,
        child: Consumer<AppSettingsState>(
          builder: (context, settingsState, _) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFontsDropDown(),
                Divider(indent: 16, endIndent: 16),
                TextSizesDropDown(),
                Divider(indent: 16, endIndent: 16),
                TextAlignsDropDown(),
                Divider(indent: 16, endIndent: 16),
                TextColorPickers(),
                Divider(indent: 16, endIndent: 16),
                ThemeModeDropDown(),
                Divider(indent: 16, endIndent: 16),
                ThemeColorPicker(),
                Divider(indent: 16, endIndent: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}

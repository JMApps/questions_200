import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/app_settings_state.dart';

class TextFontsDropDown extends StatelessWidget {
  const TextFontsDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final itemSelectedTextStyle = TextStyle(fontSize: 17.0, fontFamily: AppStrings.fontGilroy, color: appColors.primary, fontWeight: FontWeight.bold);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      title: const Text(
        AppStrings.textFont,
        style: AppStyles.mainTextStyle17,
      ),
      trailing: Consumer<AppSettingsState>(
        builder: (context, appSettingsState, _) {
          return DropdownButton<int>(
            iconEnabledColor: appColors.primary,
            borderRadius: AppStyles.mainBorderRadius,
            padding: AppStyles.mainPaddingMini,
            elevation: 1,
            alignment: Alignment.centerRight,
            value: appSettingsState.getFontIndex,
            items: List.generate(
              AppStyles.contentFonts.length,
              (index) => DropdownMenuItem<int>(
                value: index,
                alignment: Alignment.center,
                child: Text(AppStyles.contentFonts[index], style: appSettingsState.getFontIndex == index ? itemSelectedTextStyle : AppStyles.mainTextStyle17),
              ),
            ),
            onChanged: (newIndex) => appSettingsState.setFontIndex = newIndex!,
            underline: const SizedBox(),
          );
        },
      ),
    );
  }
}

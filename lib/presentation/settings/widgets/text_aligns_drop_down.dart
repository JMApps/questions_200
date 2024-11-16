import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/app_settings_state.dart';

class TextAlignsDropDown extends StatelessWidget {
  const TextAlignsDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final itemSelectedTextStyle = TextStyle(fontSize: 17.0, fontFamily: AppStrings.fontGilroy, color: appColors.primary, fontWeight: FontWeight.bold);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      title: Text(
        AppStrings.alignText,
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
            value: appSettingsState.getTextAlignIndex,
            items: List.generate(
              AppStyles.textAligns.length,
              (index) => DropdownMenuItem<int>(
                value: index,
                alignment: Alignment.center,
                child: Icon(
                  AppStyles.textAlignIcons[index],
                  color: appSettingsState.getTextAlignIndex == index ? appColors.primary : appColors.onSurface,
                ),
              ),
            ),
            onChanged: (newIndex) =>
                appSettingsState.setTextAlignIndex = newIndex!,
            underline: Container(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/app_settings_state.dart';

class AlwaysOnListTile extends StatelessWidget {
  const AlwaysOnListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      title: const Text(
        AppStrings.displayAlwaysOn,
        style: AppStyles.mainTextStyle17,
      ),
      trailing: Consumer<AppSettingsState>(
        builder: (context, appSettingsState, _) {
          return Switch(
            value: appSettingsState.getWakeLockState,
            onChanged: (onChanged) {
              appSettingsState.changeWakeLock = onChanged;
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/routes/app_routes.dart';
import '../../core/strings/app_strings.dart';
import '../../core/themes/app_theme.dart';
import '../state/app_settings_state.dart';
import 'main_page.dart';
import 'tablet_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsState>(
      builder: (context, appSettings, _) {
        final appThemes = AppThemes(Color(appSettings.getAppThemeColor));
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          title: AppStrings.appName,
          theme: appThemes.lightTheme,
          darkTheme: appThemes.darkTheme,
          themeMode: appSettings.getThemeMode,
          home: ScreenTypeLayout.builder(
            mobile: (BuildContext context) => const MainPage(),
            tablet: (BuildContext context) => const TabletPage(),
          ),
        );
      },
    );
  }
}

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/routes/app_routes.dart';
import 'package:questions_200/application/state/content_settings_state.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_constraints.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/application/themes/app_theme.dart';
import 'package:questions_200/presentation/pages/main_page.dart';
import 'package:questions_200/presentation/pages/tablet_page.dart';
import 'package:questions_200/presentation/widgets/default_scroll_behavior.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
  await Hive.initFlutter();
  await Hive.openBox(AppConstraints.keyAppSettingsBox);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainAppState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContentSettingsState(),
        ),
      ],
      child: const RootPage(),
    ),
  );
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown,
        },
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: DefaultScrollBehavior(),
          child: child!,
        );
      },
      themeMode: context.watch<ContentSettingsState>().getDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      home: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => const MainPage(),
        tablet: (BuildContext context) => const TabletPage(),
      ),
    );
  }
}

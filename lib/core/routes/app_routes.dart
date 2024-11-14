import 'package:flutter/material.dart';

import '../../presentation/settings/pages/app_settings_page.dart';
import '../../presentation/pages/content_question_page.dart';
import 'app_route_names.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteNames.questionContentPage:
        return MaterialPageRoute(
          builder: (_) => const ContentQuestionPage(),
        );
      case AppRouteNames.appSettingsPage:
        return MaterialPageRoute(
          builder: (_) => const AppSettingsPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:questions_200/main.dart';
import 'package:questions_200/pages/answer_content_page_a.dart';
import 'package:questions_200/pages/settings_a.dart';

class AppRouterA {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyAppA(), settings: routeSettings);
      case '/answer_content_a':
        return MaterialPageRoute(
            builder: (_) => AnswerContentPageA(), settings: routeSettings);
      case '/settings_a':
        return MaterialPageRoute(
            builder: (_) => SettingsA(), settings: routeSettings);
      default:
        throw Exception('Invalid route');
    }
  }
}

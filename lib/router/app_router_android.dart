import 'package:flutter/material.dart';
import 'package:questions_200/main.dart';
import 'package:questions_200/pages/answer_content_page_android.dart';
import 'package:questions_200/pages/settings.dart';

class AppRouterAndroid {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/android':
        return MaterialPageRoute(
            builder: (_) => MyAppAndroid(), settings: routeSettings);
      case '/answer_content_android':
        return MaterialPageRoute(
            builder: (_) => AnswerContentPageAndroid(), settings: routeSettings);
      case '/settings_android':
        return MaterialPageRoute(
            builder: (_) => Settings(), settings: routeSettings);
      default:
        throw Exception('Invalid route');
    }
  }
}

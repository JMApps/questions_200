import 'package:flutter/cupertino.dart';
import 'package:questions_200/main.dart';
import 'package:questions_200/pages/answer_content_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => MyApp(), settings: routeSettings);
      case '/answer_content':
        return CupertinoPageRoute(builder: (_) => AnswerContentPage(), settings: routeSettings);
      default:
        throw Exception('Invalid route');
    }
  }
}
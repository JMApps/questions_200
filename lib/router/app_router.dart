import 'package:flutter/cupertino.dart';
import 'package:questions_200/pages/answer_content_page.dart';
import 'package:questions_200/pages/main_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => MainPage());
      case '/answer_content':
        return CupertinoPageRoute(builder: (_) => AnswerContentPage());
      default:
        throw Exception('Invalid route');
    }
  }
}
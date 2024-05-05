import 'package:flutter/material.dart';

import '../../data/arguments/question_arguments.dart';
import '../../presentation/pages/answer_content_page.dart';
import '../../presentation/pages/settings_page.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/answer_content':
        final QuestionArguments questionArguments = routeSettings.arguments as QuestionArguments;
        return MaterialPageRoute(
          builder: (_) => AnswerContentPage(
            questionId: questionArguments.questionId,
          ),
        );
      case '/app_settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}

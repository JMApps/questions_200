import 'package:flutter/material.dart';
import 'package:questions_200/data/arguments/question_arguments.dart';
import 'package:questions_200/presentation/pages/answer_content_page.dart';
import 'package:questions_200/presentation/pages/settings_page.dart';

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

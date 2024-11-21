import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_route_names.dart';
import '../../core/strings/app_strings.dart';
import '../lists/main_questions_list.dart';
import '../state/main_app_state.dart';
import '../widgets/search_question_delegate.dart';

class MainQuestionsPage extends StatelessWidget {
  const MainQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        leading: IconButton.filledTonal(
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              AppRouteNames.questionContentPage,
            );
          },
          tooltip: AppStrings.lastHead,
          icon: Text(
            Provider.of<MainAppState>(context).getQuestionId.toString(),
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: AppStrings.fontGilroy,
            ),
          ),
        ),
        actions: [
          IconButton.filledTonal(
            onPressed: () {
              Provider.of<MainAppState>(context, listen: false).randomQuestion();
            },
            tooltip: AppStrings.randomQuestions,
            icon: const Icon(Icons.repeat),
          ),
          IconButton.filledTonal(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchQuestionDelegate(),
              );
            },
            tooltip: AppStrings.searchQuestions,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const MainQuestionsList(),
    );
  }
}

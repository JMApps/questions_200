import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../lists/favorite_questions_list.dart';

class FavoriteQuestionsPage extends StatelessWidget {
  const FavoriteQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookmarks),
      ),
      body: const FavoriteQuestionsList(),
    );
  }
}

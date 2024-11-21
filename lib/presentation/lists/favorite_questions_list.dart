import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../domain/entities/question_entity.dart';
import '../items/question_item.dart';
import '../state/questions_state.dart';
import '../widgets/favorite_is_empty.dart';
import '../widgets/main_error_text_data.dart';

class FavoriteQuestionsList extends StatelessWidget {
  const FavoriteQuestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionEntity>>(
      future: Provider.of<QuestionsState>(context, listen: false).getFavoriteQuestions(favoriteQuestionsIds: Provider.of<QuestionsState>(context).getFavoriteQuestionIds),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MainErrorTextData(errorText: snapshot.error.toString());
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const FavoriteIsEmpty(text: AppStrings.bookmarksIsEmpty);
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ScrollablePositionedList.builder(
            padding: AppStyles.paddingMiniWithoutBottom,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final QuestionEntity questionModel = snapshot.data![index];
              return QuestionItem(
                model: questionModel,
                index: index,
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_route_names.dart';
import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../domain/entities/question_entity.dart';
import '../state/main_app_state.dart';
import '../state/questions_state.dart';
import '../widgets/main_html_data.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.model,
    required this.index,
  });

  final QuestionEntity model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final itemOddColor = appColors.primary.withOpacity(0.025);
    final itemEvenColor = appColors.primary.withOpacity(0.075);
    return Container(
      margin: AppStyles.paddingBottom,
      decoration: BoxDecoration(
        color: index.isOdd ? itemOddColor : itemEvenColor,
        borderRadius: AppStyles.mainBorderRadius,
      ),
      child: ListTile(
        shape: AppStyles.mainShape,
        contentPadding: AppStyles.mainPaddingMini,
        horizontalTitleGap: 4,
        splashColor: itemOddColor,
        onTap: () async {
          Provider.of<MainAppState>(context, listen: false).setQuestionId = model.id;
          await Navigator.pushNamed(
            context,
            AppRouteNames.questionContentPage,
          );
        },
        title: Text(
          model.questionNumber,
          style: TextStyle(
            color: appColors.secondary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: AppStrings.fontGilroy,
          ),
        ),
        subtitle: MainHtmlData(
          htmlData: model.questionContent,
          font: AppStrings.fontRaleway,
          fontSize: 18.0,
          textAlign: TextAlign.start,
          fontColor: appColors.onSurface,
        ),
        leading: Consumer<QuestionsState>(
          builder: (context, questionsState, _) {
            final bool isFavorite = questionsState.questionIsFavorite(model.id);
            return IconButton.filledTonal(
              onPressed: () {
                questionsState.toggleQuestionFavorite(questionId: model.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: appColors.secondaryContainer,
                    duration: const Duration(milliseconds: 350),
                    content: Text(
                      isFavorite ? AppStrings.removed : AppStrings.added,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: appColors.onSurface,
                      ),
                    ),
                  ),
                );
              },
              icon: Icon(
                isFavorite ? Icons.bookmark : Icons.bookmark_border,
                color: appColors.secondary,
              ),
            );
          },
        ),
      ),
    );
  }
}

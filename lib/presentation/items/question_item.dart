import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../application/state/main_app_state.dart';
import '../../application/strings/app_strings.dart';
import '../../application/styles/app_styles.dart';
import '../../data/arguments/question_arguments.dart';
import '../../data/model/question_model.dart';
import '../widgets/footnote_data.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.model,
    required this.index,
  });

  final QuestionModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final MainAppState readMainState = context.read<MainAppState>();
    final bool isBookmark = readMainState.supplicationIsFavorite(model.id);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: AppStyles.mainShape,
      child: ListTile(
        onTap: () {
          readMainState.saveLastLesson = model.id;
          Navigator.pushNamed(
            context,
            '/answer_content',
            arguments: QuestionArguments(
              questionId: model.id,
            ),
          );
        },
        shape: AppStyles.mainShape,
        contentPadding: AppStyles.mainPaddingMini,
        visualDensity: const VisualDensity(horizontal: -4),
        title: Text(
          model.questionNumber,
          style: TextStyle(
            color: appColors.secondary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
        subtitle: Html(
          data: model.questionContent,
          style: {
            '#': Style(
              padding: HtmlPaddings.zero,
              margin: Margins.zero,
              fontSize: FontSize(18),
            ),
            'a': Style(
              fontSize: FontSize(18),
              color: appColors.error,
              fontFamily: 'Raleway',
            ),
          },
          onLinkTap: (String? footnoteId, _, __) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: appColors.background,
              builder: (context) => FootnoteData(
                footnoteId: int.parse(footnoteId!),
              ),
            );
          },
        ),
        leading: IconButton(
          onPressed: () {
            readMainState.toggleFavorite(model.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: appColors.secondaryContainer,
                duration: const Duration(milliseconds: 350),
                content: Text(
                  isBookmark ? AppStrings.removed : AppStrings.added,
                  style: TextStyle(
                    fontSize: 18,
                    color: appColors.inverseSurface,
                  ),
                ),
              ),
            );
          },
          icon: Icon(
            isBookmark
                ? CupertinoIcons.bookmark_solid
                : CupertinoIcons.bookmark,
            color: appColors.secondary,
          ),
        ),
      ),
    );
  }
}

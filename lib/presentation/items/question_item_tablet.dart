import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../application/state/main_app_state.dart';
import '../../application/strings/app_strings.dart';
import '../../application/styles/app_styles.dart';
import '../../data/model/question_model.dart';
import '../widgets/footnote_data.dart';

class QuestionItemTablet extends StatelessWidget {
  const QuestionItemTablet({
    super.key,
    required this.model,
    required this.index,
  });

  final QuestionModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final MainAppState readMainState = context.read<MainAppState>();
    final bool isBookmark = readMainState.supplicationIsFavorite(model.id);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: AppStyles.mainShape,
      child: ListTile(
        onTap: () {
          readMainState.changeQuestionId = model.id;
          readMainState.saveLastLesson = model.id;
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
              color: appColors.primary,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.bold,
            ),
          },
          onLinkTap: (String? footnoteId, _, __) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
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
                backgroundColor: appColors.primary,
                duration: const Duration(milliseconds: 350),
                content: Text(
                  isBookmark ? AppStrings.removed : AppStrings.added,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
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

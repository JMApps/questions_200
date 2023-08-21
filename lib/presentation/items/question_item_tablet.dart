import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/styles/app_styles.dart';
import 'package:questions_200/application/themes/app_theme.dart';
import 'package:questions_200/data/model/question_model.dart';
import 'package:questions_200/presentation/widgets/footnote_data.dart';

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
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: AppStyles.mainShape,
      child: ListTile(
        onTap: () {
          mainAppState.changeQuestionId = model.id;
          mainAppState.saveLastLesson = model.id;
        },
        shape: AppStyles.mainShape,
        contentPadding: AppStyles.mainPaddingMini,
        visualDensity: const VisualDensity(horizontal: -4),
        title: Text(
          model.questionNumber,
          style: TextStyle(
            color: appColors.titleColor,
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
              color: appColors.titleColor,
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
            mainAppState.addRemoveBookmark(model.favoriteState == 0 ? 1 : 0, model.id);
          },
          icon: Icon(
            model.favoriteState == 1
                ? CupertinoIcons.bookmark_solid
                : CupertinoIcons.bookmark,
            color: appColors.titleColor,
          ),
        ),
      ),
    );
  }
}

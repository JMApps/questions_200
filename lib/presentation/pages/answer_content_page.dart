import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/content_settings_state.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/application/styles/app_styles.dart';
import 'package:questions_200/application/themes/app_theme.dart';
import 'package:questions_200/data/model/question_model.dart';
import 'package:questions_200/presentation/widgets/footnote_data.dart';
import 'package:share_plus/share_plus.dart';

class AnswerContentPage extends StatelessWidget {
  const AnswerContentPage({
    super.key,
    required this.questionId,
    required this.questionContent,
  });

  final int questionId;
  final String questionContent;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return FutureBuilder<List<QuestionModel>>(
      future: context.read<MainAppState>().getDatabaseQuery.getAnswerContent(questionId),
      builder: (BuildContext context, AsyncSnapshot<List<QuestionModel>> snapshot) {
        if (snapshot.hasData) {
          final QuestionModel model = snapshot.data![0];
          return Consumer<ContentSettingsState>(
            builder: (context, settingsState, _) {
              return Scaffold(
                body: SelectableRegion(
                  focusNode: FocusNode(),
                  selectionControls: Platform.isIOS
                      ? CupertinoTextSelectionControls()
                      : MaterialTextSelectionControls(),
                  child: CupertinoScrollbar(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: Text('${AppStrings.question} $questionId'),
                          floating: true,
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/app_settings');
                              },
                              icon: const Icon(CupertinoIcons.settings),
                            ),
                            IconButton(
                              onPressed: () {
                                Share.share(
                                  _parseHtmlText(
                                    '${AppStrings.question} $questionId\n\n$questionContent\n\n${AppStrings.answer}\n\n${model.answerContent}\n\n${model.footnoteForShare ?? ''}',
                                  ),
                                  sharePositionOrigin: const Rect.fromLTWH(0, 0, 10, 10 / 2),
                                );
                              },
                              icon: const Icon(CupertinoIcons.share),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Card(
                            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            shape: AppStyles.mainShape,
                            child: Html(
                              data: questionContent,
                              style: {
                                '#': Style(
                                  padding: HtmlPaddings.zero,
                                  fontSize: FontSize(context.watch<ContentSettingsState>().getTextSize),
                                  textAlign: TextAlign.center,
                                  color: appColors.titleColor,
                                  fontWeight: FontWeight.bold,
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
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Html(
                            data: model.answerContent,
                            style: {
                              '#': Style(
                                padding: HtmlPaddings.all(4),
                                fontSize: FontSize(settingsState.getTextSize),
                                fontFamily: AppStyles.getFont[settingsState.getFontIndex],
                                textAlign: AppStyles.getAlign[settingsState.getTextAlignIndex],
                                color: settingsState.getDarkTheme
                                    ? settingsState.getDarkTextColor
                                    : settingsState.getLightTextColor,
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
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) => FootnoteData(
                                  footnoteId: int.parse(footnoteId!),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: AppStyles.mainPadding,
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  String _parseHtmlText(String htmlText) {
    final documentText = parse(htmlText);
    final String parsedString = parse(documentText.body!.text).documentElement!.text;
    return parsedString;
  }
}

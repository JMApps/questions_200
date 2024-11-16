import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/routes/app_route_names.dart';
import '../../core/strings/app_constraints.dart';
import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../domain/entities/question_entity.dart';
import '../state/app_settings_state.dart';
import '../state/main_app_state.dart';
import '../state/questions_state.dart';
import '../state/scroll_page_state.dart';
import '../widgets/fab_to_top.dart';
import '../widgets/main_error_text_data.dart';
import '../widgets/main_html_data.dart';

class ContentQuestionPage extends StatefulWidget {
  const ContentQuestionPage({super.key});

  @override
  State<ContentQuestionPage> createState() => _ContentQuestionPageState();
}

class _ContentQuestionPageState extends State<ContentQuestionPage> {
  late final int _questionId;
  late final Future<QuestionEntity> _futureQuestion;
  bool _isScrollInitialized = false;

  @override
  void initState() {
    super.initState();
    _questionId = Provider.of<MainAppState>(context, listen: false).getQuestionId;
    _futureQuestion = Provider.of<QuestionsState>(context, listen: false).getQuestionById(questionId: Provider.of<MainAppState>(context, listen: false).getQuestionId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ScrollPageState(
              '${AppConstraints.keyContentScrollProgress}$_questionId'),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${AppStrings.question} $_questionId',
            style: const TextStyle(
              fontFamily: AppStrings.fontGilroy,
            ),
          ),
          actions: [
            IconButton.filledTonal(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  AppRouteNames.appSettingsPage,
                );
              },
              icon: const Icon(Icons.settings),
            ),
            FutureBuilder<QuestionEntity>(
                future: Provider.of<QuestionsState>(context, listen: false).getQuestionById(questionId: _questionId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SizedBox();
                  }
                  if (snapshot.hasData) {
                    final QuestionEntity questionModel = snapshot.data!;
                    final String contentShare = [
                      questionModel.questionNumber,
                      questionModel.questionContent,
                      questionModel.answerContent,
                    ].join('\n\n');
                    return IconButton.filledTonal(
                      onPressed: () {
                        Share.share(_parseHtmlText(contentShare));
                      },
                      icon: const Icon(Icons.ios_share_outlined),
                    );
                  }
                  return const CircularProgressIndicator.adaptive();
                },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 0),
            child: Consumer<ScrollPageState>(
              builder: (context, scrollPageState, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: scrollPageState.getScrollProgress,
                  builder: (context, scrollProgress, child) {
                    return LinearProgressIndicator(
                      value: scrollProgress.clamp(0.0, 1.0),
                      minHeight: 3,
                    );
                  },
                );
              },
            ),
          ),
        ),
        body: FutureBuilder(
          future: _futureQuestion,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MainErrorTextData(
                errorText: snapshot.error.toString(),
              );
            }
            if (snapshot.hasData) {
              if (!_isScrollInitialized) {
                Provider.of<ScrollPageState>(context, listen: false).getScrollTo;
                _isScrollInitialized = true;
              }
              final QuestionEntity questionModel = snapshot.data!;
              return SingleChildScrollView(
                controller: Provider.of<ScrollPageState>(context, listen: false).getScrollController,
                padding: AppStyles.mainPaddingTopMini,
                child: Consumer<AppSettingsState>(
                  builder: (context, appSettings, _) {
                    return SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: Platform.isAndroid ? MaterialTextSelectionControls() : CupertinoTextSelectionControls(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 3),
                          Container(
                            padding: AppStyles.mainPadding,
                            decoration: BoxDecoration(
                              borderRadius: AppStyles.mainBorderRadius,
                              color: appColors.primary.withOpacity(0.15),
                            ),
                            child: MainHtmlData(
                              htmlData: "<b>${questionModel.questionContent}</b>",
                              font: AppStyles.contentFonts[appSettings.getFontIndex],
                              fontSize: AppStyles.textValues[appSettings.getTextSizeIndex],
                              textAlign: TextAlign.center,
                              fontColor: appColors.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Divider(indent: 16, endIndent: 16),
                          MainHtmlData(
                            htmlData: questionModel.answerContent,
                            font: AppStyles.contentFonts[appSettings.getFontIndex],
                            fontSize: AppStyles.textValues[appSettings.getTextSizeIndex],
                            textAlign: AppStyles.textAligns[appSettings.getTextAlignIndex],
                            fontColor: isDark ? Color(appSettings.getDarkTextColor) : Color(appSettings.getLightTextColor),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible: _questionId < 201,
                            child: OutlinedButton(
                              onPressed: () async {
                                Provider.of<MainAppState>(context, listen: false).setQuestionId = _questionId + 1;
                                await Navigator.pushReplacementNamed(
                                  context,
                                  AppRouteNames.questionContentPage,
                                );
                              },
                              child: const Text(
                                AppStrings.nextQuestion,
                                style: AppStyles.mainTextStyle17Bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
        floatingActionButton: const FabToTop(),
      ),
    );
  }

  String _parseHtmlText(String htmlText) {
    final documentText = parse(htmlText);
    final String parsedString = parse(documentText.body!.text).documentElement!.text;
    return parsedString;
  }
}

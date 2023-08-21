import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/application/styles/app_styles.dart';
import 'package:questions_200/application/themes/app_theme.dart';
import 'package:questions_200/data/arguments/question_arguments.dart';
import 'package:questions_200/data/model/question_model.dart';
import 'package:questions_200/presentation/items/question_item.dart';
import 'package:questions_200/presentation/items/question_item_tablet.dart';
import 'package:questions_200/presentation/widgets/search_question_delegate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QuestionChapters extends StatefulWidget {
  const QuestionChapters({Key? key}) : super(key: key);

  @override
  State<QuestionChapters> createState() => _QuestionChaptersState();
}

class _QuestionChaptersState extends State<QuestionChapters> {
  @override
  Widget build(BuildContext context) {
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Random random = Random();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            onPressed: () {
              mainAppState.getItemScrollController.scrollTo(
                index: random.nextInt(201),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInQuint,
              );
            },
            tooltip: AppStrings.randomQuestions,
            icon: const Icon(CupertinoIcons.arrow_2_squarepath),
          ),
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchQuestionDelegate(
                  hintText: AppStrings.searchQuestions,
                ),
              );
            },
            tooltip: AppStrings.searchQuestions,
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      ),
      body: FutureBuilder<List<QuestionModel>>(
        future: mainAppState.getDatabaseQuery.getAllQuestions(),
        builder: (BuildContext context, AsyncSnapshot<List<QuestionModel>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemPositionsListener: mainAppState.getItemPositionsListener,
                    itemScrollController: mainAppState.getItemScrollController,
                    scrollDirection: Axis.vertical,
                    padding: AppStyles.mainPaddingMini,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ScreenTypeLayout.builder(
                        mobile: (BuildContext context) => QuestionItem(
                          model: snapshot.data![index],
                          index: index,
                        ),
                        tablet: (BuildContext context) => QuestionItemTablet(
                          model: snapshot.data![index],
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: mainAppState.getLastQuestion > 0 ? true : false,
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppStyles.mainBorderRadius,
                      side: BorderSide(
                        width: 1,
                        color: appColors.titleColor,
                      ),
                    ),
                    child: ScreenTypeLayout.builder(
                      mobile: (BuildContext context) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/answer_content',
                            arguments: QuestionArguments(
                              questionId: mainAppState.getLastQuestion,
                            ),
                          );
                        },
                        borderRadius: AppStyles.mainBorderRadius,
                        child: Padding(
                          padding: AppStyles.mainPaddingMini,
                          child: Text(
                            '${AppStrings.lastHead} ${mainAppState.getLastQuestion} ${AppStrings.ofQuestion}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      tablet: (BuildContext context) => InkWell(
                        onTap: () {
                          mainAppState.changeQuestionId = mainAppState.getLastQuestion;
                        },
                        borderRadius: AppStyles.mainBorderRadius,
                        child: Padding(
                          padding: AppStyles.mainPaddingMini,
                          child: Text(
                            '${AppStrings.lastHead} ${mainAppState.getLastQuestion} ${AppStrings.ofQuestion}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: AppStyles.mainPadding,
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}

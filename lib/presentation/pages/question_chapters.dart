import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../application/state/main_app_state.dart';
import '../../application/strings/app_strings.dart';
import '../../application/styles/app_styles.dart';
import '../../data/arguments/question_arguments.dart';
import '../../data/model/question_model.dart';
import '../items/question_item.dart';
import '../items/question_item_tablet.dart';
import '../widgets/search_question_delegate.dart';

class QuestionChapters extends StatelessWidget {
  const QuestionChapters({super.key});

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
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemPositionsListener: mainAppState.getItemPositionsListener,
                    itemScrollController: mainAppState.getItemScrollController,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
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
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppStyles.mainBorderRadius,
                      side: BorderSide(
                        width: 1,
                        color: appColors.secondary,
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
                          padding: EdgeInsets.zero,
                          child: Text(
                            '${AppStrings.lastHead} ${mainAppState.getLastQuestion} ${AppStrings.ofQuestion}',
                            style: const TextStyle(
                              fontSize: 18,
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

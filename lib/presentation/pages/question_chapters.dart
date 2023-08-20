import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/application/styles/app_styles.dart';
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
    final Random random = Random();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.heads),
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
        builder: (BuildContext context,
            AsyncSnapshot<List<QuestionModel>> snapshot) {
          if (snapshot.hasData) {
            return ScrollablePositionedList.builder(
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

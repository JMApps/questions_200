import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/application/styles/app_styles.dart';
import 'package:questions_200/data/model/question_model.dart';
import 'package:questions_200/presentation/items/question_item.dart';
import 'package:questions_200/presentation/items/question_item_tablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuestionFavorites extends StatelessWidget {
  const QuestionFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookmarks),
      ),
      body: FutureBuilder<List<QuestionModel>>(
        future: context.watch<MainAppState>().getDatabaseQuery.getFavoriteChapters(),
        builder: (BuildContext context, AsyncSnapshot<List<QuestionModel>> snapshot) {
          if (snapshot.hasData) {
            return CupertinoScrollbar(
              child: ListView.builder(
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
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Padding(
                padding: AppStyles.mainPadding,
                child: Text(
                  AppStrings.bookmarksIsEmpty,
                  style: TextStyle(
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
      ),
    );
  }
}

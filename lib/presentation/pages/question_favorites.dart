import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../application/state/main_app_state.dart';
import '../../application/strings/app_strings.dart';
import '../../application/styles/app_styles.dart';
import '../../data/model/question_model.dart';
import '../items/question_item.dart';
import '../items/question_item_tablet.dart';

class QuestionFavorites extends StatefulWidget {
  const QuestionFavorites({super.key});

  @override
  State<QuestionFavorites> createState() => _QuestionFavoritesState();
}

class _QuestionFavoritesState extends State<QuestionFavorites> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final MainAppState appState = Provider.of<MainAppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookmarks),
      ),
      body: FutureBuilder<List<QuestionModel>>(
        future: appState.getDatabaseQuery.getFavoriteChapters(favorites: appState.getFavoriteList),
        builder: (BuildContext context, AsyncSnapshot<List<QuestionModel>> snapshot) {
          if (snapshot.hasData) {
            return CupertinoScrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
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

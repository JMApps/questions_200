import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/application/styles/app_styles.dart';
import 'package:questions_200/data/model/question_model.dart';
import 'package:questions_200/presentation/items/question_item.dart';

class SearchQuestionDelegate extends SearchDelegate {
  List<QuestionModel> _questions = [];
  List<QuestionModel> _recentQuestions = [];

  SearchQuestionDelegate({
    required String hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              onPressed: () {
                query = '';
              },
              splashRadius: 15,
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: transitionAnimation,
              ),
            )
          : const SizedBox(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      splashRadius: 20,
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchFuture(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchFuture(context);
  }

  Widget _searchFuture(BuildContext context) {
    return FutureBuilder<List>(
      future: context.watch<MainAppState>().getDatabaseQuery.getAllQuestions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _questions = snapshot.data;
          _recentQuestions = query.isEmpty
              ? _questions
              : _questions.where((element) =>
                      element.id.toString().contains(query) ||
                      element.questionNumber.toLowerCase().contains(query.toLowerCase()) ||
                      element.questionContent.toLowerCase().contains(query.toLowerCase())).toList();
          return _recentQuestions.isEmpty
              ? const Padding(
                  padding: AppStyles.mainPadding,
                  child: Center(
                    child: Text(
                      AppStrings.searchQueryIsEmpty,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : CupertinoScrollbar(
                  child: ListView.builder(
                    padding: AppStyles.mainPaddingMini,
                    itemCount: _recentQuestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return QuestionItem(
                        model: _recentQuestions[index],
                        index: index,
                      );
                    },
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
}

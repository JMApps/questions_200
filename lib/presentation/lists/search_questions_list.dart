import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../domain/entities/question_entity.dart';
import '../items/question_item.dart';
import '../state/questions_state.dart';
import '../widgets/main_description.dart';
import '../widgets/main_error_text_data.dart';

class SearchQuestionsList extends StatefulWidget {
  const SearchQuestionsList({
    super.key,
    required this.query,
  });

  final String query;

  @override
  State<SearchQuestionsList> createState() => _SearchQuestionsListState();
}

class _SearchQuestionsListState extends State<SearchQuestionsList> {
  late Future<List<QuestionEntity>> _futureQuestions;
  List<QuestionEntity> _questions = [];
  List<QuestionEntity> _recentQuestions = [];

  @override
  void initState() {
    super.initState();
    _futureQuestions = Provider.of<QuestionsState>(context, listen: false).getAllQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionEntity>>(
      future: _futureQuestions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _questions = snapshot.data!;
          _recentQuestions = widget.query.isEmpty ? _questions : _questions.where((element) => element.id.toString().contains(widget.query) || element.questionNumber.toLowerCase().contains(widget.query.toLowerCase()) || element.questionContent.toLowerCase().contains(widget.query.toLowerCase())).toList();
          return _recentQuestions.isEmpty ? const MainDescriptionText(descriptionText: AppStrings.searchQueryIsEmpty) : ListView.builder(
            padding: AppStyles.paddingMiniWithoutBottom,
            itemCount: _recentQuestions.length,
            itemBuilder: (context, index) {
              final QuestionEntity questionModel = _recentQuestions[index];
              return QuestionItem(
                model: questionModel,
                index: index,
              );
            },
          );
        }
        if (snapshot.hasError) {
          return MainErrorTextData(errorText: snapshot.error.toString());
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

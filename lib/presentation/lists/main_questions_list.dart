import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/presentation/state/main_app_state.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../core/styles/app_styles.dart';
import '../../domain/entities/question_entity.dart';
import '../items/question_item.dart';
import '../state/questions_state.dart';
import '../widgets/main_error_text_data.dart';

class MainQuestionsList extends StatefulWidget {
  const MainQuestionsList({super.key});

  @override
  State<MainQuestionsList> createState() => _MainQuestionsListState();
}

class _MainQuestionsListState extends State<MainQuestionsList> {
  late final Future<List<QuestionEntity>> _futureQuestions;

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
          return ScrollablePositionedList.builder(
            itemScrollController: Provider.of<MainAppState>(context, listen: false).getItemScrollController,
            padding: AppStyles.paddingMiniWithoutBottom,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final QuestionEntity questionModel = snapshot.data![index];
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
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

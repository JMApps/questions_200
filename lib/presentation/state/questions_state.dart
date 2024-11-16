import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/strings/app_constraints.dart';
import '../../domain/entities/footnote_entity.dart';
import '../../domain/entities/question_entity.dart';
import '../../domain/usecases/questions_use_case.dart';

class QuestionsState extends ChangeNotifier {
  final QuestionsUseCase _questionsUseCase;
  final _favoritesBox = Hive.box(AppConstraints.keyFavoritesList);

  QuestionsState(this._questionsUseCase) {
    _favoriteQuestionIds = _favoritesBox.get(AppConstraints.keyFavoritesList, defaultValue: <int>[]);
  }

  Future<List<QuestionEntity>> getAllQuestions() async {
    return await _questionsUseCase.getAllQuestions();
  }

  Future<List<QuestionEntity>> getFavoriteQuestions({required List<int> favoriteQuestionsIds}) async {
    return await _questionsUseCase.getFavoriteQuestions(favoriteQuestionsIds: favoriteQuestionsIds);
  }

  Future<QuestionEntity> getQuestionById({required int questionId}) async {
    return await _questionsUseCase.getQuestionById(questionId: questionId);
  }

  Future<FootnoteEntity> getFootnoteById({required int footnoteId}) async {
    return await _questionsUseCase.getFootnoteById(footnoteId: footnoteId);
  }

  Future<String> getFootnotesByQuestionId({required int questionId}) async {
    return await _questionsUseCase.getFootnotesByQuestionId(questionId: questionId);
  }

  List<int> _favoriteQuestionIds = [];

  List<int> get getFavoriteQuestionIds => _favoriteQuestionIds;

  void toggleQuestionFavorite({required int questionId}) {
    final bool exist = _favoriteQuestionIds.contains(questionId);
    if (exist) {
      _favoriteQuestionIds.remove(questionId);
    } else {
      _favoriteQuestionIds.add(questionId);
    }
    _favoritesBox.put(AppConstraints.keyFavoritesList, _favoriteQuestionIds);
    notifyListeners();
  }

  bool questionIsFavorite(int supplicationId) {
    return _favoriteQuestionIds.contains(supplicationId);
  }
}

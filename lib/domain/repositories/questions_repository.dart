import '../entities/footnote_entity.dart';
import '../entities/question_entity.dart';

abstract class QuestionsRepository {
  Future<List<QuestionEntity>> getAllQuestions();

  Future<List<QuestionEntity>> getFavoriteQuestions({required List<int> favoriteQuestionsIds});

  Future<QuestionEntity> getQuestionById({required int questionId});

  Future<FootnoteEntity> getFootnoteById({required int footnoteId});

  Future<String> getFootnotesByQuestionId({required int questionId});
}
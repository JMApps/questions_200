import '../entities/footnote_entity.dart';
import '../entities/question_entity.dart';
import '../repositories/questions_repository.dart';

class QuestionsUseCase {
  final QuestionsRepository _questionsRepository;

  QuestionsUseCase(this._questionsRepository);

  Future<List<QuestionEntity>> getAllQuestions() async {
    try {
      final List<QuestionEntity> allQuestions = await _questionsRepository.getAllQuestions();
      return allQuestions;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<QuestionEntity>> getFavoriteQuestions({required List<int> favoriteQuestionsIds}) async {
    try {
      final List<QuestionEntity> favoriteQuestions = await _questionsRepository.getFavoriteQuestions(favoriteQuestionsIds: favoriteQuestionsIds);
      return favoriteQuestions;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<QuestionEntity> getQuestionById({required int questionId}) async {
    try {
      final QuestionEntity questionById = await _questionsRepository.getQuestionById(questionId: questionId);
      return questionById;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<FootnoteEntity> getFootnoteById({required int footnoteId}) async {
    try {
      final FootnoteEntity footnoteById = await _questionsRepository.getFootnoteById(footnoteId: footnoteId);
      return footnoteById;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> getFootnotesByQuestionId({required int questionId}) async {
    try {
      final String footnotesByQuestionId = await _questionsRepository.getFootnotesByQuestionId(questionId: questionId);
      return footnotesByQuestionId;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
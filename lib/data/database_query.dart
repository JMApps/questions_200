import 'package:sqflite/sqflite.dart';

import 'database_service.dart';
import 'model/footnote_model.dart';
import 'model/question_model.dart';

class DatabaseQuery {
  final QuestionsService _questionsService = QuestionsService();
  final String _questionsTableName = 'Table_of_questions';
  final String _footnotesTableName = 'Table_of_footnotes';

  Future<List<QuestionModel>> getAllQuestions() async {
    final Database dbClient = await _questionsService.db;
    var res = await dbClient.query(_questionsTableName);
    List<QuestionModel>? allQuestions = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return allQuestions!;
  }

  Future<List<QuestionModel>> getFavoriteChapters({required List<int> favorites}) async {
    final Database dbClient = await _questionsService.db;
    var res = await dbClient.query(_questionsTableName, where: 'id IN (${favorites.map((id) => '?').join(', ')})', whereArgs: favorites);
    List<QuestionModel>? favoriteQuestions = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return favoriteQuestions!;
  }

  Future<QuestionModel> getAnswerContent(int questionId) async {
    final Database dbClient = await _questionsService.db;
    final List<Map<String, dynamic>> resource = await dbClient.query(_questionsTableName, where: 'id == $questionId');
    final QuestionModel? answerContent = resource.isNotEmpty ? QuestionModel.fromMap(resource.first) : null;
    return answerContent!;
  }

  Future<FootnoteModel> getFootnote(int footnoteId) async {
    final Database dbClient = await _questionsService.db;
    final List<Map<String, dynamic>> resource = await dbClient.query(_footnotesTableName, where: 'id == $footnoteId');
    final FootnoteModel? footnote = resource.isNotEmpty ? FootnoteModel.fromMap(resource.first) : null;
    return footnote!;
  }
}

import 'package:questions_200/data/database_helper.dart';
import 'package:questions_200/data/model/footnote_model.dart';
import 'package:questions_200/data/model/question_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseQuery {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<QuestionModel>> getAllQuestions() async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_questions');
    List<QuestionModel>? allQuestions = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return allQuestions!;
  }

  Future<List<QuestionModel>> getFavoriteChapters({required List<int> favorites}) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_questions', where: 'id IN (${favorites.map((id) => '?').join(', ')})', whereArgs: favorites);
    List<QuestionModel>? favoriteQuestions = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return favoriteQuestions!;
  }

  Future<List<QuestionModel>> getAnswerContent(int questionId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_questions', where: 'id == $questionId');
    List<QuestionModel>? answerContent = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return answerContent!;
  }

  Future<List<FootnoteModel>> getFootnote(int footnoteId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_footnotes', where: 'id == $footnoteId');
    List<FootnoteModel>? footnote = res.isNotEmpty ? res.map((c) => FootnoteModel.fromMap(c)).toList() : null;
    return footnote!;
  }
}

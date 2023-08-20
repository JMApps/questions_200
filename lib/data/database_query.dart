import 'package:questions_200/data/database_helper.dart';
import 'package:questions_200/data/model/footnote_model.dart';
import 'package:questions_200/data/model/question_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseQuery {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<QuestionModel>> getAllQuestions() async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_questions');
    List<QuestionModel>? allChapters = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return allChapters!;
  }

  Future<List<QuestionModel>> getFavoriteChapters() async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_questions', where: 'favorite_state == 1');
    List<QuestionModel>? favoriteChapters = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return favoriteChapters!;
  }

  Future<List<QuestionModel>> getAnswerContent(int questionId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_questions', where: 'id == $questionId');
    List<QuestionModel>? chapterContent = res.isNotEmpty ? res.map((c) => QuestionModel.fromMap(c)).toList() : null;
    return chapterContent!;
  }

  Future<List<FootnoteModel>> getFootnote(int footnoteId) async {
    final Database dbClient = await _databaseHelper.db;
    var res = await dbClient.query('Table_of_footnotes', where: 'id == $footnoteId');
    List<FootnoteModel>? footnote = res.isNotEmpty ? res.map((c) => FootnoteModel.fromMap(c)).toList() : null;
    return footnote!;
  }

  Future<void> addRemoveFavorite(int state, int id) async {
    final Database dbClient = await _databaseHelper.db;
    await dbClient.rawQuery('UPDATE Table_of_questions SET favorite_state = $state WHERE id == $id');
  }
}

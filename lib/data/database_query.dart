import 'package:questions_200/data/database_helper.dart';
import 'package:questions_200/model/question_item.dart';

class DatabaseQuery {
  DatabaseHelper con = DatabaseHelper();

  Future<List<QuestionItem>> getAllChapters() async {
    var dbClient = await con.db;
    var res = await dbClient.query('Table_of_questions');
    List<QuestionItem>? allChapters = res.isNotEmpty ? res.map((c) => QuestionItem.fromMap(c)).toList() : null;
    return allChapters!;
  }

  Future<List<QuestionItem>> getSearchResult(String text) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM Table_of_questions WHERE question_number LIKE '%$text%' OR question_content LIKE '%$text%'");
    List<QuestionItem>? searchResults = res.isNotEmpty ? res.map((c) => QuestionItem.fromMap(c)).toList() : null;
    return searchResults!;
  }

  addRemoveFavorite(int state, int _id) async {
    var dbClient = await con.db;
    await dbClient.rawQuery('UPDATE Table_of_questions SET favorite_state = $state WHERE _id == $_id');
  }

  Future<List<QuestionItem>> getFavoriteChapters() async {
    var dbClient = await con.db;
    var res = await dbClient.query('Table_of_questions', where: 'favorite_state == 1');
    List<QuestionItem>? favoriteChapters = res.isNotEmpty ? res.map((c) => QuestionItem.fromMap(c)).toList() : null;
    return favoriteChapters!;
  }
}
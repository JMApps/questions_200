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
}

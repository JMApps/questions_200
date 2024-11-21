import 'package:sqflite/sqflite.dart';

import '../../core/strings/db_values.dart';
import '../../domain/entities/footnote_entity.dart';
import '../../domain/entities/question_entity.dart';
import '../../domain/repositories/questions_repository.dart';
import '../services/database_service.dart';
import '../model/footnote_model.dart';
import '../model/question_model.dart';

class QuestionsDataRepository implements QuestionsRepository {
  final DatabaseService _databaseService;

  QuestionsDataRepository(this._databaseService);

  @override
  Future<List<QuestionEntity>> getAllQuestions() async {
    final Database database = await _databaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DbValues.dbQuestionsTableName);
    final List<QuestionEntity> allQuestions = resources.isNotEmpty ? resources.map((e) => QuestionEntity.fromModel(QuestionModel.fromMap(e))).toList() : [];
    return allQuestions;
  }

  @override
  Future<List<QuestionEntity>> getFavoriteQuestions({required List<int> favoriteQuestionsIds}) async {
    final Database database = await _databaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DbValues.dbQuestionsTableName, where: '${DbValues.dbId} IN (${favoriteQuestionsIds.map((id) => '?').join(', ')})', whereArgs: favoriteQuestionsIds);
    final List<QuestionEntity> favoriteQuestions = resources.isNotEmpty ? resources.map((e) => QuestionEntity.fromModel(QuestionModel.fromMap(e))).toList() : [];
    return favoriteQuestions;
  }

  @override
  Future<QuestionEntity> getQuestionById({required int questionId}) async {
    final Database database = await _databaseService.db;
    final List<Map<String, Object?>> resource = await database.query(DbValues.dbQuestionsTableName, where: 'id = ?', whereArgs: [questionId]);
    final QuestionEntity? questionById = resource.isNotEmpty ? QuestionEntity.fromModel(QuestionModel.fromMap(resource.first)) : null;
    return questionById!;
  }

  @override
  Future<FootnoteEntity> getFootnoteById({required int footnoteId}) async {
    final Database database = await _databaseService.db;
    final List<Map<String, dynamic>> resource = await database.query(DbValues.dbFootnotesTableName, where: 'id = ?', whereArgs: [footnoteId]);
    final FootnoteEntity? footnoteById = resource.isNotEmpty ? FootnoteEntity.fromModel(FootnoteModel.fromMap(resource.first)) : null;
    return footnoteById!;
  }

  @override
  Future<String> getFootnotesByQuestionId({required int questionId}) async {
    final Database database = await _databaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DbValues.dbFootnotesTableName, where: '${DbValues.dbContentNumber} = ?', whereArgs: [questionId]);
    final List<FootnoteEntity> footnotesByQuestionId = resources.isNotEmpty ? resources.map((e) => FootnoteEntity.fromModel(FootnoteModel.fromMap(e))).toList() : [];
    final String serializedFootnotes = footnotesByQuestionId.asMap().entries.map((entry) => '[${entry.value.id}] – ${entry.value.footnoteContent}').join('\n\n');
    return serializedFootnotes;
  }
}

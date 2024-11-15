import '../../core/strings/db_values.dart';

class QuestionModel {
  final int id;
  final String questionNumber;
  final String questionContent;
  final String answerContent;

  const QuestionModel({
    required this.id,
    required this.questionNumber,
    required this.questionContent,
    required this.answerContent,
  });

  factory QuestionModel.fromMap(Map<String, Object?> map) {
    return QuestionModel(
      id: map[DbValues.dbId] as int,
      questionNumber: map[DbValues.dbQuestionNumber] as String,
      questionContent: map[DbValues.dbQuestionContent] as String,
      answerContent: map[DbValues.dbAnswerContent] as String,
    );
  }
}

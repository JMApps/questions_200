import '../../data/model/question_model.dart';

class QuestionEntity {
  final int id;
  final String questionNumber;
  final String questionContent;
  final String answerContent;

  const QuestionEntity({
    required this.id,
    required this.questionNumber,
    required this.questionContent,
    required this.answerContent,
  });

  factory QuestionEntity.fromModel(QuestionModel model) {
    return QuestionEntity(
      id: model.id,
      questionNumber: model.questionNumber,
      questionContent: model.questionContent,
      answerContent: model.answerContent,
    );
  }
}

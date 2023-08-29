class QuestionModel {
  final int id;
  final String questionNumber;
  final String questionContent;
  final String answerContent;
  final String? footnoteForShare;

  QuestionModel({
    required this.id,
    required this.questionNumber,
    required this.questionContent,
    required this.answerContent,
    required this.footnoteForShare,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int,
      questionNumber: map['question_number'] as String,
      questionContent: map['question_content'] as String,
      answerContent: map['answer_content'] as String,
      footnoteForShare: map['footnote_for_share'] as String?,
    );
  }
}

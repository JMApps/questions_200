class QuestionModel {
  final int id;
  final String questionNumber;
  final String questionContent;
  final String answerContent;
  final String? footnoteForShare;
  final int favoriteState;

  QuestionModel({
    required this.id,
    required this.questionNumber,
    required this.questionContent,
    required this.answerContent,
    required this.footnoteForShare,
    required this.favoriteState,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      questionNumber: map['question_number'],
      questionContent: map['question_content'],
      answerContent: map['answer_content'],
      footnoteForShare: map['footnote_for_share'],
      favoriteState: map['favorite_state'],
    );
  }
}

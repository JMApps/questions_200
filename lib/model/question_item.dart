class QuestionItem {
  int? id;
  String? questionNumber;
  String? questionContent;
  String? answerContent;
  int? favoriteState;

  QuestionItem(
    this.id,
    this.questionNumber,
    this.questionContent,
    this.answerContent,
    this.favoriteState,
  );

  QuestionItem.fromMap(dynamic obj) {
    this.id = obj['_id'];
    this.questionNumber = obj['question_number'];
    this.questionContent = obj['question_content'];
    this.answerContent = obj['answer_number'];
    this.favoriteState = obj['favorite_state'];
  }
}

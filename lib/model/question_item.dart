class QuestionItem {
  int? id;
  String? questionNumber;
  String? questionContent;
  String? answerContent;
  String? footnoteForShare;
  int? favoriteState;

  QuestionItem(
    this.id,
    this.questionNumber,
    this.questionContent,
    this.answerContent,
    this.footnoteForShare,
    this.favoriteState,
  );

  QuestionItem.fromMap(dynamic obj) {
    this.id = obj['_id'];
    this.questionNumber = obj['question_number'];
    this.questionContent = obj['question_content'];
    this.answerContent = obj['answer_content'];
    this.footnoteForShare = obj['footnote_for_share'];
    this.favoriteState = obj['favorite_state'];
  }
}

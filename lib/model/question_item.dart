class QuestionItem {
  int? id;
  String? questionNumber;
  String? questionContent;
  String? answerContent;

  QuestionItem(this.id, this.questionNumber, this.questionContent, this.answerContent);

  QuestionItem.fromMap(dynamic obj) {
    this.id = obj['_id'];
    this.questionNumber = obj['question_number'];
    this.questionContent = obj['question_content'];
    this.answerContent = obj['answer_number'];
  }
}
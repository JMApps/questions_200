class FootnoteModel {
  final int id;
  final String footnoteContent;

  FootnoteModel({
    required this.id,
    required this.footnoteContent,
  });

  factory FootnoteModel.fromMap(Map<String, dynamic> map) {
    return FootnoteModel(
      id: map['id'],
      footnoteContent: map['footnote_content'],
    );
  }
}

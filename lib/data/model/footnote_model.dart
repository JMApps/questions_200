import '../../core/strings/db_values.dart';

class FootnoteModel {
  final int id;
  final String footnoteContent;

  const FootnoteModel({
    required this.id,
    required this.footnoteContent,
  });

  factory FootnoteModel.fromMap(Map<String, Object?> map) {
    return FootnoteModel(
      id: map[DbValues.dbId] as int,
      footnoteContent: map[DbValues.dbFootnoteContent] as String,
    );
  }
}

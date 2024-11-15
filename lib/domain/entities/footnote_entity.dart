import '../../data/model/footnote_model.dart';

class FootnoteEntity {
  final int id;
  final String footnoteContent;

  const FootnoteEntity({
    required this.id,
    required this.footnoteContent,
  });

  factory FootnoteEntity.fromModel(FootnoteModel model) {
    return FootnoteEntity(
      id: model.id,
      footnoteContent: model.footnoteContent,
    );
  }
}

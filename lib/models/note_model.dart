class NoteModel {
  late int? note_id;
  late String note;

  NoteModel({this.note_id,required this.note});

  factory NoteModel.fromMap({required Map data}) {
    return NoteModel(note: data['note'],
    note_id: data['note_id']);
  }
}

import 'dart:convert';

class NoteModel {
  int? id;
  String? title;
  String? body;
  final int? colorCode;
  bool iLikedIt;
  NoteModel(
      {this.id, this.title, this.body, this.colorCode, this.iLikedIt = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'colorCode': colorCode,
      'like': iLikedIt
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      colorCode: map['colorCode'] != null ? map['colorCode'] as int : null,
      iLikedIt: map['like'] != null ? map['like'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, body: $body, colorCode: $colorCode)';
  }
}

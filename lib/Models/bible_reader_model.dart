// To parse this JSON data, do
//
//     final bibleReaderModel = bibleReaderModelFromJson(jsonString);

import 'dart:convert';

List<BibleReaderModel> bibleReaderModelFromJson(String str) =>
    List<BibleReaderModel>.from(
        json.decode(str).map((x) => BibleReaderModel.fromJson(x)));

String bibleReaderModelToJson(List<BibleReaderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BibleReaderModel {
  BibleReaderModel({
    required this.id,
    //required this.book,
    required this.chapterId,
    required this.verseId,
    required this.verse,
  });

  int id;
  //Book book;
  int chapterId;
  int verseId;
  String verse;

  factory BibleReaderModel.fromJson(Map<String, dynamic> json) =>
      BibleReaderModel(
        id: json["id"],
        //book: Book.fromJson(json["book"]),
        chapterId: json["chapterId"],
        verseId: json["verseId"],
        verse: json["verse"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        //"book": book.toJson(),
        "chapterId": chapterId,
        "verseId": verseId,
        "verse": verse,
      };
}

class Book {
  Book({
    required this.id,
    required this.name,
    required this.testament,
  });

  int id;
  Name name;
  Testament testament;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        testament: testamentValues.map[json["testament"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse![name],
        "testament": testamentValues.reverse![testament],
      };
}

enum Name { GENESIS }

final nameValues = EnumValues({"Genesis": Name.GENESIS});

enum Testament { OT }

final testamentValues = EnumValues({"OT": Testament.OT});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap;
    return reverseMap;
  }
}

// To parse this JSON data, do
//
//     final bibleChapterBookModel = bibleChapterBookModelFromJson(jsonString);

import 'dart:convert';

List<BibleChapterBookModel> bibleChapterBookModelFromJson(String str) =>
    List<BibleChapterBookModel>.from(
        json.decode(str).map((x) => BibleChapterBookModel.fromJson(x)));

String bibleChapterBookModelToJson(List<BibleChapterBookModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BibleChapterBookModel {
  BibleChapterBookModel(
      {required this.bookId,
      required this.osisId,
      required this.bookName,
      required this.totalChapters,
      required this.volume,
      required this.isExpanded});

  int bookId;
  String osisId;
  String bookName;
  int totalChapters;
  String volume;
  bool isExpanded;

  factory BibleChapterBookModel.fromJson(Map<String, dynamic> json) =>
      BibleChapterBookModel(
          bookId: json["BookID"],
          osisId: json["OsisID"],
          bookName: json["BookName"],
          totalChapters: json["TotalChapters"],
          volume: json["Volume"],
          isExpanded: json['isExpanded'] ?? false);

  Map<String, dynamic> toJson() => {
        "BookID": bookId,
        "OsisID": osisId,
        "BookName": bookName,
        "TotalChapters": totalChapters,
        "Volume": volume,
        "isExpanded": isExpanded
      };
}

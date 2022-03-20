// To parse this JSON data, do
//
//     final bibleTranslationModel = bibleTranslationModelFromJson(jsonString);

import 'dart:convert';

List<BibleTranslationModel> bibleTranslationModelFromJson(String str) =>
    List<BibleTranslationModel>.from(
        json.decode(str).map((x) => BibleTranslationModel.fromJson(x)));

String bibleTranslationModelToJson(List<BibleTranslationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BibleTranslationModel {
  BibleTranslationModel({
    required this.id,
    required this.table,
    required this.language,
    required this.abbreviation,
    required this.version,
    required this.infoUrl,
  });

  int id;
  String table;
  String language;
  String abbreviation;
  String version;
  String infoUrl;

  factory BibleTranslationModel.fromJson(Map<String, dynamic> json) =>
      BibleTranslationModel(
        id: json["id"],
        table: json["table"],
        language: json["language"],
        abbreviation: json["abbreviation"],
        version: json["version"],
        infoUrl: json["infoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table": table,
        "language": language,
        "abbreviation": abbreviation,
        "version": version,
        "infoUrl": infoUrl,
      };
}

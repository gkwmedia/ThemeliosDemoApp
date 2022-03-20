// To parse this JSON data, do
//
//     final preachersModel = preachersModelFromJson(jsonString);

import 'dart:convert';

List<PreachersModel> preachersModelFromJson(String str) =>
    List<PreachersModel>.from(
        json.decode(str)['items'].map((x) => PreachersModel.fromJson(x)));

String preachersModelToJson(List<PreachersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreachersModel {
  PreachersModel({
    required this.archived,
    required this.draft,
    required this.name,
    required this.slug,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
    required this.publishedOn,
    required this.publishedBy,
    required this.cid,
    required this.id,
  });

  bool archived;
  bool draft;
  String name;
  String slug;
  DateTime updatedOn;
  String updatedBy;
  DateTime createdOn;
  String createdBy;
  DateTime publishedOn;
  String publishedBy;
  String cid;
  String id;

  factory PreachersModel.fromJson(Map<String, dynamic> json) => PreachersModel(
        archived: json["_archived"],
        draft: json["_draft"],
        name: json["name"],
        slug: json["slug"],
        updatedOn: DateTime.parse(json["updated-on"]),
        updatedBy: json["updated-by"],
        createdOn: DateTime.parse(json["created-on"]),
        createdBy: json["created-by"],
        publishedOn: DateTime.parse(json["published-on"]),
        publishedBy: json["published-by"],
        cid: json["_cid"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_archived": archived,
        "_draft": draft,
        "name": name,
        "slug": slug,
        "updated-on": updatedOn.toIso8601String(),
        "updated-by": updatedBy,
        "created-on": createdOn.toIso8601String(),
        "created-by": createdBy,
        "published-on": publishedOn.toIso8601String(),
        "published-by": publishedBy,
        "_cid": cid,
        "_id": id,
      };
}

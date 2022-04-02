// To parse this JSON data, do
//
//     final frontPageModel = frontPageModelFromJson(jsonString);

import 'dart:convert';

List<FrontPageModel> frontPageModelFromJson(String str) =>
    List<FrontPageModel>.from(
        json.decode(str)["items"].map((x) => FrontPageModel.fromJson(x)));

String frontPageModelToJson(List<FrontPageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FrontPageModel {
  FrontPageModel({
    required this.link,
    required this.archived,
    required this.draft,
    required this.subtitle,
    required this.name,
    required this.slug,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
    required this.publishedOn,
    required this.publishedBy,
    required this.sortOrder,
    required this.cid,
    required this.id,
  });

  String link;
  bool archived;
  bool draft;
  String subtitle;
  String name;
  String slug;
  DateTime updatedOn;
  String updatedBy;
  DateTime createdOn;
  String createdBy;
  DateTime publishedOn;
  String publishedBy;
  int sortOrder;
  String cid;
  String id;

  factory FrontPageModel.fromJson(Map<String, dynamic> json) => FrontPageModel(
        link: json["link"] ?? "http://google.com",
        archived: json["_archived"],
        draft: json["_draft"],
        subtitle: json["subtitle"] ?? "",
        name: json["name"],
        slug: json["slug"],
        updatedOn: DateTime.parse(json["updated-on"]),
        updatedBy: json["updated-by"],
        createdOn: DateTime.parse(json["created-on"]),
        createdBy: json["created-by"],
        publishedOn: DateTime.parse(json["published-on"]),
        publishedBy: json["published-by"],
        sortOrder: json["sort-order"] ?? 9999,
        cid: json["_cid"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "_archived": archived,
        "_draft": draft,
        "subtitle": subtitle,
        "name": name,
        "slug": slug,
        "updated-on": updatedOn.toIso8601String(),
        "updated-by": updatedBy,
        "created-on": createdOn.toIso8601String(),
        "created-by": createdBy,
        "published-on": publishedOn.toIso8601String(),
        "published-by": publishedBy,
        "sort-order": sortOrder,
        "_cid": cid,
        "_id": id,
      };
}

// To parse this JSON data, do
//
//     final frontPageImageModel = frontPageImageModelFromJson(jsonString);

import 'dart:convert';

List<FrontPageImageModel> frontPageImageModelFromJson(String str) =>
    List<FrontPageImageModel>.from(
        json.decode(str)["items"].map((x) => FrontPageImageModel.fromJson(x)));

String frontPageImageModelToJson(List<FrontPageImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FrontPageImageModel {
  FrontPageImageModel({
    required this.archived,
    required this.draft,
    required this.name,
    required this.slug,
    required this.image,
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
  Image image;
  DateTime updatedOn;
  String updatedBy;
  DateTime createdOn;
  String createdBy;
  dynamic publishedOn;
  dynamic publishedBy;
  String cid;
  String id;

  factory FrontPageImageModel.fromJson(Map<String, dynamic> json) =>
      FrontPageImageModel(
        archived: json["_archived"],
        draft: json["_draft"],
        name: json["name"],
        slug: json["slug"],
        image: Image.fromJson(json["image"]),
        updatedOn: DateTime.parse(json["updated-on"]),
        updatedBy: json["updated-by"],
        createdOn: DateTime.parse(json["created-on"]),
        createdBy: json["created-by"],
        publishedOn: json["published-on"],
        publishedBy: json["published-by"],
        cid: json["_cid"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_archived": archived,
        "_draft": draft,
        "name": name,
        "slug": slug,
        "image": image.toJson(),
        "updated-on": updatedOn.toIso8601String(),
        "updated-by": updatedBy,
        "created-on": createdOn.toIso8601String(),
        "created-by": createdBy,
        "published-on": publishedOn,
        "published-by": publishedBy,
        "_cid": cid,
        "_id": id,
      };
}

class Image {
  Image({
    required this.fileId,
    required this.url,
    required this.alt,
  });

  String fileId;
  String url;
  dynamic alt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        fileId: json["fileId"],
        url: json["url"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "url": url,
        "alt": alt,
      };
}

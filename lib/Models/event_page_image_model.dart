// To parse this JSON data, do
//
//     final eventPageImageModel = eventPageImageModelFromJson(jsonString);

import 'dart:convert';

List<EventPageImageModel> eventPageImageModelFromJson(String str) =>
    List<EventPageImageModel>.from(
        json.decode(str)["items"].map((x) => EventPageImageModel.fromJson(x)));

String eventPageImageModelToJson(List<EventPageImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventPageImageModel {
  EventPageImageModel({
    required this.archived,
    required this.draft,
    required this.name,
    required this.image,
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
  Image image;
  String slug;
  DateTime updatedOn;
  String updatedBy;
  DateTime createdOn;
  String createdBy;
  dynamic publishedOn;
  dynamic publishedBy;
  String cid;
  String id;

  factory EventPageImageModel.fromJson(Map<String, dynamic> json) =>
      EventPageImageModel(
        archived: json["_archived"],
        draft: json["_draft"],
        name: json["name"],
        image: Image.fromJson(json["image"]),
        slug: json["slug"],
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
        "image": image.toJson(),
        "slug": slug,
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

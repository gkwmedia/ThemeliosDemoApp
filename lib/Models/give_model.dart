// To parse this JSON data, do
//
//     final givePageModel = givePageModelFromJson(jsonString);

import 'dart:convert';

List<GivePageModel> givePageModelFromJson(String str) =>
    List<GivePageModel>.from(
        json.decode(str)["items"].map((x) => GivePageModel.fromJson(x)));

String givePageModelToJson(List<GivePageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GivePageModel {
  GivePageModel({
    required this.giveLink,
    required this.commitLink,
    required this.archived,
    required this.draft,
    required this.paragraph,
    required this.name,
    required this.givingImage,
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

  String giveLink;
  String commitLink;
  bool archived;
  bool draft;
  String paragraph;
  String name;
  GivingImage givingImage;
  String slug;
  DateTime updatedOn;
  String updatedBy;
  DateTime createdOn;
  String createdBy;
  dynamic publishedOn;
  dynamic publishedBy;
  String cid;
  String id;

  factory GivePageModel.fromJson(Map<String, dynamic> json) => GivePageModel(
        giveLink: json["give-link"],
        commitLink: json["commit-link"] ?? "",
        archived: json["_archived"],
        draft: json["_draft"],
        paragraph: json["paragraph"],
        name: json["name"],
        givingImage: GivingImage.fromJson(json["giving-image"]),
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
        "give-link": giveLink,
        "commit-link": commitLink,
        "_archived": archived,
        "_draft": draft,
        "paragraph": paragraph,
        "name": name,
        "giving-image": givingImage.toJson(),
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

class GivingImage {
  GivingImage({
    required this.fileId,
    required this.url,
    required this.alt,
  });

  String fileId;
  String url;
  dynamic alt;

  factory GivingImage.fromJson(Map<String, dynamic> json) => GivingImage(
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

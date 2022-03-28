// To parse this JSON data, do
//
//     final eventsModel = eventsModelFromJson(jsonString);

import 'dart:convert';

List<EventsModel> eventsModelFromJson(String str) => List<EventsModel>.from(
    json.decode(str)['items'].map((x) => EventsModel.fromJson(x)));

String eventsModelToJson(List<EventsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventsModel {
  EventsModel({
    required this.archived,
    required this.startDateTime,
    required this.draft,
    required this.rsvpLink,
    required this.featured,
    required this.location2,
    required this.category,
    required this.name,
    required this.description,
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
  DateTime startDateTime;
  bool draft;
  String rsvpLink;
  bool featured;
  String location2;
  String category;
  String name;
  String description;
  String slug;
  EventImage image;
  DateTime updatedOn;
  String updatedBy;
  DateTime createdOn;
  String createdBy;
  DateTime publishedOn;
  String publishedBy;
  String cid;
  String id;

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        archived: json["_archived"],
        startDateTime: DateTime.parse(json["event-date-and-time"]),
        draft: json["_draft"],
        rsvpLink: json["rsvp-link"] ?? '',
        featured: json["featured"],
        location2: json["location-2"] ?? '',
        category: json["category"] ?? 'None',
        name: json["name"],
        description: json["event-description"] ?? '',
        slug: json["slug"],
        image: EventImage.fromJson(json["event-image"]),
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
        "start-date-time": startDateTime.toIso8601String(),
        "_draft": draft,
        "rsvp-link": rsvpLink,
        "featured": featured,
        "location-2": location2,
        "category": category,
        "name": name,
        "description": description,
        "slug": slug,
        "image": image.toJson(),
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

class EventImage {
  EventImage({
    required this.fileId,
    required this.url,
    this.alt,
  });

  String fileId;
  String url;
  dynamic alt;

  factory EventImage.fromJson(Map<String, dynamic> json) => EventImage(
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

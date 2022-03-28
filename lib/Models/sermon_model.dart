// To parse this JSON data, do
//
//     final sermonsModel = sermonsModelFromJson(jsonString);

import 'dart:convert';

List<SermonsModel> sermonsModelFromJson(String str) => List<SermonsModel>.from(
    json.decode(str)['items'].map((x) => SermonsModel.fromJson(x)));

String sermonsModelToJson(List<SermonsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SermonsModel {
  SermonsModel({
    required this.dateOfSermon,
    required this.archived,
    required this.draft,
    //required this.preachers2,
    required this.name,
    required this.slug,
    required this.sermonSeries,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
    required this.publishedOn,
    required this.publishedBy,
    required this.partNumber,
    required this.videoEmbedd,
    required this.preacher,
    required this.cid,
    required this.id,
  });

  DateTime dateOfSermon;
  bool archived;
  bool draft;
  //String preachers2;
  String name;
  String slug;
  String sermonSeries;
  DateTime updatedOn;
  String updatedBy;
  DateTime createdOn;
  String createdBy;
  DateTime publishedOn;
  String publishedBy;
  int partNumber;
  VideoEmbedd videoEmbedd;
  String preacher;
  String cid;
  String id;

  factory SermonsModel.fromJson(Map<String, dynamic> json) => SermonsModel(
        dateOfSermon:
            DateTime.parse(json["date-of-sermon"] ?? '2022-03-12T01:23:42Z'),
        archived: json["_archived"],
        draft: json["_draft"],
        //preachers2: json["preachers-2"],
        name: json["name"],
        slug: json["slug"],
        sermonSeries: json["series"] ?? '',
        updatedOn: DateTime.parse(json["updated-on"]),
        updatedBy: json["updated-by"],
        createdOn: DateTime.parse(json["created-on"]),
        createdBy: json["created-by"],
        publishedOn: DateTime.parse(json["published-on"]),
        publishedBy: json["published-by"],
        partNumber: json["part-number"] ?? 0,
        videoEmbedd: VideoEmbedd.fromJson(json["video"]),
        preacher: json["preacher"] ?? '',
        cid: json["_cid"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "date-of-sermon": dateOfSermon.toIso8601String(),
        "_archived": archived,
        "_draft": draft,
        // "preachers-2": preachers2,
        "name": name,
        "slug": slug,
        "sermon-series": sermonSeries,
        "updated-on": updatedOn.toIso8601String(),
        "updated-by": updatedBy,
        "created-on": createdOn.toIso8601String(),
        "created-by": createdBy,
        "published-on": publishedOn.toIso8601String(),
        "published-by": publishedBy,
        "part-number": partNumber,
        "video-embedd": videoEmbedd.toJson(),
        "preacher": preacher,
        "_cid": cid,
        "_id": id,
      };
}

class VideoEmbedd {
  VideoEmbedd({
    required this.url,
    required this.metadata,
  });

  String url;
  Metadata metadata;

  factory VideoEmbedd.fromJson(Map<String, dynamic> json) => VideoEmbedd(
        url: json["url"],
        metadata: Metadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "metadata": metadata.toJson(),
      };
}

class Metadata {
  Metadata({
    required this.width,
    required this.height,
    required this.html,
    required this.aspectRatio,
    required this.title,
    required this.providerName,
    required this.type,
    required this.thumbnailUrl,
    required this.authorName,
  });

  int width;
  int height;
  String html;
  int aspectRatio;
  String title;
  String providerName;
  String type;
  String thumbnailUrl;
  String authorName;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        width: json["width"] ?? 0,
        height: json["height"] ?? 0,
        html: json["html"] ?? '',
        aspectRatio: json["aspectRatio"] ?? 0,
        title: json["title"] ?? '',
        providerName: json["provider_name"] ?? '',
        type: json["type"] ?? '',
        thumbnailUrl: json["thumbnail_url"] ?? '',
        authorName: json["author_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "html": html,
        "aspectRatio": aspectRatio,
        "title": title,
        "provider_name": providerName,
        "type": type,
        "thumbnail_url": thumbnailUrl,
        "author_name": authorName,
      };
}

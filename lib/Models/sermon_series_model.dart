// To parse this JSON data, do
//
//     final sermonSeriesModel = sermonSeriesModelFromJson(jsonString);

import 'dart:convert';

List<SermonSeriesModel> sermonSeriesModelFromJson(String str) => List<SermonSeriesModel>.from(json.decode(str)['items'].map((x) => SermonSeriesModel.fromJson(x)));

String sermonSeriesModelToJson(List<SermonSeriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SermonSeriesModel {
    SermonSeriesModel({
        required this.seriesStartDate,
        required this.archived,
        required this.draft,
        required this.currentSeries,
        required this.name,
        required this.slug,
        required this.seriesGraphic,
        required this.updatedOn,
        required this.updatedBy,
        required this.createdOn,
        required this.createdBy,
        required this.publishedOn,
        required this.publishedBy,
        required this.cid,
        required this.id,
    });

    DateTime seriesStartDate;
    bool archived;
    bool draft;
    bool currentSeries;
    String name;
    String slug;
    SeriesGraphic seriesGraphic;
    DateTime updatedOn;
    String updatedBy;
    DateTime createdOn;
    String createdBy;
    DateTime publishedOn;
    String publishedBy;
    String cid;
    String id;

    factory SermonSeriesModel.fromJson(Map<String, dynamic> json) => SermonSeriesModel(
        seriesStartDate: DateTime.parse(json["series-start-date"]),
        archived: json["_archived"],
        draft: json["_draft"],
        currentSeries: json["current-series"],
        name: json["name"],
        slug: json["slug"],
        seriesGraphic: SeriesGraphic.fromJson(json["series-graphic"]),
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
        "series-start-date": seriesStartDate.toIso8601String(),
        "_archived": archived,
        "_draft": draft,
        "current-series": currentSeries,
        "name": name,
        "slug": slug,
        "series-graphic": seriesGraphic.toJson(),
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

class SeriesGraphic {
    SeriesGraphic({
        required this.fileId,
        required this.url,
        required this.alt,
    });

    String fileId;
    String url;
    dynamic alt;

    factory SeriesGraphic.fromJson(Map<String, dynamic> json) => SeriesGraphic(
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

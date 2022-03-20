// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

List<HomePageModel> homePageModelFromJson(String str) =>
    List<HomePageModel>.from(
        json.decode(str).map((x) => HomePageModel.fromJson(x)));

String homePageModelToJson(List<HomePageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePageModel {
  HomePageModel({
    required this.name,
    required this.subtitle,
    required this.url,
  });

  String name;
  String subtitle;
  String url;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        name: json["name"],
        subtitle: json["subtitle"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subtitle": subtitle,
        "url": url,
      };
}

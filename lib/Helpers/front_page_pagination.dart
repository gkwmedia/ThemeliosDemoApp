import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phpc_v2/Models/front_page_model.dart';

import 'package:phpc_v2/globals.dart' as globals;

Future<List<FrontPageModel>> paginateFrontPageList(
    http.Response checkedResposne) async {
  List<FrontPageModel> allFrontPage = [];
  int totalItems = jsonDecode(checkedResposne.body)['total'];
  int offsetNum = totalItems ~/ 100;
  /*if (offsetNum == 0) {
    List<EventsModel> events = eventsModelFromJson(checkedResposne.body);
    return events;
  }*/ //else {
  for (int i = 0; i <= offsetNum; i++) {
    if (i == 0) {
      List<FrontPageModel> frontPageList =
          frontPageModelFromJson(checkedResposne.body);
      allFrontPage.addAll(frontPageList);
    } else {
      int offsetValue = i * 100;
      http.Response response = await http.get(
          Uri.parse(globals.eventsApiUrl + '?offset=$offsetValue'),
          headers: {
            "Authorization": globals.apiKey,
            "accept-version": "1.0.0",
          });
      List<FrontPageModel> frontPageList =
          frontPageModelFromJson(response.body);
      allFrontPage.addAll(frontPageList);
    }
  }
  return allFrontPage;
}

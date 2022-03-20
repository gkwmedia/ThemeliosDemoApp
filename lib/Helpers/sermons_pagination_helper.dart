import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phpc_v2/Models/sermon_model.dart';
import 'package:phpc_v2/globals.dart' as globals;

Future<List<SermonsModel>> paginateSermonsList(
    http.Response checkedResposne) async {
  List<SermonsModel> allSermons = [];
  int totalItems = jsonDecode(checkedResposne.body)['total'];
  int offsetNum = totalItems ~/ 100;
  /*if (offsetNum == 0) {
    List<EventsModel> events = eventsModelFromJson(checkedResposne.body);
    return events;
  }*/ //else {
  for (int i = 0; i <= offsetNum; i++) {
    if (i == 0) {
      List<SermonsModel> _sermon = sermonsModelFromJson(checkedResposne.body);

      allSermons.addAll(_sermon);
    } /*else {
      int offsetValue = i * 100;
      print((globals.sermonsApiUrl + '?offset=$offsetValue').toString());
      http.Response response = await http.get(
          Uri.parse(globals.sermonsApiUrl + '?offset=$offsetValue'),
          headers: {
            "Authorization": globals.apiKey,
            "accept-version": "1.0.0",
          });
      print(response.body);
      List<SermonsModel> _sermon = sermonsModelFromJson(response.body);
      print(_sermon);
      allSermons.addAll(_sermon);
    }*/
  }
  return allSermons;
}

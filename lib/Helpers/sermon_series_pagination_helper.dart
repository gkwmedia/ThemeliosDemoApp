import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phpc_v2/Models/sermon_series_model.dart';
import 'package:phpc_v2/globals.dart' as globals;

Future<List<SermonSeriesModel>> paginateSermonSeriesList(
    http.Response checkedResposne) async {
  List<SermonSeriesModel> allSeries = [];
  int totalItems = jsonDecode(checkedResposne.body)['total'];
  int offsetNum = totalItems ~/ 100;
  /*if (offsetNum == 0) {
    List<EventsModel> events = eventsModelFromJson(checkedResposne.body);
    return events;
  }*/ //else {
  for (int i = 0; i <= offsetNum; i++) {
    if (i == 0) {
      List<SermonSeriesModel> _sermonSeries =
          sermonSeriesModelFromJson(checkedResposne.body);
      allSeries.addAll(_sermonSeries);
    } else {
      int offsetValue = i * 100;
      http.Response response = await http.get(
          Uri.parse(globals.sermonSeriesApiUrl + '?offset=$offsetValue'),
          headers: {
            "Authorization": globals.apiKey,
            "accept-version": "1.0.0",
          });
      List<SermonSeriesModel> _sermonSeries =
          sermonSeriesModelFromJson(response.body);
      allSeries.addAll(_sermonSeries);
    }
  }
  return allSeries;
}

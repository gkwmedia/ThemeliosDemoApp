import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:phpc_v2/Helpers/api_helper.dart';
import 'package:phpc_v2/Helpers/events_pagination_helper.dart';
import 'package:phpc_v2/Helpers/sermon_series_pagination_helper.dart';
import 'package:phpc_v2/Helpers/sermons_pagination_helper.dart';
import 'package:phpc_v2/Models/bible_translation_model.dart';

import 'package:phpc_v2/Models/event_page_model.dart';
import 'package:phpc_v2/Models/preachers_model.dart';
import 'package:phpc_v2/Models/sermon_model.dart';
import 'package:phpc_v2/Models/sermon_series_model.dart';
import 'package:phpc_v2/Services/errors.dart';
import 'package:phpc_v2/globals.dart' as globals;

Future<List<EventsModel>> fetchEvents() async {
  try {
    final eventHTTPResponse = await http.get(
      Uri.parse(globals.eventsApiUrl),
      headers: {
        "Authorization": globals.apiKey,
        "accept-version": "1.0.0",
      },
    );
    http.Response _checkedResposne = ApiStatusCheck(eventHTTPResponse);
    //this line checks for pagination and returns the list
    List<EventsModel> events = await paginateEventsList(_checkedResposne);
    //This sorts the events by date
    events.sort((a, b) {
      var adate = a.startDateTime;
      var bdate = b.startDateTime;
      return adate.compareTo(bdate);
    });
    //This checks to make sure that the event occurs after today's date and
    events =
        events.where((i) => i.startDateTime.isAfter(DateTime.now())).toList();
    return events;
  } on SocketException catch (e) {
    throw NoInternetException(
        'No Internet Connection \n Please connect to the internet and try again');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

Future<List<SermonSeriesModel>> fetchSermonSeries() async {
  try {
    final sermonSeriesHTTPResponse = await http.get(
        Uri.parse(globals.sermonSeriesApiUrl),
        headers: {"Authorization": globals.apiKey, "accept-version": "1.0.0"});

    http.Response _checkedResponce = ApiStatusCheck(sermonSeriesHTTPResponse);

    List<SermonSeriesModel> sermonSeries =
        await paginateSermonSeriesList(_checkedResponce);

    sermonSeries.sort((b, a) {
      return a.seriesStartDate.compareTo(b.seriesStartDate);
    });
    return sermonSeries;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

Future<List<SermonsModel>> fetchSermons() async {
  try {
    final sermonsHTTPResponse = await http.get(Uri.parse(globals.sermonsApiUrl),
        headers: {"Authorization": globals.apiKey, "accept-version": "1.0.0"});

    http.Response _checkedResponse = ApiStatusCheck(sermonsHTTPResponse);
    List<SermonsModel> sermons = await paginateSermonsList(_checkedResponse);
    /*List<SermonsModel> filteredSermons =
        sermons.where((i) => i.sermonSeries == sermonSeriesID).toList();
    filteredSermons.sort((a, b) {
      return a.dateOfSermon.compareTo(b.dateOfSermon);
    });*/
    return sermons;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

Future<List<PreachersModel>> fetchPreachers() async {
  try {
    final preachersHTTPResponse = await http.get(
        Uri.parse(globals.preachersApiUrl),
        headers: {"Authorization": globals.apiKey, "accept-version": "1.0.0"});

    http.Response _checkedResposne = ApiStatusCheck(preachersHTTPResponse);
    List<PreachersModel> preachers =
        preachersModelFromJson(_checkedResposne.body);
    return preachers;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

Future<List<BibleTranslationModel>> fetchBibleTranslations() async {
  try {
    final bibleTranslationResponse = await http
        .get(Uri.parse('https://bible-go-api.rkeplin.com/v1/translations'));

    http.Response _checkedResposne = ApiStatusCheck(bibleTranslationResponse);

    List<BibleTranslationModel> bibleTranslations =
        bibleTranslationModelFromJson(_checkedResposne.body);
    return bibleTranslations;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

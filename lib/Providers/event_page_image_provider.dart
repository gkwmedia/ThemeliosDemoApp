import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Helpers/api_helper.dart';
import 'package:phpc_v2/Models/event_page_image_model.dart';
import 'package:http/http.dart' as http;
import 'package:phpc_v2/Services/errors.dart';
import 'package:phpc_v2/globals.dart' as globals;

final eventPageImageProvider =
    FutureProvider<List<EventPageImageModel>>((ref) async {
  return fetchEventPageImage();
});

Future<List<EventPageImageModel>> fetchEventPageImage() async {
  try {
    final _httpResponse = await http.get(
        Uri.parse(globals.eventPageImageApiUrl),
        headers: {"Authorization": globals.apiKey, "accept-version": "1.0.0"});

    http.Response _checkedResponce = ApiStatusCheck(_httpResponse);

    List<EventPageImageModel> eventPageImage =
        eventPageImageModelFromJson(_checkedResponce.body);

    return eventPageImage;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

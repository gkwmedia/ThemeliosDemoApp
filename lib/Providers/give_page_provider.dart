import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:phpc_v2/Helpers/api_helper.dart';
import 'package:phpc_v2/globals.dart' as globals;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Models/give_model.dart';
import 'package:phpc_v2/Services/errors.dart';

final givePageProvider = FutureProvider<List<GivePageModel>>((ref) async {
  return fetchGivePage();
});

Future<List<GivePageModel>> fetchGivePage() async {
  try {
    final givePageHTTPResponse = await http.get(Uri.parse(globals.giveApiUrl),
        headers: {"Authorization": globals.apiKey, "accept-version": "1.0.0"});

    http.Response _checkedResponce = ApiStatusCheck(givePageHTTPResponse);

    List<GivePageModel> givePageList =
        givePageModelFromJson(_checkedResponce.body);

    return givePageList;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

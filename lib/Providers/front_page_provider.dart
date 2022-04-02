import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Helpers/api_helper.dart';
import 'package:phpc_v2/Helpers/front_page_pagination.dart';
import 'package:phpc_v2/Models/front_page_model.dart';
import 'package:http/http.dart' as http;
import 'package:phpc_v2/Services/errors.dart';
import 'package:phpc_v2/globals.dart' as globals;

final frontPageProvider = FutureProvider<List<FrontPageModel>>((ref) async {
  return fetchFrontPage();
});

Future<List<FrontPageModel>> fetchFrontPage() async {
  try {
    final frontPageHTTPResponse = await http.get(
        Uri.parse(globals.frontPageApiUrl),
        headers: {"Authorization": globals.apiKey, "accept-version": "1.0.0"});

    http.Response _checkedResponce = ApiStatusCheck(frontPageHTTPResponse);

    List<FrontPageModel> frontPageList =
        await paginateFrontPageList(_checkedResponce);

    frontPageList.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return frontPageList;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Helpers/api_helper.dart';
import 'package:phpc_v2/Models/bible_reader_model.dart';
import 'package:http/http.dart' as http;
import 'package:phpc_v2/Providers/bible_translation_provider.dart';
import 'package:phpc_v2/Providers/book_num_provider.dart';
import 'package:phpc_v2/Providers/chaper_num_provider.dart';
import 'package:phpc_v2/Services/errors.dart';
import 'package:phpc_v2/globals.dart' as globals;

final bibleVersesProvider = FutureProvider<List<BibleReaderModel>>((ref) async {
  final translation = ref.watch(bibleTranslationAbbrviationProvider);
  final bookNum = ref.watch(bookNumProvider);
  final chapterNum = ref.watch(chapterNumProvider);
  return fetchTest(bookNum.toString(), chapterNum.toString(), translation);
});

Future<List<BibleReaderModel>> fetchTest(
    String bookNum, String chapterNum, String translation) async {
  try {
    final bibleVerseResponse = await http.get(Uri.parse(
        '${globals.bibleBaseURL}books/$bookNum/chapters/$chapterNum?translation=$translation'));

    http.Response _checkedResponse = ApiStatusCheck(bibleVerseResponse);
    List<BibleReaderModel> bibleVerses =
        bibleReaderModelFromJson(_checkedResponse.body);
    return bibleVerses;
  } on SocketException catch (e) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  }
}

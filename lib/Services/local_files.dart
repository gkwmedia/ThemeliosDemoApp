import 'package:flutter/services.dart';
import 'package:phpc_v2/Models/bible_book_chapter_model.dart';

Future<List<BibleChapterBookModel>> fetchBibleBookChapter() async {
  final bibleBookChapterResponce =
      await rootBundle.loadString('assests/JSON/BibleNamesandChapters.json');
  final List<BibleChapterBookModel> bibleBookChapterItem =
      bibleChapterBookModelFromJson(bibleBookChapterResponce);
  return bibleBookChapterItem;
}

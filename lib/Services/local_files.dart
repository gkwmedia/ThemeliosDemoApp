import 'package:flutter/services.dart';
import 'package:phpc_v2/Models/bible_book_chapter_model.dart';
import 'package:phpc_v2/Models/home_page_model.dart';

Future<List<HomePageModel>> fetchHomePage() async {
  final homePageResponce =
      await rootBundle.loadString('assests/JSON/HomePage.json');
  final List<HomePageModel> homePageItem =
      homePageModelFromJson(homePageResponce);
  return homePageItem;
}

Future<List<BibleChapterBookModel>> fetchBibleBookChapter() async {
  final bibleBookChapterResponce =
      await rootBundle.loadString('assests/JSON/BibleNamesandChapters.json');
  final List<BibleChapterBookModel> bibleBookChapterItem =
      bibleChapterBookModelFromJson(bibleBookChapterResponce);
  return bibleBookChapterItem;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Models/bible_book_chapter_model.dart';
import 'package:phpc_v2/Services/local_files.dart';

final BibleChapterBookProvider =
    FutureProvider.autoDispose<List<BibleChapterBookModel>>((ref) async {
  ref.maintainState = true;
  return fetchBibleBookChapter();
});

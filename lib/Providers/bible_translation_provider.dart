import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Models/bible_translation_model.dart';
import 'package:phpc_v2/Services/api.dart';

final bibleTranslationProvider = StateProvider<int>((ref) {
  return 0;
});

final bibleTranslationFutureProvider =
    FutureProvider<List<BibleTranslationModel>>((ref) {
  return fetchBibleTranslations();
});

final bibleTranslationAbbrviationProvider =
    StateProvider<String>((ref) => 'ASV');

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Models/bible_reader_model.dart';
import 'package:phpc_v2/Providers/bible_chapter_book_provider.dart';
import 'package:phpc_v2/Providers/bible_reader_provider.dart';
import 'package:phpc_v2/Providers/bible_translation_provider.dart';
import 'package:phpc_v2/Services/errors.dart';

class BibleReaderRP extends ConsumerWidget {
  const BibleReaderRP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InlineSpan> spans = [];

    AsyncValue<List<BibleReaderModel>> bibleVerses =
        ref.watch(bibleVersesProvider);

    return bibleVerses.when(
        loading: () => Container(),
        error: (err, Stack) => SafeArea(
              child: ErrorTypeCheck(ref, err),
            ),
        data: (bibleVerses) {
          for (int i = 0; i < bibleVerses.length; i++) {
            var item = bibleVerses[i];
            spans.add(
              WidgetSpan(
                  child: Transform.translate(
                offset: const Offset(0, -4),
                child: Text(
                  item.verseId.toString() + ' ',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              )),
            );
            spans.add(
              TextSpan(
                text: item.verse + ' ',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text.rich(TextSpan(children: spans, style: TextStyle())),
            ),
          );
        });
  }

  Widget ErrorTypeCheck(WidgetRef ref, err) {
    if (err is NoInternetException) {
      NoInternetException noInternetException = err as NoInternetException;
      return showError(ref, noInternetException.message);
    }
    if (err is NoServiceFoundException) {
      NoServiceFoundException noServiceFoundException =
          err as NoServiceFoundException;
      return showError(ref, noServiceFoundException.message);
    }
    if (err is InvalidFormatException) {
      InvalidFormatException invalidFormatException =
          err as InvalidFormatException;
      return showError(ref, invalidFormatException.message);
    }
    if (err is FetchDataException) {
      AppException fetchDataException = err as AppException;
      return showError(ref, fetchDataException.toString());
    }
    if (err is BadRequestException) {
      AppException badRequestException = err as AppException;
      return showError(ref, badRequestException.toString());
    }
    if (err is UnauthorisedException) {
      AppException unauthorisedException = err as AppException;
      return showError(ref, unauthorisedException.toString());
    }
    if (err is InvalidInputException) {
      AppException invalidInputException = err as AppException;
      return showError(ref, invalidInputException.toString());
    }
    UnknownException unknownException = err as UnknownException;
    return showError(ref, unknownException.message);
  }

  Widget showError(WidgetRef ref, String message) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
            onPressed: () {
              ref.refresh(BibleChapterBookProvider);
              ref.refresh(bibleTranslationFutureProvider);
              ref.refresh(bibleVersesProvider);
            },
            child: Text('Try Again'))
      ],
    ));
  }
}

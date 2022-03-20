import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phpc_v2/Componets/bible_reader.dart';
import 'package:phpc_v2/Models/bible_book_chapter_model.dart';
import 'package:phpc_v2/Models/bible_translation_model.dart';
import 'package:phpc_v2/Providers/bible_book_name.dart';
import 'package:phpc_v2/Providers/bible_chapter_book_provider.dart';
import 'package:phpc_v2/Providers/bible_translation_provider.dart';
import 'package:phpc_v2/Providers/book_num_provider.dart';
import 'package:phpc_v2/Providers/chaper_num_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiblePageRP extends ConsumerStatefulWidget {
  const BiblePageRP({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BiblePageRPState();
}

class _BiblePageRPState extends ConsumerState<BiblePageRP> {
  List<InlineSpan> spans = [];

  @override
  void initState() {
    super.initState();
    fetchBibleSaveState();
  }

  fetchBibleSaveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _savedBookName = ((prefs.getString('savedBookName') ?? 'Genesis'));
    ref.watch(bookNameProvider.state).state = _savedBookName;
    int _savedBookNum = ((prefs.getInt('savedBookNum') ?? 1));
    ref.watch(bookNumProvider.state).state = _savedBookNum;
    int _savedChapterNum = ((prefs.getInt('savedChapterNum') ?? 1));
    ref.watch(chapterNumProvider.state).state = _savedChapterNum;
    String _savedTranslation = ((prefs.getString('savedTranslation') ?? 'NIV'));
    ref.watch(bibleTranslationAbbrviationProvider.state).state =
        _savedTranslation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        BibleAppBarRP(
          context,
          ref,
        ),
        const SliverToBoxAdapter(
          child: BibleReaderRP(),
        )
      ],
    ));
  }
}

Widget BibleAppBarRP(context, WidgetRef ref) {
  final safeHeight = MediaQuery.of(context).padding.top +
      MediaQuery.of(context).padding.bottom;
  final bookName = ref.watch(bookNameProvider);
  final chapterNum = ref.watch(chapterNumProvider);
  final translation = ref.watch(bibleTranslationProvider);
  AsyncValue<List<BibleChapterBookModel>> bibleBookChapter =
      ref.watch(BibleChapterBookProvider);

  AsyncValue<List<BibleTranslationModel>> translationList =
      ref.watch(bibleTranslationFutureProvider);
  return bibleBookChapter.when(
    loading: () => SliverToBoxAdapter(),
    error: (error, stackTrace) =>
        SliverToBoxAdapter(child: SafeArea(child: Text('Error $error'))),
    data: (bibleBookChapterList) {
      return translationList.when(
        loading: () => SliverToBoxAdapter(
          child: Container(),
        ),
        error: (error, stackTrace) => const SliverToBoxAdapter(),
        data: (translationList) {
          return SliverAppBar(
            centerTitle: true,
            floating: true,
            leading: IconButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  int bookIndex = bibleBookChapterList.indexWhere((e) =>
                      e.bookName == ref.read(bookNameProvider.state).state);
                  if (ref.read(chapterNumProvider.state).state == 1 &&
                      ref.read(bookNumProvider.state).state == 1) return;
                  if (ref.read(chapterNumProvider.state).state == 1) {
                    ref.read(bookNameProvider.state).state =
                        bibleBookChapterList[bookIndex - 1].bookName;
                    prefs.setString('savedBookName',
                        bibleBookChapterList[bookIndex - 1].bookName);
                    ref.read(bookNumProvider.state).state--;
                    prefs.setInt(
                        'savedBookNum', ref.read(bookNumProvider.state).state);
                    ref.read(chapterNumProvider.state).state =
                        (bibleBookChapterList[bookIndex - 1].totalChapters);
                    prefs.setInt('savedChapterNum',
                        bibleBookChapterList[bookIndex - 1].totalChapters);
                  } else {
                    ref.read(chapterNumProvider.state).state--;
                    prefs.setInt('savedChapterNum',
                        ref.read(chapterNumProvider.state).state);
                  }
                },
                icon: FaIcon(FontAwesomeIcons.chevronLeft)),
            actions: [
              IconButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int bookIndex = bibleBookChapterList.indexWhere((e) =>
                        e.bookName == ref.read(bookNameProvider.state).state);
                    if (ref.read(chapterNumProvider.state).state ==
                            bibleBookChapterList[bookIndex].totalChapters &&
                        ref.read(bookNumProvider.state).state == 66) return;
                    if (ref.read(chapterNumProvider.state).state ==
                        bibleBookChapterList[bookIndex].totalChapters) {
                      ref.read(bookNumProvider.state).state++;
                      prefs.setInt('savedBookNum', ref.read(bookNumProvider));
                      ref.read(chapterNumProvider.state).state = 1;
                      prefs.setInt('savedChapterNum', 1);
                      ref.read(bookNameProvider.state).state =
                          bibleBookChapterList[bookIndex + 1].bookName;
                      prefs.setString('savedBookNum',
                          bibleBookChapterList[bookIndex + 1].bookName);
                    } else {
                      ref.read(chapterNumProvider.state).state++;
                      prefs.setInt('savedChapterNum',
                          ref.read(chapterNumProvider.state).state);
                    }
                  },
                  icon: const FaIcon(FontAwesomeIcons.chevronRight)),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => bookChapterModal(
                      context, safeHeight, bibleBookChapterList, ref),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(10))),
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          '$bookName $chapterNum',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () => translationModal(
                      context, ref, safeHeight, translationList),
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          ref
                              .watch(bibleTranslationAbbrviationProvider.state)
                              .state,
                          //translationList[translation].abbreviation,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void bookChapterModal(context, safeHeight,
    List<BibleChapterBookModel> BibleBookChapter, WidgetRef ref) {
  showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height - safeHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      icon: const FaIcon(FontAwesomeIcons.chevronDown)),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: ListView.builder(
                      itemCount: BibleBookChapter.length,
                      itemBuilder: (context, index) {
                        return BibleBookChapterListTile(
                          context,
                          ref,
                          BibleBookChapter[index],
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget BibleBookChapterListTile(BuildContext context, WidgetRef ref,
    BibleChapterBookModel bibleBookChaper) {
  return ExpansionTile(
    title: Text(bibleBookChaper.bookName),
    children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for (int i = 1; i <= bibleBookChaper.totalChapters; i++)
                chapterGridItem(context, ref, i, bibleBookChaper)
            ],
          )),
    ],
  );
}

Widget chapterGridItem(BuildContext context, WidgetRef ref, int chapters,
    BibleChapterBookModel bibleBookChapter) {
  return InkWell(
    child: Text(chapters.toString()),
    onTap: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      ref.read(bookNameProvider.state).state = bibleBookChapter.bookName;
      prefs.setString('savedBookName', bibleBookChapter.bookName);
      ref.read(bookNumProvider.state).state = bibleBookChapter.bookId;
      prefs.setInt('savedBookNum', bibleBookChapter.bookId);
      ref.read(chapterNumProvider.state).state = chapters;
      prefs.setInt('savedChapterNum', chapters);
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
}

void translationModal(
    context, ref, safeHeight, List<BibleTranslationModel> bibleTranslations) {
  showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height - safeHeight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true).pop(),
                        icon: const FaIcon(FontAwesomeIcons.chevronDown)),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bibleTranslations.length,
                    itemBuilder: (context, index) {
                      return TranslationTile(
                        context,
                        ref,
                        bibleTranslations,
                        bibleTranslations[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget TranslationTile(
    BuildContext context,
    WidgetRef ref,
    List<BibleTranslationModel> bibleTranslations,
    BibleTranslationModel bibleTranslationItem) {
  return ListTile(
    leading: Text(bibleTranslationItem.abbreviation),
    title: Text(bibleTranslationItem.version),
    onTap: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //ref.read(bibleTranslationProvider.state).state = bibleTranslations
      //  .indexWhere((element) => element.id == bibleTranslationItem.id);
      ref.read(bibleTranslationAbbrviationProvider.state).state =
          bibleTranslationItem.abbreviation;
      prefs.setString('savedTranslation', bibleTranslationItem.abbreviation);
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phpc_v2/Models/give_model.dart';
import 'package:phpc_v2/Providers/give_page_provider.dart';
import 'package:phpc_v2/Views/Webview.dart';
import 'package:phpc_v2/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

class GivePage extends ConsumerStatefulWidget {
  const GivePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GivePageState();
}

class _GivePageState extends ConsumerState<GivePage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<GivePageModel>> givePage = ref.watch(givePageProvider);

    return givePage.when(
        error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        data: (givePage) {
          GivePageModel givePageItem = givePage[0];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Giving'),
            ),
            body: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: givePageItem.givingImage.url,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        givePageItem.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          givePageItem.paragraph,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => launch(globals.givingURL,
                                  forceSafariVC: false),
                              child: const Text('Give Online'),
                            ),
                            if (givePageItem.commitLink != "")
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return WebViewStack(url: globals.commitURL);
                                  }));
                                },
                                child: const Text('Commit 2022'),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

class GivingPage extends StatefulWidget {
  const GivingPage({Key? key}) : super(key: key);

  @override
  State<GivingPage> createState() => _GivingPageState();
}

class _GivingPageState extends State<GivingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giving'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/GivingImage.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Text(
                  globals.givingTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    globals.givingBody,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            launch(globals.givingURL, forceSafariVC: false),
                        child: const Text('Give Online'),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.of(context)
                      //         .push(MaterialPageRoute(builder: (context) {
                      //       return WebViewStack(url: globals.commitURL);
                      //     }));
                      //   },
                      //   child: const Text('Commit 2022'),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

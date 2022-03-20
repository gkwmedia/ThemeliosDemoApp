import 'package:flutter/material.dart';
import 'package:phpc_v2/Theme/material_color.dart';
import 'package:phpc_v2/Views/Webview.dart';
import 'package:phpc_v2/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

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
                const Text(
                  'Thank you for supporting PHPC!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'Your support allows us to transform lives helping all ages at PHPC fully experience the love of God, feeding, and clothing our neighbors in Dallas, and lifting people around the globe out of poverty. With your generosity, we can continue growing, innovating, and sharing Christ\'s, life-changing love. Just imagine the impact you can have!',
                    style: TextStyle(fontSize: 16),
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
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
  }
}

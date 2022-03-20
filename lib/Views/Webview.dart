import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.url, Key? key}) : super(key: key);

  final String url;

  @override
  _WebViewStackState createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            zoomEnabled: false,
            onPageStarted: (url) {
              setState(
                () {
                  loadingPercentage = 0;
                },
              );
            },
            onProgress: (progress) {
              setState(
                () {
                  loadingPercentage = progress;
                },
              );
            },
          ),
          if (loadingPercentage < 100)
            Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}

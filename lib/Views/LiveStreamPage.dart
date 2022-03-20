import 'package:flutter/material.dart';
import 'package:phpc_v2/Views/Webview.dart';
import 'package:phpc_v2/globals.dart' as globals;

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({Key? key}) : super(key: key);

  @override
  _LiveStreamPageState createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: WebViewStack(
        url: globals.livestreamShareURL,
      ),
    );
  }
}

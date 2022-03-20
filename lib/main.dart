import 'package:flutter/material.dart';
import 'package:phpc_v2/Theme/material_color.dart';
import 'package:phpc_v2/Views/Navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:phpc_v2/globals.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: globals.appTitle,
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const ProviderScope(child: PageNavigation()),
    );
  }
}

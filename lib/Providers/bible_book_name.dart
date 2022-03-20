import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookNameProvider = StateProvider<String>((ref) {
  return 'Genesis';
});

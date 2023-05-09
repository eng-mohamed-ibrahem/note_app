import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../helper/shared_perferences_helper.dart';

final themeModeProvider = StateProvider((ref) {
  if (!SharedHelper.accessShared.containsKey('dark_theme')) {
    return ThemeMode.light;
  } else {
    if (SharedHelper.accessShared.getBool('dark_theme')!) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
});

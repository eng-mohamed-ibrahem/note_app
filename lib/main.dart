import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/controller/color_controller/color_note_controller.dart';
import 'package:note_app/controller/helper/shared_perferences_helper.dart';
import 'package:note_app/root/root_app.dart';

void main(List<String> args) {
  // initialize sharedpreferences
  WidgetsFlutterBinding.ensureInitialized();
  SharedHelper.init();
  ColorController.init();

  runApp(const ProviderScope(child: RootApp()));
}

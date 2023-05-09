import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences _accessShared;

  static Future init() async {
    _accessShared = await SharedPreferences.getInstance();
    log('initialized');
  }

  static SharedPreferences get accessShared => _accessShared;
}

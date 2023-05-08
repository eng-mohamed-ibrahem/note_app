import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences _accessShared;

  static init() async {
    _accessShared = await SharedPreferences.getInstance();
  }

  static SharedPreferences get accessShared => _accessShared;
}

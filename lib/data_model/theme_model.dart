import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';
import 'package:flutter_app/sqflite_model/sqlfite_config.dart';

class ThemeModel with ChangeNotifier {
  AppThemeMode _appThemeMode = AppThemeMode.defaultMode;
  Color _themeColor;
  Color _pageBackgroundColor1;
  Color _pageBackgroundColor2;
  Color _fontColor1;
  Color _fontColor2;

  Color get themeColor => _themeColor;

  Color get pageBackgroundColor1 => _pageBackgroundColor1;

  Color get pageBackgroundColor2 => _pageBackgroundColor2;

  Color get fontColor1 => _fontColor1;

  Color get fontColor2 => _fontColor2;

  AppThemeMode get appThemeMode => _appThemeMode;

  void init(String themeMode) {
    switch (themeMode) {
      case "default":
        _switchDefaultMode();
        break;
      case "night":
        _switchNightMode();
        break;
      default:
        _switchDefaultMode();
    }
  }

  ///切换黑夜模式
  Future<void> switchNightMode() async {
    List<Map<String, dynamic>> queryResult = await BaseSqflite.db
        .query(CONFIG_TABLE_NAME, where: 'config_key = \'theme_mode\'');
    if (queryResult.length == 0) {
      await BaseSqflite.db.insert(CONFIG_TABLE_NAME,
          {'config_key': 'theme_mode', 'config_value': 'night'});
    } else {
      await BaseSqflite.db.update(CONFIG_TABLE_NAME, {'config_value': 'night'},
          where: 'config_key = \'theme_mode\'');
    }
    print(queryResult);
    _switchNightMode();
    notifyListeners();
  }

  ///切换默认模式
  Future<void> switchDefaultMode() async {
    List<Map<String, dynamic>> queryResult = await BaseSqflite.db
        .query(CONFIG_TABLE_NAME, where: 'config_key = \'theme_mode\'');
    if (queryResult.length == 0) {
      await BaseSqflite.db.insert(CONFIG_TABLE_NAME,
          {'config_key': 'theme_mode', 'config_value': 'default'});
    } else {
      await BaseSqflite.db.update(
          CONFIG_TABLE_NAME, {'config_value': 'default'},
          where: 'config_key = \'theme_mode\'');
    }
    _switchDefaultMode();
    notifyListeners();
  }

  void _switchNightMode() {
    _appThemeMode = AppThemeMode.nightMode;
    _themeColor = Colors.grey;
    _pageBackgroundColor1 = Color(0xff636e72);
    _pageBackgroundColor2 = Color(0xff2d3436);
    _fontColor1 = Color(0xffb2bec3);
    _fontColor2 = Color(0xff636e72);
  }

  void _switchDefaultMode() {
    _appThemeMode = AppThemeMode.defaultMode;
    _themeColor = Colors.orange;
    _pageBackgroundColor1 = Color.fromRGBO(250, 250, 250, 1.0);
    _pageBackgroundColor2 = Colors.white;
    _fontColor1 = Color(0xff2d3436);
    _fontColor2 = Color(0xff636e72);
  }
}

enum AppThemeMode {
  defaultMode,
  nightMode,
}

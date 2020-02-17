import 'package:fluttertoast/fluttertoast.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/sqflite_model/base_sqflite.dart';
import 'package:ganglong_shop_app/sqflite_model/sqlfite_config.dart';

class ThemeModel with ChangeNotifier {
  AppThemeMode _appThemeMode = AppThemeMode.defaultMode;
  bool _appThemeModeFollowingSystem;
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

  bool get appThemeModeFollowingSystem => _appThemeModeFollowingSystem;

  AppThemeMode get appThemeMode => _appThemeMode;

  void init(
      {@required String themeMode, @required String themeModeFollowingSystem}) {
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

    switch (themeModeFollowingSystem) {
      case "1":
        _appThemeModeFollowingSystem = true;
        break;
      case "0":
        _appThemeModeFollowingSystem = false;
        break;
      default:
        _appThemeModeFollowingSystem = true;
    }
  }

  ///关闭跟随系统
  Future<void> offFollowingSystem() async {
    //修改数据库
    await BaseSqflite.updateOnly(
        key: 'theme_mode_following_system', value: '0');
    _appThemeModeFollowingSystem = false;
    notifyListeners();
  }

  ///开启跟随系统
  Future<void> onFollowingSystem() async {
    //修改数据库
    await BaseSqflite.updateOnly(
        key: 'theme_mode_following_system', value: '1');
    _appThemeModeFollowingSystem = true;
    Fluttertoast.showToast(msg: "该设置将在软件重启后生效"); //短提示
    notifyListeners();
  }

  ///切换黑夜模式
  Future<void> switchNightMode() async {
    await BaseSqflite.updateOnly(key: 'theme_mode', value: 'night');
    _switchNightMode();
    notifyListeners();
  }

  ///切换默认模式
  Future<void> switchDefaultMode() async {
    await BaseSqflite.updateOnly(key: 'theme_mode', value: 'default');
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

import 'package:flutter_app/common_import.dart';

class MainPageModel extends ChangeNotifier {
  final Color _defaultColor = Color(0xff636e72);
  final double _defaultFontSize = SO_SMALL_FONT_SIZE;
  int _currentIndex;
  PageController _controllerPage;

  /* final _activeColor = Colors.orange;*/

  Color get defaultColor => _defaultColor;

  double get defaultFontSize => _defaultFontSize;

  int get currentIndex => _currentIndex;

  PageController get controllerPage => _controllerPage;

  MainPageModel({@required int currentIndex}) {
    this._currentIndex = currentIndex;
    _controllerPage = PageController(
      initialPage: currentIndex,
    );
  }

  bottomNavigationBarClick(int index) {
    _controllerPage.jumpToPage(index);
    _currentIndex = index;
    notifyListeners();
  }
}

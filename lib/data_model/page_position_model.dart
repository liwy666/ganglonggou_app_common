import 'package:flutter_app/common_import.dart';

class PagePositionModel extends ChangeNotifier {
  double pageHeightPosition = 0; //页面位置
  final double monitoringPageHeightPositionMaxPosition;
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  final Widget _floatingActionButtonChild = Icon(Icons.arrow_upward,size: 15,);

  ScrollController get controller => _controller;

  Widget get floatingActionButtonChild => _floatingActionButtonChild;

  PagePositionModel({this.monitoringPageHeightPositionMaxPosition = 0}) {
    _controller.addListener(() {
      if (_controller.offset < 1000 && showToTopBtn) {
        showToTopBtn = false;
        notifyListeners();
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        showToTopBtn = true;
        notifyListeners();
      }
      if (_controller.offset < monitoringPageHeightPositionMaxPosition) {
        pageHeightPosition = _controller.offset;
        notifyListeners();
      }
    });
  }

  void toTop() {
    controller.animateTo(0.0,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

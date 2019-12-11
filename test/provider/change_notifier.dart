import 'package:flutter_app/common_import.dart';

import 'inherited_provider.dart';

class ChangeNotifier implements Listenable {
  @override
  void addListener(listener) {
    // TODO: implement addListener
    //添加监听器
  }



  @override
  void removeListener(listener) {
    // TODO: implement removeListener
    //移除监听器
  }
  void notifyListeners() {
    //通知所有监听器，触发监听器回调
  }

}

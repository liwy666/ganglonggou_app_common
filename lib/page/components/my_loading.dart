import 'package:ganglong_shop_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

Set dict = Set();
bool loadingStatus = false;

class MyLoading {
  static BuildContext loadContext;

  /*开启弹窗*/
  static void eject() {
    showDialog(
        context: loadContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              elevation: 0,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              child: Container(
                width: ScreenUtil().setWidth(150),
                height: ScreenUtil().setWidth(150),
                child: LoadingIndicator(
                  indicatorType: Indicator.ballScaleMultiple,
                  color: Colors.orange,
                ),
              ),
            ),
          );
        });
  }

  /*关闭弹窗*/
  static void shut() {
    Navigator.of(loadContext, rootNavigator: true).pop();
  }
}

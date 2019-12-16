import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/page/goods_page/goods_page.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyDialog {
  /*底部弹出窗*/
  showBottomDialog<T>(
      {@required BuildContext context,
      @required Widget child,
      String title = ""}) {
    return showBottomSheet<T>(
      context: context,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      builder: (BuildContext context) {
        final _themeModel = Provider.of<ThemeModel>(context);
        return Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: _themeModel.pageBackgroundColor2,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, -0.2),
                      )
                    ],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container()
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: COMMON_FONT_SIZE),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  /*确认弹出窗*/
  showConfirmDialog(
      {@required BuildContext context,
      @required String title,
      String confirmButtonText = "确认",
      String cancelButtonText = "取消",
      @required Function clickFun}) {
    return YYDialog().build(context)
      ..width = 240
      ..borderRadius = 4.0
      ..barrierDismissible = false
      ..text(
        padding: EdgeInsets.all(18.0),
        text: title,
        color: Colors.grey[700],
        fontSize: ScreenUtil().setWidth(24),
      )
      ..doubleButton(
        padding: EdgeInsets.only(top: 10.0),
        gravity: Gravity.right,
        text1: cancelButtonText,
        color1: Colors.black54,
        fontSize1: ScreenUtil().setWidth(24),
        text2: confirmButtonText,
        color2: Colors.blue,
        fontSize2: ScreenUtil().setWidth(24),
        onTap2: () {
          clickFun();
        },
      )
      ..show();
  }
}

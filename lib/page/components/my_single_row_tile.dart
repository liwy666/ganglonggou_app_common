import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MySingleRowTile extends StatelessWidget {
  final Widget child;
  final IconData iconStyle;
  final Widget rightIcon;
  final Function onTapFunction;
  final double marginTop;
  final double marginBottom;

  const MySingleRowTile(
      {Key key,
      @required this.child,
      @required this.onTapFunction,
      this.iconStyle = Icons.navigate_next,
      this.rightIcon,
      this.marginTop = 0,
      this.marginBottom = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _themeModel = Provider.of<ThemeModel>(context);

    // TODO: implement build
    return GestureDetector(
      child: Container(
        color:_themeModel.pageBackgroundColor2,
        margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setWidth(15)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                rightIcon == null
                    ? Container()
                    : Container(
                        child: rightIcon,
                        margin: EdgeInsets.only(right: 8.0),
                      ),
                DefaultTextStyle(
                 style: TextStyle(color: _themeModel.fontColor1,fontSize: COMMON_FONT_SIZE),
                  child: child,
                )
              ],
            ),
            Icon(
              iconStyle,
              color: _themeModel.fontColor2,
            ),
          ],
        ),
      ),
      onTap: () {
        onTapFunction();
      },
    );
  }
}

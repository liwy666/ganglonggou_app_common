import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyOrderList extends StatelessWidget {
  final List<MyOderListItem> children;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const MyOrderList(
      {Key key,
      @required this.children,
      this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      this.margin = const EdgeInsets.only(top: 15)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      margin: margin,
      padding: padding,
      color: _themeModel.pageBackgroundColor2,
      child: Column(
        children: children,
      ),
    );
  }
}

class MyOderListItem extends StatelessWidget {
  final String label;
  final Widget value;

  const MyOderListItem({Key key, @required this.label, @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(18)),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
                color: _themeModel.fontColor1, fontSize: SMALL_FONT_SIZE),
          ),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(60)),
            child: DefaultTextStyle(
              style: TextStyle(
                  color: _themeModel.fontColor2, fontSize: SMALL_FONT_SIZE),
              child: value,
            ),
          ),
        ],
      ),
    );
  }
}

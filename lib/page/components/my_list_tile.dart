import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/page/goods_page/components/goods_sku_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'my_dialog.dart';

// ignore: must_be_immutable
class MyListTile extends StatelessWidget {
  final Widget titleWidget;
  final Widget subtitleWidget;
  Widget iconWidget;
  final Function onTapFunction;
  final bool hideIconWidget;

  MyListTile(
      {@required this.titleWidget,
      @required this.subtitleWidget,
      @required this.onTapFunction,
      this.iconWidget,
      this.hideIconWidget = false}) {
    if (this.iconWidget == null && !this.hideIconWidget) {
      this.iconWidget = Icon(Icons.more_horiz);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.1))),
          child: DefaultTextStyle(
            child: titleWidget,
            style: TextStyle(
                letterSpacing: 2,
                fontSize: COMMON_FONT_SIZE,
                fontWeight: FontWeight.w500,
                color: _themeModel.fontColor1),
          ),
        ),
        subtitle: DefaultTextStyle(
          child: subtitleWidget,
          style: TextStyle(
              letterSpacing: 2,
              color: _themeModel.fontColor2,
              fontSize: SMALL_FONT_SIZE),
        ),
        trailing: this.iconWidget,
        dense: true,
        onTap: () {
          onTapFunction();
        },
      ),
      color: _themeModel.pageBackgroundColor2,
    );
  }
}

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyBottomButton extends StatelessWidget {
  final Widget child;

  const MyBottomButton({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 5),
      height: ScreenUtil().setWidth(MY_BOTTOM_BUTTON_HEIGHT),
      width: MediaQuery.of(context).size.width,
      //padding: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color:_themeModel.pageBackgroundColor2,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.0, -0.2),
          )
        ],
      ),
      child: child,
    );
  }
}

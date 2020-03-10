import 'package:ganglong_shop_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartsPageHead extends StatelessWidget {
  final double containerPadding;

  const CartsPageHead({@required this.containerPadding});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setWidth(250),
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.only(top: this.containerPadding, left: 15),
      child: Text(
        "购物车",
        style: TextStyle(
            color: Colors.white,
            fontSize: SO_LARGE_FONT_SIZE,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

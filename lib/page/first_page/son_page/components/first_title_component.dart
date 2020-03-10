import 'package:ganglong_shop_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstTitleComponent extends StatelessWidget {
  final Color textColor;
  final String firstText;
  final String lastText;
  final double fontSize = 32;
  final double marginTop;
  final double marginBottom;

  FirstTitleComponent(
      {Key key,
      @required this.textColor,
      @required this.firstText,
      @required this.lastText,
      this.marginTop = 5.0,
      this.marginBottom = 5.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                firstText,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(fontSize),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                lastText,
                style: TextStyle(
                    color: textColor,
                    fontSize: ScreenUtil.getInstance().setSp(fontSize),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

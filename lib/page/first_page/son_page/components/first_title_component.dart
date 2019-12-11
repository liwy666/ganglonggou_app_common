import 'package:flutter_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstTitleComponent extends StatelessWidget {
  final Color textColor;
  final String firstText;
  final String lastText;
  final double fontSize = 32;

  FirstTitleComponent(
      {Key key,
      @required this.textColor,
      @required this.firstText,
      @required this.lastText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setWidth(53),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
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
    );
  }
}

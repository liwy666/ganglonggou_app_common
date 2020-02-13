import 'package:ganglong_shop_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPageTips extends StatelessWidget {
  final String imgRoute;
  final String title;

  const MyPageTips({Key key, @required this.imgRoute, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(400),
      child: Column(
        children: <Widget>[
          Image.asset(
            imgRoute,
            width: ScreenUtil().setWidth(400),
            fit: BoxFit.contain,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: ScreenUtil().setWidth(32), color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyCell extends StatelessWidget {
  final String title;
  final String label;
  final IconData icon;

  MyCell({@required this.title, @required this.label, @required this.icon});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setWidth(15),
          horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Icon(
                  icon,
                  color: Colors.red,
                  size: COMMON_FONT_SIZE,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    color: _themeModel.fontColor1, fontSize: COMMON_FONT_SIZE),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              label,
              style: TextStyle(
                  color: _themeModel.fontColor2, fontSize: SMALL_FONT_SIZE),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

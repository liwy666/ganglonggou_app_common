import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeNotLogonUserInfoPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return MySingleRowTile(
      child: Consumer<UserInfoModel>(
        builder: (BuildContext context, UserInfoModel userInfoModel, _) {
          return Row(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: MyExtendedImage.asset(
                      USER_NOT_LOGON_HEAD_IMG_URL,
                      width: ScreenUtil().setWidth(120),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("立即登录",
                            style: TextStyle(
                                fontSize: COMMON_FONT_SIZE,
                                color: _themeModel.fontColor1)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text("登录享受更多服务",
                              style: TextStyle(
                                  fontSize: SMALL_FONT_SIZE,
                                  color: _themeModel.fontColor2)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      onTapFunction: () {
        Application.router.navigateTo(context, "/logon?showBar=true");
      },
    );
  }
}

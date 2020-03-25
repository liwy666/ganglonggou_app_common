import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/config_model.dart';
import 'package:ganglong_shop_app/data_model/logon_data_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:provider/provider.dart';

class LogonOtherLogonButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer2<ConfigModel, LogonDataModel>(
      builder: (BuildContext context, ConfigModel configModel,
          LogonDataModel logonDataModel, _) {
        return configModel.whetherInstalledWeChat ||
                configModel.whetherInstalledAliPay
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("第三方帐号登录",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: SMALL_FONT_SIZE)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        configModel.whetherInstalledWeChat
                            ? FlatButton(
                                child: Container(
                                  width: ScreenUtil().setWidth(80),
                                  height: ScreenUtil().setWidth(80),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: ExtendedImage.asset(
                                    "static_images/wechat_logo_black.png",
                                    width: ScreenUtil().setWidth(80),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                onPressed: () {
                                  print("xixi");
                                  logonDataModel.weChatLogon();
                                }, // ,
                              )
                            : Container(), //微信
                        configModel.whetherInstalledAliPay
                            ? FlatButton(
                                child: Container(
                                  width: ScreenUtil().setWidth(80),
                                  height: ScreenUtil().setWidth(80),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: MyExtendedImage.asset(
                                    "static_images/alpay_logo_black.png",
                                    width: ScreenUtil().setWidth(80),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                onPressed: () {
                                  logonDataModel.aliApyLogon();
                                },
                              )
                            : Container(), //支付宝
                      ],
                    ),
                  ), //第三方登录按钮
                ],
              )
            : Container();
      },
    );
  }
}

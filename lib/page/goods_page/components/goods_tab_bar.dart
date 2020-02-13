import 'package:fake_wechat/fake_wechat.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/data_model/page_position_model.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<PagePositionModel>(
      builder: (BuildContext context, PagePositionModel pagePositionModel,
          Widget _child) {
        return Opacity(
          opacity: (pagePositionModel.pageHeightPosition / 150) > 1
              ? 1.0
              : pagePositionModel.pageHeightPosition / 150,
          child: _child,
        );
      },
      child: Container(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil().setWidth(120),
        padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, -0.2),
            )
          ],
        ),
        //color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.blue,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  child: Text(
                    "商品详情",
                    style: TextStyle(
                        fontSize: COMMON_FONT_SIZE,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Consumer<PagePositionModel>(
                    builder: (BuildContext context,
                        PagePositionModel pagePositionModel, _) {
                      return IconButton(
                          icon: Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            if (pagePositionModel.pageHeightPosition >
                                10) {
                              Application.router.navigateTo(context, '/');
                            }
                          });
                    },
                  ),
                  Consumer<GoodsModel>(
                    builder: (BuildContext context, GoodsModel goodsModel, _) {
                      return PopupMenuButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.blue,
                        ),
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(5),
                                leading: Image.asset(
                                  "static_images/wechat_friend_logo.png",
                                ),
                                title: Text('微信好友'),
                              ),
                              value: "shareWeChatFriend",
                            ),
                            PopupMenuItem<String>(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(5),
                                leading: Image.asset(
                                  "static_images/wechat_friend_circle_logo.png",
                                ),
                                title: Text('朋友圈'),
                              ),
                              value: "shareWeChatFriendCircle",
                            ),
                          ];
                        },
                        onSelected: (String action) {
                          switch (action) {
                            case "shareWeChatFriend":
                              goodsModel.shareWeChatFriend(WechatScene.SESSION);
                              break;
                            case "shareWeChatFriendCircle":
                              goodsModel
                                  .shareWeChatFriend(WechatScene.TIMELINE);
                              break;
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

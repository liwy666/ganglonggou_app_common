import 'dart:convert';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPageModel extends ChangeNotifier {
  double _pagePosition = 0;

  double get pagePosition => _pagePosition;

  set pagePosition(double pagePosition) {
    this._pagePosition = pagePosition;
    notifyListeners();
  }

  static void toControl(
      {@required IndexAdItem indexAdItem,
      @required BuildContext context}) async {
    switch (indexAdItem.ad_type) {
      case "商品ID":
        if (indexAdItem.goods_id != null &&
            indexAdItem.goods_id.toString().isNotEmpty &&
            indexAdItem.goods_id != 0) {
          Application.router
              .navigateTo(context, '/goods?goodsId=${indexAdItem.goods_id}');
        }
        break;
      case "外链接":
        if (indexAdItem.url.isNotEmpty && indexAdItem.url != null) {
          /*Application.router.navigateTo(context,
              '/web_view?initialLink=${base64UrlEncode(utf8.encode(indexAdItem.url))}');*/
          //MyLoading.eject();
          await launch(indexAdItem.url);
          //MyLoading.shut();
        }
        break;
      case "搜索关键词":
        if (indexAdItem.text != null && indexAdItem.text.isNotEmpty) {
          Application.router.navigateTo(context,
              'search_goods_complete?keyword=${base64UrlEncode(utf8.encode(indexAdItem.text))}&showKeyword=false');
        }
        break;
    }

    print(indexAdItem.ad_type);
  }

  static void classToControl(
      {@required ClassifyItem classifyItem, @required BuildContext context}) {
    if (classifyItem.classify_name.isNotEmpty &&
        classifyItem.classify_name != null) {
      switch(classifyItem.click_type){
        case "工行活动页":
          launch(ICBC_URL);
          break;
        case "领券活动页":
          Application.router.navigateTo(context,
              'coupon_list');
          break;
        default:
          Application.router.navigateTo(context,
              'search_goods_complete?keyword=${base64UrlEncode(utf8.encode(classifyItem.classify_name))}&showKeyword=false');
          break;
      }

    }
  }
}

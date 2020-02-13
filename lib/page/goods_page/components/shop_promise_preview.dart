import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_list_tile.dart';
import 'package:ganglong_shop_app/page/goods_page/components/shop_promise_dialog.dart';

class ShopPromisePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyListTile(
      titleWidget: Text(
        '岗隆放心购',
      ),
      subtitleWidget: Text(
        '原装正品|电子发票|专业服务商|顺丰速运|7天无理由|全国联保|售后无忧',
      ),
      onTapFunction: () {
        MyDialog()
            .showBottomDialog(context: context, child: ShopPromiseDialog(),title: "岗隆放心购");
        // do something
      },
    ); //购物保证;
  }
}

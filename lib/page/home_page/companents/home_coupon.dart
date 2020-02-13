import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/routes/application.dart';

class HomeCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MySingleRowTile(
      child: Text("我的优惠券"),
      rightIcon: Icon(
        Icons.confirmation_number,
        color: Theme.of(context).accentColor,
      ),
      onTapFunction: () {
        Application.router.navigateTo(context, '/user_coupon_list');
      },
    );
  }
}

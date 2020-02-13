import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MySingleRowTile(
      child: Text("地址管理"),
      rightIcon: Icon(
        Icons.edit_location,
        color: Theme.of(context).accentColor,
      ),
      onTapFunction: () {
        Application.router.navigateTo(context, '/address_list');
      },
      marginTop: ScreenUtil().setWidth(50),
    );
  }
}

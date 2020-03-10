import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/read_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_order_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReadOrderAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ReadOrderPageModel>(
      builder:
          (BuildContext context, ReadOrderPageModel readOrderPageModel, _) {
        return MyOrderList(
          margin: EdgeInsets.only(top: 0),
          children: [
            MyOderListItem(
                label: "收件人",
                value: Text('${readOrderPageModel.orderInfo.logistics_name}')),
            MyOderListItem(
                label: "地址",
                value: Container(
                  width: ScreenUtil().setWidth(400),
                  child:
                      Text('${readOrderPageModel.orderInfo.logistics_address}'),
                )),
            MyOderListItem(
                label: "收件人电话",
                value: Text('${readOrderPageModel.orderInfo.logistics_tel}')),
          ],
        );
      },
    );
  }
}

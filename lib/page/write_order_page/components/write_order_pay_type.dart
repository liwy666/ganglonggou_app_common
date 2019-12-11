import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/write_order_page_model.dart';
import 'package:flutter_app/page/components/my_dialog.dart';
import 'package:flutter_app/page/components/my_list_tile.dart';
import 'package:flutter_app/page/write_order_page/components/write_order_pay_type_open.dart';
import 'package:provider/provider.dart';

class WriteOrderPayType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder:
          (BuildContext context, WriteOrderPageModel writeOrderPageModel, _) {
        return MyListTile(
          titleWidget: Text("支付方式"),
          subtitleWidget: Text(
              "${writeOrderPageModel.choicePayType?.pay_name}${writeOrderPageModel.choiceByStages?.bystages_val}"),
          onTapFunction: () {
            MyDialog().showBottomDialog(
                context: context, child: WriteOrderPayTypeOpen(),title: "支付方式选择");
          },
        );
      },
    );
  }
}

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/write_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_list_tile.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_invoice_open.dart';
import 'package:provider/provider.dart';

class WriteOrderInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyListTile(
      titleWidget: Text("开票方式"),
      subtitleWidget: Consumer<WriteOrderPageModel>(
        builder:
            (BuildContext context, WriteOrderPageModel writeOrderPageModel, _) {
          return Text(
              "${writeOrderPageModel.choiceInvoice['name']}${writeOrderPageModel.choiceInvoice['name'] == '不开票' ? '' : writeOrderPageModel.choiceInvoiceHead['name']}");
        },
      ),
      onTapFunction: () {
        MyDialog()
            .showBottomDialog(context: context, child: WriteOrderInvoiceOpen(),title: "开票方式选择");
      },
    );
  }
}

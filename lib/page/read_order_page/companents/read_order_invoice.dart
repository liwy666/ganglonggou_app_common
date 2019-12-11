import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/read_order_page_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/my_order_list.dart';
import 'package:provider/provider.dart';

class ReadOrderInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ReadOrderPageModel>(
      builder:
          (BuildContext context, ReadOrderPageModel readOrderPageModel, _) {
        return MyOrderList(
          children: _getMyOderListItem(readOrderPageModel.orderInfo.invoice),
        );
      },
    );
  }

  List<MyOderListItem> _getMyOderListItem(InvoiceInfo invoiceInfo) {
    switch (
        "${invoiceInfo.invoice_type}${invoiceInfo.invoice_head == null || invoiceInfo.invoice_head.isEmpty ? '' : invoiceInfo.invoice_head}") {
      case "不开票":
        return [
          MyOderListItem(
            label: "发票类型",
            value: Text("${invoiceInfo.invoice_type}"),
          ),
        ];
        break;
      case "电子发票个人":
        return [
          MyOderListItem(
            label: "发票类型",
            value: Text("${invoiceInfo.invoice_type}"),
          ), //发票类型
          MyOderListItem(
            label: "发票抬头",
            value: Text(
                "${invoiceInfo.invoice_head == null || invoiceInfo.invoice_head.isEmpty ? '' : invoiceInfo.invoice_head}"),
          ), //发票抬头
          MyOderListItem(
            label: "手机号",
            value: Text(
                "${invoiceInfo.invoice_phone == null || invoiceInfo.invoice_phone.isEmpty ? '' : invoiceInfo.invoice_phone}"),
          ), //手机号
        ];
        break;
      case "电子发票企业":
        return [
          MyOderListItem(
            label: "发票类型",
            value: Text("${invoiceInfo.invoice_type}"),
          ), //发票类型
          MyOderListItem(
            label: "发票抬头",
            value: Text(
                "${invoiceInfo.invoice_head == null || invoiceInfo.invoice_head.isEmpty ? '' : invoiceInfo.invoice_head}"),
          ), //发票抬头
          MyOderListItem(
            label: "手机号",
            value: Text(
                "${invoiceInfo.invoice_phone == null || invoiceInfo.invoice_phone.isEmpty ? '' : invoiceInfo.invoice_phone}"),
          ), //手机号
          MyOderListItem(
            label: "税号",
            value: Text(
                "${invoiceInfo.invoice_nsrsbh == null || invoiceInfo.invoice_nsrsbh.isEmpty ? '' : invoiceInfo.invoice_nsrsbh}"),
          ), //税号
          MyOderListItem(
            label: "企业名称",
            value: Text(
                "${invoiceInfo.invoice_qymc == null || invoiceInfo.invoice_qymc.isEmpty ? '' : invoiceInfo.invoice_qymc}"),
          ), //企业名称
        ];
        break;
      case "专票企业":
        return [
          MyOderListItem(
            label: "发票类型",
            value: Text("${invoiceInfo.invoice_type}"),
          ), //发票类型
          MyOderListItem(
            label: "发票抬头",
            value: Text(
                "${invoiceInfo.invoice_head == null || invoiceInfo.invoice_head.isEmpty ? '' : invoiceInfo.invoice_head}"),
          ), //发票抬头
          MyOderListItem(
            label: "座机号",
            value: Text(
                "${invoiceInfo.invoice_phone == null || invoiceInfo.invoice_phone.isEmpty ? '' : invoiceInfo.invoice_phone}"),
          ), //手机号
          MyOderListItem(
            label: "税号",
            value: Text(
                "${invoiceInfo.invoice_nsrsbh == null || invoiceInfo.invoice_nsrsbh.isEmpty ? '' : invoiceInfo.invoice_nsrsbh}"),
          ), //税号
          MyOderListItem(
            label: "企业名称",
            value: Text(
                "${invoiceInfo.invoice_qymc == null || invoiceInfo.invoice_qymc.isEmpty ? '' : invoiceInfo.invoice_qymc}"),
          ), //企业名称
          MyOderListItem(
            label: "开票地址",
            value: Text(
                "${invoiceInfo.invoice_kpdz == null || invoiceInfo.invoice_kpdz.isEmpty ? '' : invoiceInfo.invoice_kpdz}"),
          ), //开票地址
          MyOderListItem(
            label: "开户行",
            value: Text(
                "${invoiceInfo.invoice_khh == null || invoiceInfo.invoice_khh.isEmpty ? '' : invoiceInfo.invoice_khh}"),
          ), //开户行
          MyOderListItem(
            label: "银行账号",
            value: Text(
                "${invoiceInfo.invoice_yhzh == null || invoiceInfo.invoice_yhzh.isEmpty ? '' : invoiceInfo.invoice_yhzh}"),
          ), //银行账号
        ];
        break;
      default:
        return [];
    }
  }
}

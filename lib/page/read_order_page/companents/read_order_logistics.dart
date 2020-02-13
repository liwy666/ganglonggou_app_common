import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/read_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_order_list.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReadOrderLogistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ReadOrderPageModel>(
      builder:
          (BuildContext context, ReadOrderPageModel readOrderPageModel, _) {
        return readOrderPageModel.orderInfo.order_state >= 3
            ? MyOrderList(
                children: [
                  MyOderListItem(
                    label: "快递类型",
                    value: Text(
                        "${readOrderPageModel.orderInfo.logistics_code_name}"),
                  ),
                  MyOderListItem(
                    label: "快递单号",
                    value: readOrderPageModel.orderInfo.logistics_sn != null &&
                            readOrderPageModel.orderInfo.logistics_sn.isNotEmpty
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  "${readOrderPageModel.orderInfo.logistics_sn}"),
                              IconButton(
                                icon: Text(
                                  "复制",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: SO_SMALL_FONT_SIZE),
                                ),
                                onPressed: () async {
                                  ClipboardData data = new ClipboardData(
                                      text: readOrderPageModel
                                          .orderInfo.logistics_sn);
                                  await Clipboard.setData(data);
                                  Fluttertoast.showToast(
                                      msg: "已复制到您的剪切板"); //短提示
                                },
                              ), //操场按钮
                              IconButton(
                                icon: Text(
                                  "查询",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: SO_SMALL_FONT_SIZE),
                                ),
                                onPressed: () {
                                  print(readOrderPageModel
                                      .orderInfo.logistics_code);
                                  switch (readOrderPageModel
                                      .orderInfo.logistics_code) {
                                    case "shunfeng":
                                      Application.router.navigateTo(context,
                                          '/web_view?&title=${base64UrlEncode(utf8.encode("物流查询"))}&initialLink=${base64UrlEncode(utf8.encode(SF_LOGISTICS_QUERY_URL + readOrderPageModel.orderInfo.logistics_sn))}');
                                      break;
                                    case "youzhenxiaobao":
                                      Application.router.navigateTo(context,
                                          '/web_view?&title=${base64UrlEncode(utf8.encode("物流查询"))}&initialLink=${base64UrlEncode(utf8.encode(YZXB_LOGISTICS_QUERY_URL + readOrderPageModel.orderInfo.logistics_sn))}');
                                      break;
                                    default:
                                      Application.router.navigateTo(context,
                                          '/web_view?&title=${base64UrlEncode(utf8.encode("物流查询"))}&initialLink=${base64UrlEncode(utf8.encode(YZXB_LOGISTICS_QUERY_URL + readOrderPageModel.orderInfo.logistics_sn))}');
                                      break;
                                  }
                                },
                              ), //操场按钮
                            ],
                          )
                        : Container(),
                  ),
                  MyOderListItem(
                    label: "发货时间",
                    value: Text(
                        "${readOrderPageModel.orderInfo.deliver_goods_time}"),
                  ),
                  MyOderListItem(
                    label: "签收时间",
                    value: Text(
                        "${readOrderPageModel.orderInfo.sign_goods_time == null || readOrderPageModel.orderInfo.sign_goods_time.isEmpty ? "" : readOrderPageModel.orderInfo.sign_goods_time}"),
                  ),
                  MyOderListItem(
                    label: "签收超时时间",
                    value: Text(
                        "${readOrderPageModel.orderInfo.invalid_sign_goods_time == null || readOrderPageModel.orderInfo.invalid_sign_goods_time.isEmpty ? "" : readOrderPageModel.orderInfo.invalid_sign_goods_time}"),
                  ),
                ],
              )
            : Container();
      },
    );
  }
}

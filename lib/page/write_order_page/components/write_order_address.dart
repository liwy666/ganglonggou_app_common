import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/address_list_model.dart';
import 'package:flutter_app/page/components/my_list_tile.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:provider/provider.dart';

class WriteOrderAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AddressListModel>(
        builder: (BuildContext context, AddressListModel addressListModel, _) {
      return MyListTile(
        titleWidget: Text("收货地址"),
        iconWidget: Icon(Icons.navigate_next),
        onTapFunction: addressListModel.defaultAddress != null
            ? () {
                Application.router
                    .navigateTo(context, '/address_list?intoUrl=write_order');
              }
            : () {
                Application.router.navigateTo(
                    context, '/edit_address?editType=add&intoUrl=write_order}');
              },
        subtitleWidget: addressListModel.defaultAddress != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("姓名:${addressListModel.defaultAddress?.name}"),
                  Text("电话:${addressListModel.defaultAddress?.tel}"),
                  Text(
                      "地址:${addressListModel.defaultAddress?.province}${addressListModel.defaultAddress?.city}${addressListModel.defaultAddress?.county}${addressListModel.defaultAddress?.address_detail}"),
                ],
              )
            : Container(
                child: Text("无有效收件地址，点击右侧添加"),
              ),
      );
    });
  }
}

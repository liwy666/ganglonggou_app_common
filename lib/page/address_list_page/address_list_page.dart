import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/address_list_model.dart';
import 'package:flutter_app/data_model/address_list_page_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/addressItem.dart';
import 'package:flutter_app/page/address_list_page/companents/address_card.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/components/my_page_tips.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddressListPage extends StatelessWidget {
  final String intoUrl;

  const AddressListPage({Key key, @required this.intoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor1,
      appBar: MyTabBar(
        tabBarName: "地址管理",
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Application.router.navigateTo(
                    context, '/edit_address?editType=add&intoUrl=write_order}');
              },
              icon: Icon(Icons.add_location),
              label: Text(
                "新建",
                style: TextStyle(fontSize: COMMON_FONT_SIZE),
              ))
        ],
      ),
      body: Consumer2<AddressListModel, UserInfoModel>(
        builder: (BuildContext context, AddressListModel addressListModel,
            UserInfoModel userInfoModel, _) {
          return ProviderWidget<AddressListPageModel>(
            model: AddressListPageModel(),
            builder: (BuildContext context,
                AddressListPageModel addressListPageModel, _) {
              return addressListModel.addressList.data!= null&&addressListModel.addressList.data.length > 0
                  ? ListView(
                      children: _getAddressList(addressListModel,
                          (AddressItem addressItem) async {
                        MyLoading.eject();
                        try {
                          await addressListPageModel.switchDefaultAddress(
                              userToken: userInfoModel.userInfo.user_token,
                              addressId: addressItem.address_id);
                          await addressListModel.init(
                              userToken: userInfoModel.userInfo.user_token);
                          MyLoading.shut();
                        } catch (e) {
                          print(e);
                          MyLoading.shut();
                        }
                        Fluttertoast.showToast(msg: "切换地址成功"); //短提示
                        if (intoUrl == '/write_order') {
                          Application.router.pop(context);
                        }
                      }),
                    )
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          MyPageTips(
                            imgRoute: 'static_images/without_address.png',
                            title: "",
                          ),
                          RaisedButton(
                            child: Text(
                              "新建收货地址",
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: StadiumBorder(
                                side: new BorderSide(
                              style: BorderStyle.none,
                            )),
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              Application.router.navigateTo(context,
                                  '/edit_address?editType=add&intoUrl=write_order}');
                            },
                          ), //操场按钮
                        ],
                      ),
                    );
            },
            onWidgetReady: (addressListPageModel) async {
              MyLoading.eject();
              try {
                await addressListModel.init(
                    userToken: userInfoModel.userInfo.user_token);
                MyLoading.shut();
              } catch (e) {
                print(e);
                MyLoading.shut();
              }
            },
          );
        },
      ),
    );
  }

  List<Widget> _getAddressList(
      AddressListModel addressListModel, Function switchDefaultFunction) {
    return addressListModel.addressList.data
        .map<Widget>((AddressItem addressItem) {
      return Container(
        child: AddressCard(
          addressItem: addressItem,
          switchDefaultFunction: () {
            switchDefaultFunction(addressItem);
          },
          intoUrl: intoUrl,
          key: ValueKey(addressItem.address_id.toString()),
        ),
      );
    }).toList();
  }
}

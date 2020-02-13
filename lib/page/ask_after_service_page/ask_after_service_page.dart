import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/ask_after_service_model.dart';
import 'package:ganglong_shop_app/data_model/order_data_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:provider/provider.dart';

class AskAfterServicePage extends StatelessWidget {
  final String orderSn;

  const AskAfterServicePage({Key key, @required this.orderSn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyTabBar(
          tabBarName: "申请售后",
        ),
        body: Consumer2<UserInfoModel, OrderDataModel>(builder:
            (BuildContext context, UserInfoModel userInfoModel,
                OrderDataModel orderDataModel, _) {
          return ProviderWidget<AskAfterServiceModel>(
            model: AskAfterServiceModel(
                userToken: userInfoModel.userInfo.user_token, orderSn: orderSn),
            builder: (BuildContext context,
                AskAfterServiceModel askAfterServiceModel, _) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                children: <Widget>[
                  _Title(
                    title: "售后类型",
                  ),
                  Column(
                    children:
                        askAfterServiceModel.serviceTypeList.map((String val) {
                      return RadioListTile(
                        title: Text(
                          val,
                          style: TextStyle(fontSize: SMALL_FONT_SIZE),
                        ),
                        value: val,
                        groupValue: askAfterServiceModel.choiceServiceType,
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (value) {
                          if (value != askAfterServiceModel.choiceServiceType) {
                            askAfterServiceModel.choiceServiceType = value;
                          }
                        },
                      );
                    }).toList(),
                  ),
                  _Title(
                    title: "售后原因",
                  ),
                  Column(
                    children: askAfterServiceModel.serviceReasonList
                        .map((String val) {
                      return RadioListTile(
                        title: Text(
                          val,
                          style: TextStyle(fontSize: SMALL_FONT_SIZE),
                        ),
                        value: val,
                        groupValue: askAfterServiceModel.choiceServiceReason,
                        activeColor: Theme.of(context).accentColor,
                        onChanged: (value) {
                          if (value !=
                              askAfterServiceModel.choiceServiceReason) {
                            askAfterServiceModel.choiceServiceReason = value;
                          }
                        },
                      );
                    }).toList(),
                  ),
                  _Title(
                    title: "售后说明",
                  ),
                  TextField(
                    scrollPadding: EdgeInsets.all(0),
                    maxLength: 280,
                    maxLines: 2,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(fontSize: SMALL_FONT_SIZE),
                    onChanged: (String val) {
                      askAfterServiceModel.serviceDescribe = val;
                    },
                    decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.person),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "选填（280字）",
                      isDense: true,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "提交申请",
                      style: TextStyle(
                          color: Colors.white, fontSize: SMALL_FONT_SIZE),
                    ),
                    shape: StadiumBorder(
                        side: new BorderSide(
                      style: BorderStyle.none,
                    )),
                    color: Theme.of(context).accentColor,
                    onPressed: () async {
                      await askAfterServiceModel.submit();
                      orderDataModel.reFresh(userInfoModel.userInfo.user_token);
                      Navigator.popAndPushNamed(
                          context, '/read_order?orderSn=$orderSn'); //注销当前页面跳转
                    },
                  ),
                ],
              );
            },
          );
        }));
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "$title",
        style: TextStyle(fontSize: SMALL_FONT_SIZE),
      ),
    );
  }
}

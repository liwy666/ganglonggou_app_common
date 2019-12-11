import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/order_data_model.dart';
import 'package:flutter_app/data_model/submit_evaluate_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/horizontal_goods_card.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_app/routes/route_handlers.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SubmitEvaluatePage extends StatelessWidget {
  final MidOrderItem midOrderItem;

  const SubmitEvaluatePage({Key key, @required this.midOrderItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyTabBar(
        tabBarName: "提交评价",
      ),
      backgroundColor: Colors.white,
      body: Consumer2<UserInfoModel, OrderDataModel>(
        builder: (BuildContext context, UserInfoModel userInfoModel,
            OrderDataModel orderDataModel, _) {
          return ProviderWidget<SubmitEvaluateModel>(
            model: SubmitEvaluateModel(
                midOrderItem: midOrderItem,
                userToken: userInfoModel.userInfo.user_token),
            builder: (BuildContext context,
                SubmitEvaluateModel submitEvaluateModel, _) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HorizontalGoodsCard(
                        goodsImg: midOrderItem.img_url,
                        goodsName: midOrderItem.goods_name,
                        goodsAttribute: midOrderItem.sku_desc,
                      ),
                    ),
                  ),
                  _Title(
                    title: "商品评分",
                  ),
                  SmoothStarRating(
                    allowHalfRating: true,
                    starCount: 5,
                    rating: submitEvaluateModel.rate,
                    color: Theme.of(context).accentColor,
                    //size: SO_LARGE_FONT_SIZE,
                    onRatingChanged: (double v) {
                      if (v != submitEvaluateModel.rate) {
                        submitEvaluateModel.rate = v;
                      }
                    },
                  ),
                  _Title(
                    title: "评价内容",
                  ),
                  TextField(
                    scrollPadding: EdgeInsets.all(0),
                    maxLength: 480,
                    maxLines: 2,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(fontSize: SMALL_FONT_SIZE),
                    onChanged: (String val) {
                      submitEvaluateModel.evaluateText = val;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "选填（480字）",
                      isDense: true,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "提交评价",
                      style: TextStyle(
                          color: Colors.white, fontSize: SMALL_FONT_SIZE),
                    ),
                    shape: StadiumBorder(
                        side: new BorderSide(
                      style: BorderStyle.none,
                    )),
                    color: Theme.of(context).accentColor,
                    onPressed: () async {
                      await submitEvaluateModel.submit();
                      orderDataModel.reFresh(userInfoModel.userInfo.user_token);
                      Application.router.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
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

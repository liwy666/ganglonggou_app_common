import 'package:flutter/cupertino.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_list_data_model.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/goods_page/components/goods_loading.dart';
import 'package:ganglong_shop_app/page/goods_page/components/goods_main.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:provider/provider.dart';

enum GoodsImgShowDirection {
  left,
  right,
}

// ignore: must_be_immutable
class GoodsPage extends StatelessWidget {
  final int goodsId;
  final GoodsImgShowDirection goodsImgShowDirection;
  bool initPagePosition = true;

  GoodsPage({@required this.goodsId, @required this.goodsImgShowDirection});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final GoodsListDataModel _goodsListModel =
        Provider.of<GoodsListDataModel>(context);
    final UserInfoModel _userInfoModel = Provider.of<UserInfoModel>(context);
    return ProviderWidget<GoodsModel>(
      model: GoodsModel(
          userInfoModel: _userInfoModel,
          goodsId: goodsId,
          goodsList: _goodsListModel.goodsList,
          pageContext: context),
      builder: (BuildContext context, GoodsModel goodsModel, Widget _) {
        return goodsModel.loadFinish
            ? GoodsMain(
                goodsId: goodsId,
              )
            : GoodsLoading(
                appWidth: MediaQuery.of(context).size.width,
                topPadding: MediaQuery.of(context).padding.top,
                goodsImgShowDirection: goodsImgShowDirection,
                goodsImgUrl: goodsModel.goodsInfo.goodsImg,
              );
      },
    );
  }
}

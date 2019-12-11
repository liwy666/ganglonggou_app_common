import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_list_data_model.dart';
import 'package:flutter_app/data_model/page_position_model.dart';
import 'package:flutter_app/data_model/supplier_page_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/contain_head_goods_list.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/page/supplier_page/components/supplier_head.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:provider/provider.dart';

class SupplierPage extends StatelessWidget {
  final SupplierPreviewInfo supplierPreviewInfo;

  const SupplierPage({Key key, @required this.supplierPreviewInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return ProviderWidget<PagePositionModel>(
      model: PagePositionModel(),
      builder: (BuildContext context, PagePositionModel pagePositionModel, _) {
        return Scaffold(
          backgroundColor: _themeModel.pageBackgroundColor1,
          appBar: MyTabBar(
            tabBarName: "店铺详情",
          ),
          body: Consumer<GoodsListDataModel>(
            builder: (BuildContext context,
                GoodsListDataModel goodsListDataModel, _) {
              return ProviderWidget<SupplierPageModel>(
                model: SupplierPageModel(
                    allGoodsList: goodsListDataModel.goodsList,
                    supplierPreviewInfo: supplierPreviewInfo),
                builder: (BuildContext context,
                    SupplierPageModel supplierPageModel, _) {
                  return ContainHeadGoodsList(
                    initialGoodsList: supplierPageModel.goodsList,
                    scrollController: pagePositionModel.controller,
                    headWidget: SupplierHead(),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
              heroTag: "supplier_${supplierPreviewInfo.supplier_name}",
              child: pagePositionModel.floatingActionButtonChild,
              foregroundColor: Colors.white,
              onPressed: () {
                pagePositionModel.toTop();
              }),
        );
      },
    );
  }
}

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_model.dart';
import 'package:flutter_app/page/components/my_list_tile.dart';
import 'package:flutter_app/routes/application.dart';

class EvaluatePreview extends StatelessWidget {
  final GoodsModel goodsModel;

  EvaluatePreview({@required this.goodsModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyListTile(
      titleWidget: Text("评价"),
      subtitleWidget:
          Text("该商品已有(${this.goodsModel.goodsItem.evaluate_count})条评价"),
      onTapFunction: () {
        Application.router.navigateTo(
            context, '/evaluate_list?goodsId=${goodsModel.goodsId}');
      },
      iconWidget: Icon(Icons.navigate_next),
    );
  }
}

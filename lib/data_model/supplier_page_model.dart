import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/goodsItem.dart';
import 'package:flutter_app/models/index.dart';

class SupplierPageModel with ChangeNotifier {
  final List<GoodsItem> allGoodsList;
  final SupplierPreviewInfo supplierPreviewInfo;
  List<GoodsItem> _goodsList;

  List<GoodsItem> get goodsList => _goodsList;

  SupplierPageModel({
    @required this.supplierPreviewInfo,
    @required this.allGoodsList,
  }) {
    _goodsList = allGoodsList
        .where((GoodsItem goodsItem) =>
            (goodsItem.supplier_id == supplierPreviewInfo.id))
        .toList();
  }
}

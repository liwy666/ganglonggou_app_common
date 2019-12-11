import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/get_extra_goods_info';

class FetchExtraGoodsInfo {
  static Future<ExtraGoodsInfo> fetch({@required goodsId}) async {
    final response = await dio.get(FETCH_INDEX_INFO_URL,
        queryParameters: {'into_type': INTO_TYPE, 'goods_id': goodsId});
    return ExtraGoodsInfo.fromJson(response.data);
  }
}

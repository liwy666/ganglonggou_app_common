import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/user_get_evaluate_by_goods_id_and_page';

class FetchEvaluateList {
  static Future<GoodsEvaluateList> fetch(
      {@required goodsId, @required page, @required limit}) async {
    final response = await dio.get(FETCH_INDEX_INFO_URL,
        queryParameters: {'goods_id': goodsId, "page": page, "limit": limit});
    final Map<String, dynamic> data = {"data": response.data};
    return GoodsEvaluateList.fromJson(data);
  }
}

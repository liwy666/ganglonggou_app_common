import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/request/fetch_all_order.dart';

class OrderDataModel with ChangeNotifier {
  bool _isInit = false;
  List<OrderPreviewItem> _orderPreviewList = [];

  List<OrderPreviewItem> get allOrder {
    _sortOrderByUpdDate(_orderPreviewList);

    return _orderPreviewList;
  }

  List<OrderPreviewItem> get waitPayOrder {
    if (_orderPreviewList.length == 0) return [];
    List<OrderPreviewItem> _orderList = [];

    _orderPreviewList.forEach((OrderPreviewItem orderPreviewItem) {
      if (orderPreviewItem.order_state == 1) {
        _orderList.add(orderPreviewItem);
      }
    });
    _sortOrderByUpdDate(_orderList);
    return _orderList;
  }

  List<OrderPreviewItem> get waitSignOrder {
    if (_orderPreviewList.length == 0) return [];

    List<OrderPreviewItem> _orderList = [];
    _orderPreviewList.forEach((OrderPreviewItem orderPreviewItem) {
      if (orderPreviewItem.order_state >= 2 &&
          orderPreviewItem.order_state <= 3) {
        _orderList.add(orderPreviewItem);
      }
    });
    _sortOrderByUpdDate(_orderList);
    return _orderList;
  }

  List<OrderPreviewItem> get afterSaleOrder {
    if (_orderPreviewList.length == 0) return [];
    List<OrderPreviewItem> _orderList = [];

    _orderPreviewList.forEach((OrderPreviewItem orderPreviewItem) {
      if (orderPreviewItem.order_state >= 6) {
        _orderList.add(orderPreviewItem);
      }
    });

    _sortOrderByUpdDate(_orderList);

    return _orderList;
  }

  List<MidOrderItem> get waitEvaluateGoods {
    if (_orderPreviewList.length == 0) return [];

    List<MidOrderItem> _goodsList = [];
    _sortOrderByUpdDate(_orderPreviewList);
    _orderPreviewList.forEach((OrderPreviewItem orderPreviewItem) {
      if (orderPreviewItem.order_state == 4) {
        orderPreviewItem.mid_order.forEach((MidOrderItem midOrderItem) {
          if (midOrderItem.is_evaluate == 0) {
            _goodsList.add(midOrderItem);
          }
        });
      }
    });
    return _goodsList;
  }

  Future init(String userToken) async {
    if (!_isInit) {
      OrderPreviewInfo orderPreviewInfo =
          await FetchAllOrder.fetch(userToken: userToken);
      _orderPreviewList = orderPreviewInfo.data;
      _isInit = true;
      notifyListeners();
    }
  }

  Future reFresh(String userToken) async {
    OrderPreviewInfo orderPreviewInfo =
        await FetchAllOrder.fetch(userToken: userToken);
    _orderPreviewList = orderPreviewInfo.data;
    notifyListeners();
  }

  void _sortOrderByUpdDate(List<OrderPreviewItem> orderList) {
    if (orderList.length > 0) {
      orderList.sort((a, b) =>
          DateTime.parse(a.upd_time).millisecondsSinceEpoch <
                  DateTime.parse(b.upd_time).millisecondsSinceEpoch
              ? 1
              : -1);
    }
  }
}

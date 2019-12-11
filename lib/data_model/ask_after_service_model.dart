import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/request/post_submit_after_service.dart';

class AskAfterServiceModel with ChangeNotifier {
  final String orderSn;
  final String userToken;
  List<String> _serviceTypeList = ['全额退款'];
  List<String> _serviceReasonList = [
    '卖家发错货',
    '包装/商品破损/污渍',
    '质量问题',
    '少件/漏发',
    '发票问题',
    '其它'
  ];
  String _choiceServiceType = '全额退款';
  String _choiceServiceReason = '卖家发错货';
  String _serviceDescribe = "";

  AskAfterServiceModel({@required this.orderSn, @required this.userToken});

  List<String> get serviceTypeList => _serviceTypeList;

  List<String> get serviceReasonList => _serviceReasonList;

  String get choiceServiceType => _choiceServiceType;

  String get choiceServiceReason => _choiceServiceReason;

  set choiceServiceType(String val) {
    _choiceServiceType = val;
    notifyListeners();
  }

  set choiceServiceReason(String val) {
    _choiceServiceReason = val;
    notifyListeners();
  }

  set serviceDescribe(String val) {
    _serviceDescribe = val;
    notifyListeners();
  }

  Future<void> submit() async {
    print(orderSn);
    print(userToken);
    MyLoading.eject();
    try {
      await PostSubmitAfterService.post(
          userToken: userToken,
          orderSn: orderSn,
          choiceServiceType: _choiceServiceType,
          choiceServiceReason: _choiceServiceReason,
          serviceDescribe: _serviceDescribe);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }
}

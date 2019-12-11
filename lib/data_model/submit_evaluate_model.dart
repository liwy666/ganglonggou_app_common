import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/request/post_submit_evaluate.dart';

class SubmitEvaluateModel with ChangeNotifier {
  final MidOrderItem midOrderItem;
  final String userToken;
  double _rate = 5.0;
  String _evaluateText = "";

  double get rate => _rate;

  set rate(double val) {
    this._rate = val;
    notifyListeners();
  }

  set evaluateText(String val) {
    this._evaluateText = val;
  }

  SubmitEvaluateModel({
    @required this.midOrderItem,
    @required this.userToken,
  });

  Future<void> submit() async {
    if (_evaluateText.isEmpty) {
      _evaluateText = "该用户没有填写评价。";
    }

    MyLoading.eject();
    try {
      await PostSubmitEvaluate.post(
          userToken: userToken,
          midOrderId: midOrderItem.id,
          evaluateText: _evaluateText,
          rate: rate);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }
}

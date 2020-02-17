import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/ask_after_service_page/companents/not_agree_dialog.dart';
import 'package:ganglong_shop_app/page/ask_after_service_page/companents/whether_agree_dialog.dart';

class AskWhetherAgreeAgreement {
  final BuildContext context;

  AskWhetherAgreeAgreement({this.context}) {
    _ejectWhetherAgree();
  }

  ///弹出是否同意协议对话框
  _ejectWhetherAgree() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              child: WhetherAgreeDialog(
                notAgreeFunction: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return WillPopScope(
                          onWillPop: () async {
                            return false;
                          },
                          child: Dialog(
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                            child: NotAgreeDialog(),
                          ),
                        );
                      });
                },
              ),
            ),
          );
        });
  }
}

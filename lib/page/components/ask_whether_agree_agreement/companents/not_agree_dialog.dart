import 'package:flutter/gestures.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/config_model.dart';
import 'package:provider/provider.dart';

class NotAgreeDialog extends StatelessWidget {
  final TapGestureRecognizer _recognizerUser = TapGestureRecognizer();
  final TapGestureRecognizer _recognizerPrivacy = TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    _recognizerUser.onTap = () {
      openUserAgreement(context);
    };
    _recognizerPrivacy.onTap = () {
      openPrivacyAgreement(context);
    };
    // TODO: implement build
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "您需要同意协议",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "        您需要同意协议才能获得更好的用户体验与后续服务，您可以稍后在登录界面重新授权和同意"),
                TextSpan(
                  text: "《用户协议》",
                  style: TextStyle(color: Colors.blue),
                  recognizer: _recognizerUser,
                ),
                TextSpan(text: "和"),
                TextSpan(
                  text: "《隐私政策》",
                  style: TextStyle(color: Colors.blue),
                  recognizer: _recognizerPrivacy,
                ),
              ])),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "稍后再说",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _notAgree(context: context);
                  },
                ),
                Consumer<ConfigModel>(
                  builder: (BuildContext context, ConfigModel configModel, _) {
                    return FlatButton(
                      child: Text(
                        "同意",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        _agree(context: context, configModel: configModel);
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///同意协议
  _agree({@required BuildContext context, @required ConfigModel configModel}) {
    configModel.agreeAgreementFunction();
    Navigator.pop(context);
  }

  ///稍后再说
  _notAgree({@required BuildContext context}) {
    Navigator.pop(context);
  }
}

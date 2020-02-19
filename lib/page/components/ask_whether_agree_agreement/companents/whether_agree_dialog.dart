import 'package:flutter/gestures.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/config_model.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:provider/provider.dart';

class WhetherAgreeDialog extends StatelessWidget {
  final TapGestureRecognizer _recognizerUser = TapGestureRecognizer();
  final TapGestureRecognizer _recognizerPrivacy = TapGestureRecognizer();
  final Function notAgreeFunction;

  WhetherAgreeDialog({Key key, @required this.notAgreeFunction})
      : super(key: key);

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
                "温馨提示",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text('        我们做出了诸多有利于用户个人对政策，明确了用户在使用岗隆购过程中我们所收集对信息，'
                  '使用场景与规则，如何保护用户对隐私信息安全，'
                  '并告知用户如何查询、更正、删除授权信息对方式。'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text.rich(TextSpan(children: [
                TextSpan(text: "        您可以通过查看完整版"),
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
                TextSpan(text: "了解详尽对个人信息处理规则和用户权力义务。"),
              ])),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "不同意",
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
                ), //操场按
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

  ///不同意协议
  _notAgree({@required BuildContext context}) {
    Navigator.pop(context);
    notAgreeFunction();
  }
}

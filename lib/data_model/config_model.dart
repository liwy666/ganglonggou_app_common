import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/sqflite_model/base_sqflite.dart';

class ConfigModel with ChangeNotifier {
  bool _initialInstallation = true;
  bool _agreeUserAgreement = false;
  bool _agreePrivacyAgreement = false;

  bool get initialInstallation => _initialInstallation;

  bool get agreeUserAgreement => _agreeUserAgreement;

  bool get agreePrivacyAgreement => _agreePrivacyAgreement;

  ///初始化
  void init(
      {@required String initialInstallation,
      @required String agreeUserAgreement,
      @required String agreePrivacyAgreement}) {
    switch (initialInstallation) {
      case "1":
        _initialInstallation = true;
        break;
      case "0":
        _initialInstallation = false;
        break;
      default:
        _initialInstallation = true;
        break;
    }
    switch (agreeUserAgreement) {
      case "1":
        _agreeUserAgreement = true;
        break;
      case "0":
        _agreeUserAgreement = false;
        break;
      default:
        _agreeUserAgreement = false;
        break;
    }
    switch (agreePrivacyAgreement) {
      case "1":
        _agreePrivacyAgreement = true;
        break;
      case "0":
        _agreePrivacyAgreement = false;
        break;
      default:
        _agreePrivacyAgreement = false;
        break;
    }
  }

  ///修改为不是初次安装
  Future<void> alreadyInstallation() async {
    await BaseSqflite.updateOnly(key: 'initial_installation', value: '0');
    _initialInstallation = false;
  }

  ///同意协议
  Future<void> agreeAgreement() async {
    await _agreePrivacyAgreementFunction();
    await _agreeUserAgreementFunction();
    notifyListeners();
  }

  ///同意用户协议
  Future<void> _agreeUserAgreementFunction() async {
    await BaseSqflite.updateOnly(key: 'agree_user_agreement', value: '1');
    _agreeUserAgreement = true;
  }

  ///同意隐私政策
  Future<void> _agreePrivacyAgreementFunction() async {
    await BaseSqflite.updateOnly(key: 'agree_privacy_agreement', value: '1');
    _agreePrivacyAgreement = true;
  }
}

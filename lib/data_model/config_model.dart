import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/sqflite_model/base_sqflite.dart';

class ConfigModel with ChangeNotifier {
  ///是否初次安装
  bool _initialInstallation = true;

  ///是否同意用户协议
  bool _agreeUserAgreement = false;

  ///是否同意隐私协议
  bool _agreePrivacyAgreement = false;

  ///是否安装微信
  bool _whetherInstalledWeChat = false;

  ///是否安装支付宝
  bool _whetherInstalledAliPay = false;

  bool get agreeAllAgreement =>
      _agreeUserAgreement && _agreePrivacyAgreement; //所有协议

  bool get initialInstallation => _initialInstallation;

  bool get agreeUserAgreement => _agreeUserAgreement;

  bool get agreePrivacyAgreement => _agreePrivacyAgreement;

  bool get whetherInstalledWeChat => _whetherInstalledWeChat;

  bool get whetherInstalledAliPay => _whetherInstalledAliPay;

  set whetherInstalledWeChat(bool value) {
    _whetherInstalledWeChat = value;
  }

  set whetherInstalledAliPay(bool value) {
    _whetherInstalledAliPay = value;
  }

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
  Future<void> agreeAgreementFunction() async {
    await _agreePrivacyAgreementFunction();
    await _agreeUserAgreementFunction();
    notifyListeners();
  }

  ///不同意协议
  Future<void> notAgreeAgreementFunction() async {
    await _notAgreeUserAgreementFunction();
    await _notAgreePrivacyAgreementFunction();
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

  ///不同意用户协议
  Future<void> _notAgreeUserAgreementFunction() async {
    await BaseSqflite.updateOnly(key: 'agree_user_agreement', value: '0');
    _agreeUserAgreement = false;
  }

  ///不同意隐私政策
  Future<void> _notAgreePrivacyAgreementFunction() async {
    await BaseSqflite.updateOnly(key: 'agree_privacy_agreement', value: '0');
    _agreePrivacyAgreement = false;
  }
}

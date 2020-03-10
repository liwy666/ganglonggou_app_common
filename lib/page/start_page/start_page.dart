import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/config_model.dart';
import 'package:ganglong_shop_app/data_model/start_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/getVersionInfo.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/request/fetch_version_info.dart';
import 'package:flutter_ios_dark_mode/flutter_ios_dark_mode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:ganglong_shop_app/service/alipay_service.dart';
import 'package:ganglong_shop_app/service/wechat_service.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StartPage();
  }
}

class _StartPage extends State<StartPage> {
  StartModel _startModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      //loading组件写入全局context
      MyLoading.loadContext = context;
      //Application写入全局context
      Application.startPageContext = context;
      //初始化页面高宽
      ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
      //检查版本更新，android需要进行检测
      //bool needUpdateApp = await _checkVersion();
      bool needUpdateApp = false;
      //检查是否初次安装
      bool initialInstallation = _checkInitialInstallation();
      //检测主题模式
      _checkDarkModel();
      //微信检测
      await _checkWeChatInstalled();
      //支付宝检测
      await _checkAliPayInstalled();

      //如果是初次安装就跳转引导页面
      if (!initialInstallation) {
        await _startModel.init();
        await Future.delayed(Duration(seconds: 1));
        Navigator.popAndPushNamed(
            context, '/main?needUpdateApp=$needUpdateApp');
      } else {
        Navigator.popAndPushNamed(context, '/boot');
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _startModel = Provider.of<StartModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset('static_images/start_img.jpg', fit: BoxFit.fitWidth),
      ),
    );
  }

  ///检查是否需要更新版本
  Future<bool> _checkVersion() async {
    GetVersionInfo getVersionInfo = await FetchVersionInfo.fetch();
    _startModel.getVersionInfo = getVersionInfo;
    if (getVersionInfo.result_code == "success" &&
        getVersionInfo.build_number > _startModel.appBuildNumber) return true;
    return false;
  }

  ///检查是否初次安装
  bool _checkInitialInstallation() {
    final _configModel = Provider.of<ConfigModel>(context);
    final bool initialInstallation = _configModel.initialInstallation;
    return initialInstallation;
  }

  ///检测是否开启暗夜模式
  void _checkDarkModel() async {
    //检测
    final bool darkModeEnabled = await FlutterIosDarkMode().darkModeEnabled;
    _switchDarkTheme(darkModeEnabled);

    //添加监听
    FlutterIosDarkMode()
        .onDarkModeStateChanged
        .listen((bool listenDarkModeEnabled) {
      _switchDarkTheme(listenDarkModeEnabled);
    });
  }

  ///切换主题模式
  void _switchDarkTheme(bool darkModeEnabled) {
    final _themeModel = Provider.of<ThemeModel>(context);
    if (!_themeModel.appThemeModeFollowingSystem) return;

    if (darkModeEnabled) {
      _themeModel.switchNightMode();
    } else {
      _themeModel.switchDefaultMode();
    }
  }

  ///检测是否安装微信
  Future<void> _checkWeChatInstalled() async {
    final WeChatService _weChatService = WeChatService();
    final _configModel = Provider.of<ConfigModel>(context);
    _configModel.whetherInstalledWeChat =
        await _weChatService.weChat.isWechatInstalled() &&
            await _weChatService.weChat.isWechatSupportApi();
    _weChatService.cancel();
  }

  ///检测是否安装支付宝
  Future<void> _checkAliPayInstalled() async {
    final AliPayService _aliPayService = AliPayService();
    final _configModel = Provider.of<ConfigModel>(context);
    _configModel.whetherInstalledAliPay =
        await _aliPayService.aliPay.isAlipayInstalled();
    _aliPayService.cancel();
  }
}

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/start_model.dart';
import 'package:flutter_app/models/getVersionInfo.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/request/fetch_version_info.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      //初始化
      await _startModel.init();
      //loading组件写入全局context
      MyLoading.loadContext = context;
      //初始化页面高宽
      ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
      //检查版本更新
      bool needUpdateApp = await _checkVersion(context);
      //初始化下载
      await FlutterDownloader.initialize();
      //等待
      await Future.delayed(Duration(seconds: 2));
      //跳转
      Navigator.popAndPushNamed(context, '/main?needUpdateApp=$needUpdateApp');
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
  Future<bool> _checkVersion(BuildContext context) async {
    GetVersionInfo getVersionInfo = await FetchVersionInfo.fetch();
    _startModel.getVersionInfo = getVersionInfo;
    if (getVersionInfo.result_code == "success" &&
        getVersionInfo.app_version != VERSION) return true;
    return false;
  }
}

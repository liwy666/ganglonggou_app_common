import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/getVersionInfo.dart';
import 'package:provider/provider.dart';

class DownloadDialogBoxChild extends StatefulWidget {
  final GetVersionInfo getVersionInfo;
  final String storagePath; //下载路径

  const DownloadDialogBoxChild(
      {Key key, @required this.getVersionInfo, @required this.storagePath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DownloadDialogBoxChild();
  }
}

class _DownloadDialogBoxChild extends State<DownloadDialogBoxChild> {
  int _progressValue = 0;
  Timer _timer;

  @override
  void initState() {
    _launchDownload();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _launchDownload() async {
    Response response = await dio
        .download(widget.getVersionInfo.download_url, widget.storagePath,
            onReceiveProgress: (int count, int total) {
      setState(() {
        _progressValue = count;
      });
    });
    if(response.statusCode == 200){
      //InstallPlugin.installApk(widget.storagePath, '');
    }


    //await open(widget.storagePath);
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _themeModel.pageBackgroundColor2,
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            'static_images/update_loading.png',
            fit: BoxFit.fitWidth,
          ), //头图
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "全力更新中...",
              style: TextStyle(
                  fontSize: LARGE_FONT_SIZE,
                  fontWeight: FontWeight.w600,
                  color: _themeModel.fontColor1),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 15),
            child: LinearProgressIndicator(
              value: _progressValue /
                  double.parse(widget.getVersionInfo.file_size),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 0),
            child: Text(
              "已下载${(_progressValue / 1048576).toStringAsFixed(2)}MB/${(int.parse(widget.getVersionInfo.file_size) / 1048576).toStringAsFixed(2)}MB",
              style: TextStyle(
                  fontSize: SMALL_FONT_SIZE, color: _themeModel.fontColor2),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

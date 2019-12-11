import 'dart:async';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/getVersionInfo.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  double _progressValue = 0;
  Timer _timer;
  String _taskId;

  @override
  void initState() {
    /*   _timer = Timer.periodic(Duration(milliseconds: 1000), (timer1) {
      if (_progressValue >= 1) {
        timer1.cancel();
        print("timer1.cancel()");
      }
      setState(() {
        _progressValue += 0.1;
      });
    });*/
    _launchDownload();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _launchDownload() async {
    _taskId = await FlutterDownloader.enqueue(
        url: widget.getVersionInfo.download_url, savedDir: widget.storagePath);
    print("ID:$_taskId");
    FlutterDownloader.registerCallback((id, status, progress) {
      if (status == DownloadTaskStatus.running) {
        print("下载中:${progress.toDouble()}");
      }
      if (status == DownloadTaskStatus.failed) {
        print("下载异常，请稍后重试");
      }
      if (status == DownloadTaskStatus.complete) {
        print("完成");
      }
    });
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
              value: _progressValue,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 0),
            child: Text(
              "${(_progressValue * 100).toStringAsFixed(1)}/100",
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

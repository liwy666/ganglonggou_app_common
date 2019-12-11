import 'dart:io';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/getVersionInfo.dart';
import 'package:flutter_app/page/components/update_app/components/download_dialog_box_child.dart';
import 'package:flutter_app/page/components/update_app/components/if_update_dialog_box_child.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateApp {
  final BuildContext context;
  final GetVersionInfo getVersionInfo;

  UpdateApp({@required this.context, @required this.getVersionInfo}) {
    _ejectIfUpdateDialogBox();
  }

  ///弹出是否更新询问窗
  _ejectIfUpdateDialogBox() {
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
              child: IfUpdateDialogBoxChild(
                getVersionInfo: getVersionInfo,
                immediateUpdate: () {
                  _ejectDownloadDialogBox();
                },
              ),
            ),
          );
        });
  }

  ///弹出下载监视窗
  _ejectDownloadDialogBox() async {
    //检查权限
    bool permissions = await _checkPermission();
    //用户拒绝了存储授权
    if (!permissions) {
      Fluttertoast.showToast(msg: "应用更新时需要您授权存储权限，再试一次吧", timeInSecForIos: 2);
      return;
    }
    //获取存储路径
    final String _storagePath = await _findLocalPath() + '/download';
    //创建Directory对象
    final Directory _savedDir = Directory(_storagePath);
    //判断是否路径是否存在，否则创建
    bool _hasExisted = await _savedDir.exists();
    if (!_hasExisted) {
      _savedDir.create();
    }
    //弹出更新窗
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Dialog(
              backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              child: DownloadDialogBoxChild(
                getVersionInfo: getVersionInfo,
                storagePath: _storagePath,
              ),
            ),
          );
        });
  }

  ///申请权限
  Future<bool> _checkPermission() async {
    bool storagePermission = true; //存储权限
    //检查权限
    PermissionStatus checkStoragePermission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    //申请存储权限
    if (checkStoragePermission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      storagePermission =
          permissions[PermissionGroup.storage] == PermissionStatus.granted;
    }

    return storagePermission;
  }

  ///获取存储路径
  Future<String> _findLocalPath() async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }
}

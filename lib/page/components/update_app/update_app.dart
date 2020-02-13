import 'dart:io';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/getVersionInfo.dart';
import 'package:ganglong_shop_app/page/components/update_app/components/download_dialog_box_child.dart';
import 'package:ganglong_shop_app/page/components/update_app/components/if_update_dialog_box_child.dart';
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
    String _storagePath = await _findLocalPath() + '/';
    //创建Directory对象
    final Directory _savedDir = Directory(_storagePath);
    //判断是否路径是否存在，否则创建
    bool _hasExisted = await _savedDir.exists();
    if (!_hasExisted) {
      _savedDir.create();
    }
    //生成保存路径
    RegExp reg = RegExp(r'(?<=\/{1})(\w)+\.{1}\w+');
    _storagePath += reg.firstMatch(getVersionInfo.download_url).group(0);
    print("路径:$_storagePath");
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
//    临时目录:可以使用 getTemporaryDirectory() 来获取临时目录； 系统可随时清除的临时目录（缓存）。在iOS上，这对应于NSTemporaryDirectory() 返回的值。在Android上，这是getCacheDir()返回的值。
//    文档目录:可以使用getApplicationDocumentsDirectory()来获取应用程序的文档目录，该目录用于存储只有自己可以访问的文件。只有当应用程序被卸载时，系统才会清除该目录。在iOS上，这对应于NSDocumentDirectory。在Android上，这是AppData目录。
//    外部存储目录:可以使用getExternalStorageDirectory()来获取外部存储目录，如SD卡；由于iOS不支持外部目录，所以在iOS下调用该方法会抛出UnsupportedError异常，而在Android下结果是android SDK中getExternalStorageDirectory的返回值。
    final Directory directory = await getExternalStorageDirectory();
    return directory.path;
  }
}

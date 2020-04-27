import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:ganglong_shop_app/request/post_update_user_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditUserInfoPageModel with ChangeNotifier {
  UserInfo _userInfo;
  UserInfo _oldUserInfo;

  UserInfo get userInfo => _userInfo;

  set setUserName(String userName) {
    this._userInfo.user_name = userName;
  }

  EditUserInfoPageModel({@required UserInfo userInfo}) {
    this._oldUserInfo = userInfo;
    this._userInfo = UserInfo.fromJson(userInfo.toJson());
  }

  Future<bool> uploadUserHeadPortrait() async {
    File imageFile;
    try {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print(e);
      MyToast.showToast(msg: "无法访问媒体图片"); //短提示
    }

    if (imageFile == null) {
      MyToast.showToast(msg: "没有选取图片"); //短提示
      return false;
    }
    //限制上传大小4194304bit
    int imageSize = imageFile.lengthSync();
    if (imageSize >= 4194304) {
      MyToast.showToast(msg: "上传图片过大"); //短提示
      return false;
    }
    FormData formData = FormData.fromMap({
      "portrait_img": await MultipartFile.fromFile(imageFile.path,
          filename:
              imageFile.path.substring(imageFile.path.lastIndexOf("/") + 1))
    });
    MyLoading.eject();
    try {
      Response response = await dio.post("/user_upd_portrait", data: formData);
      this.userInfo.user_img = response.data["original_img"];
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }

    return true;
  }

  Future<bool> submitUserData() async {
    if (_userInfo.user_name == _oldUserInfo.user_name &&
        _userInfo.user_img == _oldUserInfo.user_img) {
      return true;
    } //没有变化
    if (!checkUserName(_userInfo.user_name)) return false;
    if (userInfo.user_img == null || userInfo.user_img.isEmpty) {
      MyToast.showToast(msg: "无效头像"); //短提示
    }
    //提交用户信息
    MyLoading.eject();
    try {
      await PostUpdateUserInfo.post(
          userToken: userInfo.user_token,
          userName: userInfo.user_name,
          userImg: userInfo.user_img);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }

    return true;
  }
}

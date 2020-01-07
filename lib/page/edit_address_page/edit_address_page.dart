import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/address_list_model.dart';
import 'package:flutter_app/data_model/edit_address_page_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/addressItem.dart';
import 'package:flutter_app/page/components/my_dialog.dart';
import 'package:flutter_app/page/components/my_list_tile.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditAddressPage extends StatelessWidget {
  AddressItem _addressItem;
  final String editType;
  final String intoUrl;

  EditAddressPage(
      {Key key,
      String addressItemJson,
      @required this.editType,
      @required this.intoUrl})
      : super(key: key) {
    if (editType == "update") {
      _addressItem = AddressItem.fromJson(jsonDecode(addressItemJson));
    } else {
      _addressItem = AddressItem();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return ProviderWidget<EditAddressPageModel>(
        model:
            EditAddressPageModel(addressItem: _addressItem, editType: editType),
        child: MyTabBar(
          tabBarName: "编辑收货地址",
        ),
        builder: (BuildContext context,
            EditAddressPageModel editAddressPageModel, Widget child) {
          return Scaffold(
            backgroundColor: _themeModel.pageBackgroundColor2,
            appBar: child,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  _AddressRegion(),
                  TextField(
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            // 设置内容
                            text: editAddressPageModel.addressItem.name,
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: editAddressPageModel
                                    .addressItem.name.length)))),
                    maxLength: 11,
                    style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                    decoration: InputDecoration(labelText: "收件人姓名"),
                    onChanged: (val) {
                      editAddressPageModel.setName = val;
                    },
                  ),
                  TextField(
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            // 设置内容
                            text: editAddressPageModel.addressItem.tel,
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: editAddressPageModel
                                    .addressItem.tel.length)))),
                    style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "手机号"),
                    onChanged: (val) {
                      editAddressPageModel.setTel =
                          val is int ? val.toString() : val;
                    },
                  ),
                  TextField(
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            // 设置内容
                            text:
                                editAddressPageModel.addressItem.address_detail,
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: editAddressPageModel
                                    .addressItem.address_detail.length)))),
                    style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                    maxLength: 50,
                    decoration: InputDecoration(labelText: "详细地址"),
                    onChanged: (val) {
                      editAddressPageModel.setDetail = val;
                    },
                  ),
                  editType == 'add' ? _AddButton() : Container(),
                  editType == 'update' ? _UpdateButton() : Container(),
                  editType == 'update' ? _DeleteButton() : Container(),
                ],
              ),
            ),
          );
        });
  }
}

enum _PickerItemType {
  province,
  city,
  county,
}

class _AddressRegion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<EditAddressPageModel>(
      builder: (BuildContext context, EditAddressPageModel editAddressPageModel,
          Widget child) {
        return MyListTile(
          titleWidget: Text("地区选择"),
          subtitleWidget: Text(
              "${editAddressPageModel.choiceProvince}${editAddressPageModel.choiceCity}${editAddressPageModel.choiceCounty}"),
          onTapFunction: () {
            MyDialog().showBottomDialog(
                context: context,
                child: _BuildBottomPicker(pickerList: [
                  _BuildBottomPickerItem(
                    pickerItemType: _PickerItemType.province,
                    key: ValueKey("province"),
                  ),
                  _BuildBottomPickerItem(
                    pickerItemType: _PickerItemType.city,
                    key: ValueKey("city"),
                  ),
                  _BuildBottomPickerItem(
                    pickerItemType: _PickerItemType.county,
                    key: ValueKey("county"),
                  )
                ]));
          },
        );
      },
    );
  }
}

class _BuildBottomPicker extends StatelessWidget {
  final List<Widget> pickerList;

  const _BuildBottomPicker({Key key, this.pickerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 400,
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: pickerList),
          ),
        ),
      ),
    );
  }
}

class _BuildBottomPickerItem extends StatelessWidget {
  List<String> options;
  int initialItem;
  Function onSelectedItemChanged;
  final _PickerItemType pickerItemType;

  _BuildBottomPickerItem({
    Key key,
    this.pickerItemType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<EditAddressPageModel>(
      builder: (BuildContext context, EditAddressPageModel editAddressPageModel,
          Widget child) {
        switch (pickerItemType) {
          case _PickerItemType.province:
            options = editAddressPageModel.provinceOptions;
            initialItem = editAddressPageModel.choiceProvinceIndex;
            onSelectedItemChanged = (int index) {
              editAddressPageModel.setProvince = index;
            };
            break;
          case _PickerItemType.city:
            options = editAddressPageModel.cityOptions;
            initialItem = editAddressPageModel.choiceCityIndex;
            onSelectedItemChanged = (int index) {
              editAddressPageModel.setCity = index;
            };
            break;
          case _PickerItemType.county:
            options = editAddressPageModel.countyOptions;
            initialItem = editAddressPageModel.choiceCountyIndex;
            onSelectedItemChanged = (int index) {
              editAddressPageModel.setCounty = index;
            };
            break;
        }
        return Container(
          width: MediaQuery.of(context).size.width * 0.28,
          child: CupertinoPicker(
            magnification: 1.0,
            // 整体放大率
            //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
            scrollController:
                FixedExtentScrollController(initialItem: initialItem),
            // 用于读取和控制当前项的FixedxtentScrollController
            itemExtent: ScreenUtil().setWidth(80),
            // 所以子节点 统一高度
            backgroundColor: CupertinoColors.white,
            // 所有子节点下面的背景颜色
            useMagnifier: true,
            // 是否使用放大效果
            onSelectedItemChanged: (int index) {
              // 当正中间选项改变时的回调
              onSelectedItemChanged(index);
            },
            children: List<Widget>.generate(options.length, (int index) {
              return Center(
                child: Text(
                  options[index],
                  style: TextStyle(fontSize: ScreenUtil().setWidth(26)),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _UpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer3<UserInfoModel, AddressListModel, EditAddressPageModel>(
      builder: (BuildContext context,
          UserInfoModel userInfoModel,
          AddressListModel addressListModel,
          EditAddressPageModel editAddressPageModel,
          _) {
        return RaisedButton(
          child: Text(
            "确认更新",
            style: TextStyle(color: Colors.white),
          ),
          shape: StadiumBorder(
              side: new BorderSide(
            style: BorderStyle.none,
          )),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            MyLoading.eject();
            try {
              bool result = await editAddressPageModel
                  .updateAddress(userInfoModel.userInfo.user_token);
              MyLoading.shut();
              if (result) {
                MyLoading.eject();
                await addressListModel.init(
                    userToken: userInfoModel.userInfo.user_token);
                MyLoading.shut();
                Application.router.pop(context);
              }
            } catch (e) {
              print(e);
              MyLoading.shut();
            }
          },
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer3<UserInfoModel, AddressListModel, EditAddressPageModel>(
      builder: (BuildContext context,
          UserInfoModel userInfoModel,
          AddressListModel addressListModel,
          EditAddressPageModel editAddressPageModel,
          _) {
        return RaisedButton(
          child: Text(
            "删除",
            style: TextStyle(color: Colors.white),
          ),
          shape: StadiumBorder(
              side: new BorderSide(
            style: BorderStyle.none,
          )),
          color: Colors.red,
          onPressed: () async {
            MyLoading.eject();
            try {
              bool result = await editAddressPageModel.deleteAddress(
                  userToken: userInfoModel.userInfo.user_token,
                  addressItemList: addressListModel.addressList);
              MyLoading.shut();
              if (result) {
                MyLoading.eject();
                await addressListModel.init(
                    userToken: userInfoModel.userInfo.user_token);
                MyLoading.shut();
                Application.router.pop(context);
                //Navigator.of(context).pushNamedAndRemoveUntil('/write_order',ModalRoute.withName('/'),);
              }
            } catch (e) {
              print(e);
              MyLoading.shut();
            }
          },
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer3<UserInfoModel, AddressListModel, EditAddressPageModel>(
      builder: (BuildContext context,
          UserInfoModel userInfoModel,
          AddressListModel addressListModel,
          EditAddressPageModel editAddressPageModel,
          _) {
        return RaisedButton(
          child: Text(
            "确认添加",
            style: TextStyle(color: Colors.white),
          ),
          shape: StadiumBorder(
              side: new BorderSide(
            style: BorderStyle.none,
          )),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            MyLoading.eject();
            try {
              bool result = await editAddressPageModel
                  .addAddress(userInfoModel.userInfo.user_token);
              MyLoading.shut();
              if (result) {
                MyLoading.eject();
                await addressListModel.init(
                    userToken: userInfoModel.userInfo.user_token);
                MyLoading.shut();
                Application.router.pop(context);
              }
            } catch (e) {
              print(e);
              MyLoading.shut();
            }
          },
        );
      },
    );
  }
}

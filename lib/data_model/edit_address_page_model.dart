import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/addressItem.dart';
import 'package:ganglong_shop_app/models/addressOptionsItem.dart';
import 'package:ganglong_shop_app/models/addressOptionsList.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:ganglong_shop_app/request/post_add_address.dart';
import 'package:ganglong_shop_app/request/post_delete_address.dart';
import 'package:ganglong_shop_app/request/post_update_address.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditAddressPageModel with ChangeNotifier {
  AddressItem _addressItem;
  String _editType = "add";
  List<AddressOptionsItem> _addressOptionsList;

  AddressItem get addressItem => _addressItem;

  List<String> get provinceOptions {
    if (_addressOptionsList == null) return [];
    List<String> _provinceOptions = [];
    _addressOptionsList.forEach((AddressOptionsItem addressOptionsItem) {
      _provinceOptions.add(addressOptionsItem.label);
    });
    return _provinceOptions;
  }

  int get choiceProvinceIndex {
    if (_addressOptionsList == null) return 0;

    int index = _addressOptionsList.indexWhere(
      (AddressOptionsItem item) =>
          (item.value == '${_addressItem.area_code.substring(0, 2)}0000'),
    );

    return index == -1 ? 0 : index;
  }

  String get choiceProvince {
    if (_addressOptionsList == null) return "";
    return _addressOptionsList[choiceProvinceIndex].label;
  }

  set setProvince(int index) {
    String provinceCode = _addressOptionsList[index].value;
    _addressItem.area_code = "${provinceCode.substring(0, 2)}0101";
    notifyListeners();
  }

  List<String> get cityOptions {
    if (_addressOptionsList == null) return [];
    List<String> _provinceOptions = [];
    _addressOptionsList[choiceProvinceIndex]
        .children
        .forEach((AddressOptionsItem addressOptionsItem) {
      _provinceOptions.add(addressOptionsItem.label);
    });
    return _provinceOptions;
  }

  int get choiceCityIndex {
    if (_addressOptionsList == null) return 0;

    int index = _addressOptionsList[choiceProvinceIndex].children.indexWhere(
        (AddressOptionsItem item) =>
            (item.value == '${addressItem.area_code.substring(0, 4)}00'));
    return index == -1 ? 0 : index;
  }

  String get choiceCity {
    if (_addressOptionsList == null) return "";
    return _addressOptionsList[choiceProvinceIndex]
        .children[choiceCityIndex]
        .label;
  }

  set setCity(int index) {
    String cityCode =
        _addressOptionsList[choiceProvinceIndex].children[index].value;
    _addressItem.area_code = "${cityCode.substring(0, 4)}01";
    notifyListeners();
  }

  List<String> get countyOptions {
    if (_addressOptionsList == null) return [];
    List<String> _provinceOptions = [];
    _addressOptionsList[choiceProvinceIndex]
        .children[choiceCityIndex]
        .children
        .forEach((AddressOptionsItem addressOptionsItem) {
      _provinceOptions.add(addressOptionsItem.label);
    });
    return _provinceOptions;
  }

  int get choiceCountyIndex {
    if (_addressOptionsList == null) return 0;

    int index = _addressOptionsList[choiceProvinceIndex]
        .children[choiceCityIndex]
        .children
        .indexWhere(
            (AddressOptionsItem item) => (item.value == addressItem.area_code));
    return index == -1 ? 0 : index;
  }

  String get choiceCounty {
    if (_addressOptionsList == null) return "";
    return _addressOptionsList[choiceProvinceIndex]
        .children[choiceCityIndex]
        .children[choiceCountyIndex]
        .label;
  }

  set setCounty(int index) {
    _addressItem.area_code = _addressOptionsList[choiceProvinceIndex]
        .children[choiceCityIndex]
        .children[index]
        .value;
    notifyListeners();
  }

  set setName(String name) {
    this.addressItem.name = name;
  }

  set setTel(String tel) {
    this.addressItem.tel = tel;
  }

  set setDetail(String detail) {
    this.addressItem.address_detail = detail;
  }

  EditAddressPageModel(
      {@required AddressItem addressItem, @required String editType}) {
    _addressItem = addressItem;
    _editType = editType;
    _loadAddressOptions();
    if (_editType == 'add') {
      _addressItem.area_code = '110101';
      _addressItem.name = "";
      _addressItem.tel = "";
      _addressItem.address_detail = "";
    }
  }

  _loadAddressOptions() async {
    String addressOptionsJson =
        await rootBundle.loadString('static_jsons/address_options.json');
    AddressOptionsList addressOptionsList =
        AddressOptionsList.fromJson(jsonDecode(addressOptionsJson));
    _addressOptionsList = addressOptionsList.data;

    notifyListeners();
  }

  Future<bool> updateAddress(String userToken) async {
    if (_editType != 'update') return false;

    if (!checkPhoneNumber(addressItem.tel)) return false;
    if (!checkName(addressItem.name)) return false;
    if (addressItem.address_detail == null ||
        addressItem.address_detail.isEmpty) {
      MyToast.showToast(msg: "详细地址填写不符合规范"); //短提示
      return false;
    }

    addressItem.province = choiceProvince;
    addressItem.city = choiceCity;
    addressItem.county = choiceCounty;

    await PostUpdateAddress.post(
        userToken: userToken, addressItem: addressItem);

    return true;
  }

  Future<bool> deleteAddress(
      {String userToken, List<AddressItem> addressItemList}) async {
    if (_editType != 'update') return false;

    if (addressItemList.length < 2) {
      MyToast.showToast(msg: "这已经是您最后一个地址了~~"); //短提示
      return false;
    }

    await PostDeleteAddress.post(
        userToken: userToken, addressItem: addressItem);

    return true;
  }

  Future<bool> addAddress(String userToken) async {
    if (_editType != 'add') return false;

    if (!checkPhoneNumber(addressItem.tel)) return false;
    if (!checkName(addressItem.name)) return false;
    if (addressItem.address_detail == null ||
        addressItem.address_detail.isEmpty) {
      MyToast.showToast(msg: "详细地址填写不符合规范"); //短提示
      return false;
    }
    addressItem.province = choiceProvince;
    addressItem.city = choiceCity;
    addressItem.county = choiceCounty;

    await PostAddAddress.post(userToken: userToken, addressItem: addressItem);

    return true;
  }
}

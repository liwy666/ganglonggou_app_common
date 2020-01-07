import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/addressItem.dart';
import 'package:flutter_app/models/addressList.dart';
import 'package:flutter_app/request/fetch_user_address.dart';

class AddressListModel with ChangeNotifier {
  List<AddressItem> _addressList = [];

  AddressItem get defaultAddress =>
      _addressList.firstWhere((AddressItem item) => (item.is_default == 1),
          orElse: () => null);

  List<AddressItem> get addressList => _addressList;

  /*初始化*/
  Future init({@required String userToken}) async {
    AddressList _addressListTemp =
        await FetchUserAddress.fetch(userToken: userToken)
          ..data;
    _addressList = _addressListTemp.data;
    notifyListeners();
  }
}

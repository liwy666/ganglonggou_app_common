import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/addressItem.dart';
import 'package:flutter_app/models/addressList.dart';
import 'package:flutter_app/request/fetch_user_address.dart';

class AddressListModel with ChangeNotifier {
  AddressList _addressList = AddressList();

  AddressItem get defaultAddress => _addressList != null
      ? _addressList.data
          .firstWhere((AddressItem item) => (item.is_default == 1),orElse: ()=>null)
      : null;

  AddressList get addressList => _addressList;

  /*初始化*/
  Future init({@required String userToken}) async {
    _addressList = await FetchUserAddress.fetch(userToken: userToken);
    notifyListeners();
  }
}

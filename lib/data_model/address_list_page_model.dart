import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/addressItem.dart';
import 'package:ganglong_shop_app/models/addressList.dart';
import 'package:ganglong_shop_app/request/post_switch_default_address.dart';

class AddressListPageModel with ChangeNotifier {
  List<AddressItem> _addressList = [];

  List<AddressItem> get addressList => _addressList;

  Future<bool> switchDefaultAddress({String userToken, int addressId}) async {
    return await PostSwitchDefaultAddress.post(
        userToken: userToken, addressId: addressId);
  }
}

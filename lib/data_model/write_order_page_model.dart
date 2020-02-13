import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/cart_data_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_invoice_open.dart';
import 'package:ganglong_shop_app/request/fetch_pay_type_list.dart';
import 'package:ganglong_shop_app/request/fetch_user_have_coupon_list.dart';
import 'package:ganglong_shop_app/request/post_write_order.dart';

class WriteOrderPageModel with ChangeNotifier {
  PayTypeList _payTypeList;
  CouponList _couponList;
  double _selectionCartListAllPrice = 0;
  List<CartItem> _selectionCartList;
  List<CouponItem> _allowCouponList = [];
  final List<Map<String, dynamic>> _invoiceList = [
    {"name": '不开票', "list": [], "isChoice": true},
    {
      "name": '电子发票',
      "list": [
        {
          "name": '个人',
          "widgetList": [TelephoneInput()],
          "isChoice": false
        },
        {
          "name": '企业',
          "widgetList": [
            TelephoneInput(),
            CompanyNameInput(),
            TaxNumberInput()
          ],
          "isChoice": false
        }
      ],
      "isChoice": false,
    },
    {
      "name": '专票',
      "list": [
        {
          "name": '企业',
          "widgetList": [
            CompanyNameInput(),
            TaxNumberInput(),
            InvoiceAddressInput(),
            FixedPhoneNumberInput(),
            BankNameInput(),
            BankNumberInput(),
          ],
          "isChoice": false
        }
      ],
      "isChoice": false,
    }
  ];

  int _choiceCouponId = 0;
  int _useIntegralNumber = 0;
  int _userHaveIntegralNumber = 0;
  int _selectionCartListAllIntegral = 0;

  PayTypeList get payTypeList => _payTypeList;

  PayTypeItem get choicePayType {
    return _payTypeList != null
        ? _payTypeList.data.firstWhere(
            (PayTypeItem payTypeItem) => (payTypeItem.is_choice == true))
        : null;
  }

  ByStagesItem get choiceByStages {
    final int choicePayTypeIndex = _payTypeList != null
        ? _payTypeList.data.indexWhere(
            (PayTypeItem payTypeItem) => (payTypeItem.is_choice == true))
        : null;

    return choicePayTypeIndex != null
        ? _payTypeList.data[choicePayTypeIndex].ByStages.firstWhere(
            (ByStagesItem byStagesItem) => (byStagesItem.is_choice == true))
        : null;
  }

  List<Map<String, dynamic>> get invoiceList => _invoiceList;

  Map<String, dynamic> get choiceInvoice {
    return _invoiceList
        .firstWhere((Map<String, dynamic> item) => (item["isChoice"] == true));
  }

  Map<String, dynamic> get choiceInvoiceHead {
    Map<String, dynamic> choiceInvoice = _invoiceList
        .firstWhere((Map<String, dynamic> item) => (item["isChoice"] == true));
    return choiceInvoice["list"]
        .firstWhere((Map<String, dynamic> item) => (item["isChoice"] == true));
  }

  List<CouponItem> get allowCouponList => _allowCouponList;

  int get choiceCouponId => _choiceCouponId;

  int get useIntegralNumber => _useIntegralNumber;

  double get couponPrice {
    CouponItem couponItem = _couponList != null && _couponList.data.length > 0
        ? _couponList.data.firstWhere(
            (CouponItem e) => (e.coupon_id == _choiceCouponId),
            orElse: () => null)
        : null;

    return couponItem == null ? 0.0 : double.parse(couponItem.cut_sum);
  }

  double get integralPrice {
    return double.parse((this._useIntegralNumber / 100).toString());
  }

  double get payTypePrice {
    double byStagesFee = 1.00;
    if (this.choiceByStages != null) {
      byStagesFee = double.parse(this.choiceByStages.bystages_fee);
    }

    return (_selectionCartListAllPrice -
        (couponPrice + integralPrice) -
        (_selectionCartListAllPrice - (couponPrice + integralPrice)) *
            byStagesFee);
  }

  double get orderPrice {
    return _selectionCartListAllPrice -
        (couponPrice + integralPrice + payTypePrice);
  }

  int get allowUseIntegral {
    return _userHaveIntegralNumber >= _selectionCartListAllIntegral
        ? _selectionCartListAllIntegral
        : _userHaveIntegralNumber;
  }

  int get userHaveIntegralNumber => _userHaveIntegralNumber;

  String _invoicePhoneNumber = "";
  String _invoiceCompanyName = "";
  String _invoiceTaxNumber = "";
  String _invoiceAddress = "";
  String _invoicefixedPhoneNumber = "";
  String _invoicebankName = "";
  String _invoicebankNumber = "";

  set setPhoneNumber(String phoneNumber) {
    this._invoicePhoneNumber = phoneNumber;
  }

  set setCompanyName(String companyName) {
    this._invoiceCompanyName = companyName;
  }

  set setTaxNumber(String taxNumber) {
    this._invoiceTaxNumber = taxNumber;
  }

  set setInvoiceAddress(String invoiceAddress) {
    this._invoiceAddress = invoiceAddress;
  }

  set setFixedPhoneNumber(String fixedPhoneNumber) {
    this._invoicefixedPhoneNumber = fixedPhoneNumber;
  }

  set setBankName(String bankName) {
    this._invoicebankName = bankName;
  }

  set setBankNumber(String bankNumber) {
    this._invoicebankNumber = bankNumber;
  }

  set setUseIntegralNumber(int useIntegralNumber) {
    this._useIntegralNumber = useIntegralNumber;
    notifyListeners();
  }

  /*获取支付列表*/
  Future getPayType({String userToken}) async {
    _payTypeList = await FetchPayTypeList.fetch(userToken: userToken);
  }

  /*获取优惠券列表*/
  Future getCouponList({String userToken}) async {
    _couponList = await FetchUserHaveCouponList.fetch(userToken: userToken);
  }

  void init(
      {@required CartDataModel cartDataModel, @required UserInfo userInfo}) {
    //赋值订单价格
    this._selectionCartListAllPrice =
        double.parse(cartDataModel.selectionCartListAllPrice);
    this._selectionCartList = cartDataModel.selectionCartList;
    //赋值持有积分数量
    this._userHaveIntegralNumber = userInfo.integral;
    this._selectionCartListAllIntegral =
        cartDataModel.selectionCartListAllIntegral;

    //初始化支付选中状态
    _payTypeList.data.forEach((PayTypeItem payTypeItem) {
      payTypeItem.is_choice = false;
      payTypeItem.ByStages.forEach((ByStagesItem byStagesItem) {
        byStagesItem.is_choice = false;
      });
    });
    //支付默认选中
    _payTypeList?.data[0].is_choice = true;
    _payTypeList?.data[0].ByStages[0].is_choice = true;

    //查询可用优惠券
    if (_couponList.data.length > 0) {
      _screenCouponList(cartDataModel: cartDataModel);
    }

    notifyListeners();
  }

  /*切换支付类型*/
  void switchPayType(PayTypeItem choicePayTypeItem) {
    final int choicePayTypeItemIndex = _payTypeList.data
        .indexWhere((PayTypeItem e) => (e.pay_id == choicePayTypeItem.pay_id));

    _payTypeList.data.forEach((PayTypeItem payTypeItem) {
      payTypeItem.is_choice = false;
      payTypeItem.ByStages.forEach((ByStagesItem byStagesItem) {
        byStagesItem.is_choice = false;
      });
    });

    _payTypeList.data[choicePayTypeItemIndex].is_choice = true;
    _payTypeList.data[choicePayTypeItemIndex].ByStages[0].is_choice = true;

    notifyListeners();
  }

  /*切换分期选项*/
  void switchByStages(ByStagesItem choiceByStagesItem) {
    final int choicePayTypeIndex = _payTypeList.data
        .indexWhere((PayTypeItem e) => (e.pay_id == choicePayType.pay_id));

    final int choiceByStagesIndex = _payTypeList
        .data[choicePayTypeIndex].ByStages
        .indexWhere((ByStagesItem e) =>
            (e.bystages_id == choiceByStagesItem.bystages_id));

    _payTypeList.data[choicePayTypeIndex].ByStages
        .forEach((ByStagesItem byStagesItem) {
      byStagesItem.is_choice = false;
    });

    _payTypeList.data[choicePayTypeIndex].ByStages[choiceByStagesIndex]
        .is_choice = true;

    notifyListeners();
  }

  /*切换发票类型*/
  void switchInvoiceType(String invoiceTypeName) {
    final int index = _invoiceList
        .indexWhere((Map<String, dynamic> e) => (e["name"] == invoiceTypeName));

    _invoiceList.forEach((Map<String, dynamic> item) {
      item["isChoice"] = false;
      if (item["list"].length > 0) {
        item["list"].forEach((Map<String, dynamic> sonItem) {
          sonItem["isChoice"] = false;
        });
      }
    });

    _invoiceList[index]["isChoice"] = true;
    if (_invoiceList[index]["list"].length > 0) {
      _invoiceList[index]["list"][0]["isChoice"] = true;
    }
    notifyListeners();
  }

  /*切换发票抬头*/
  void switchInvoiceHead(String invoiceHeadName) {
    final int typeIndex = _invoiceList
        .indexWhere((Map<String, dynamic> e) => (e["isChoice"] == true));

    final int headIndex = _invoiceList[typeIndex]["list"]
        .indexWhere((Map<String, dynamic> e) => (e["name"] == invoiceHeadName));

    _invoiceList[typeIndex]["list"].forEach((Map<String, dynamic> sonItem) {
      sonItem["isChoice"] = false;
    });

    _invoiceList[typeIndex]["list"][headIndex]["isChoice"] = true;

    notifyListeners();
  }

  /*筛选可用优惠券*/
  void _screenCouponList({@required CartDataModel cartDataModel}) {
    //1.检查是否符合优惠券使用金额
    _couponList.data.forEach((CouponItem couponItem) {
      if (double.parse(couponItem.found_sum) <=
          double.parse(cartDataModel.selectionCartListAllPrice)) {
        _allowCouponList.add(couponItem);
      }
    });

    if (_allowCouponList.length < 1) return;

    //2.检测类型是否符合
    cartDataModel.selectionCartList.forEach((CartItem cartItem) {
      for (int i = 0; i < _allowCouponList.length; i++) {
        if (_allowCouponList[i].grant_type == 'all') {
          continue;
        } else if (_allowCouponList[i].grant_type == 'classify' &&
            _allowCouponList[i].classify.indexOf(cartItem.catId) != -1) {
          continue;
        } else if (_allowCouponList[i].grant_type == 'solo' &&
            _allowCouponList[i].solo.indexOf(cartItem.goodsId) != -1) {
          continue;
        }
        _allowCouponList.removeWhere((CouponItem couponItem) =>
            (couponItem.coupon_id == _allowCouponList[i].coupon_id));
      }
    });
  }

  /*切换优惠券*/
  void switchCoupon(int couponId) {
    if (couponId == _choiceCouponId) {
      _choiceCouponId = 0;
    } else {
      _choiceCouponId = couponId;
    }
    notifyListeners();
  }

  /*提交订单*/
  Future<String> submitOrder(String userToken) async {
    Map<String, dynamic> submitInfo = {};
    submitInfo["user_token"] = userToken;
    submitInfo["pay_id"] = choicePayType.pay_id;
    submitInfo["bystages_id"] = choiceByStages.bystages_id;
    submitInfo["coupon_id"] = choiceCouponId;
    submitInfo["use_integral_number"] = useIntegralNumber;
    //检查开票信息
    if (choiceInvoice["name"] != "不开票") {
      switch ("${choiceInvoice["name"]}${choiceInvoiceHead["name"]}") {
        case "电子发票个人":
          if (!checkInvoicePhoneNumber(_invoicePhoneNumber)) {
            return null;
          }
          break;
        case "电子发票企业":
          if (!checkInvoicePhoneNumber(_invoicePhoneNumber) ||
              !checkInvoiceCompanyName(_invoiceCompanyName) ||
              !checkInvoiceTaxNumber(_invoiceTaxNumber)) {
            return null;
          }
          break;
        case "专票企业":
          if (!checkInvoiceCompanyName(_invoiceCompanyName) ||
              !checkInvoiceTaxNumber(_invoiceTaxNumber) ||
              !checkInvoiceAddress(_invoiceAddress) ||
              !checkInvoiceFixedPhoneNumber(_invoicefixedPhoneNumber) ||
              !checkInvoiceBankName(_invoicebankName) ||
              !checkInvoiceBankNumber(_invoicebankNumber)) {
            return null;
          }
          break;
      }
    }
    submitInfo["invoice_info"] = {};
    submitInfo["invoice_info"]["invoice_type"] = choiceInvoice["name"];
    submitInfo["invoice_info"]["invoice_head"] =
        choiceInvoice["name"] == "不开票" ? "" : choiceInvoiceHead["name"];
    submitInfo["invoice_info"]["invoice_phone"] = _invoicePhoneNumber;
    submitInfo["invoice_info"]["invoice_qymc"] = _invoiceCompanyName;
    submitInfo["invoice_info"]["invoice_nsrsbh"] = _invoiceTaxNumber;
    submitInfo["invoice_info"]["invoice_kpdz"] = _invoiceAddress;
    submitInfo["invoice_info"]["invoice_zj"] = _invoicefixedPhoneNumber;
    submitInfo["invoice_info"]["invoice_khh"] = _invoicebankName;
    submitInfo["invoice_info"]["invoice_yhzh"] = _invoicebankNumber;
    //商品列表
    if (_selectionCartList.length < 1) return null;
    submitInfo["goods_list"] = [];
    _selectionCartList.forEach((CartItem cartItem) {
      Map<String, dynamic> _goodsListItem = {
        "goods_number": cartItem.goodsNumber,
        "goods_id": cartItem.goodsId,
        "sku_id": cartItem.skuId,
      };
      submitInfo["goods_list"].add(_goodsListItem);
    });

    String orderSn = await PostWriteOrder.post(submitInfo);

    return orderSn;
  }
}

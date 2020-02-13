export 'package:flutter/material.dart';
export 'package:ganglong_shop_app/http.dart';

//入口名称
import 'package:fluttertoast/fluttertoast.dart';

const bool DEBUG = true;
const String INTO_TYPE = 'wx';
const String SON_INTO_TYPE = 'android';
//工行图标地址
const String SON_FIRST_PAGE_ICBC_ICON = "https://mate.ganglonggou.com/lib/images/wx_icbc_icon_20190813.png";
//优惠券图标地址
const String SON_FIRST_PAGE_COUPONS_ICON = "https://mate.ganglonggou.com/lib/images/wx_conpou_icon_20190813.png";
//工行地址
const String ICBC_URL = "https://m.mall.icbc.com.cn/mobile/mobileStroe/index.jhtml?shopId=026386";
//首页头部背景图地址
const String SON_FIRST_PAGE_HEAD_BACKGROUND_IMG_URL =
    'static_images/wx_first_top1_20200208.jpg';
//首页顶部轮播图背景地址
const String SON_FIRST_PAGE_SWIPER_BACKGROUND_IMG_URL =
    'static_images/wx_first_top2_20200208.png';
//首页其他店铺单个背景图
const String SON_FIRST_PAGE_OTHER_SHOP_ITEM_BACKGROUND_IMG_URL =
    'static_images/ketlle_goods_b1.jpg';
//常规数据缓存时效(ms)(6小时)
const int COMMON_SQL_DATA_INVALID_TIME = 21600000;
//积分名称
const String INTEGRAL_NAME = "岗隆积分";
//userToken长度
const int USER_TOKEN_LENGTH = 32;
//个人中心序号
const int HOME_INDEX = 4;
//订单号长度
const int ORDER_SN_LENGTH = 16;
//底部栏高度
const double MY_BOTTOM_BUTTON_HEIGHT = 100.0;
//公司名称缩写
const String COMPANY_NAME_ABBREVIATION = "岗隆";
//关于微信
const String WECHAT_APPID = 'wxaea0312f1b660706';
const String WECHAT_FRIEND_SHARE_URL =
    'https://mate.ganglonggou.com/wx-ganglonggou/?gl_goods_id=';
const String WECHAT_PAY_PACKAGE = 'Sign=WXPay';
//关于字体尺寸
const double BEST_LARGE_FONT_SIZE = 26.0;
const double VERY_LARGE_FONT_SIZE = 20.0;
const double SO_LARGE_FONT_SIZE = 18.0;
const double LARGE_FONT_SIZE = 16.0;
const double COMMON_FONT_SIZE = 14.0;
const double SMALL_FONT_SIZE = 12.0;
const double SO_SMALL_FONT_SIZE = 10.0;
//关于圆角大小
const double RADIUS_COMMON_VALUE = 10;
//联系客服链接
const String CONTACT_CUSTOMER_SERVICE_URL =
    "https://p.qiao.baidu.com/cps2/mobileChat?siteId=11040705&userId=24298402&type=1&reqParam=&appId=&referer=";
//联系客服电话
const String CONTACT_CUSTOMER_SERVICE_TElPHONE_NUMBER = "400-828-2323";
//DES
const DES_KEY = 'P36lrz6fLmHqb3kx';
const DES_VI = '65412398';
//支付宝
const String ALIPAY_APPID = '2017110609764829';
const String ALIPAY_PID = '2088521082559676';
const String ALIPAY_TARGETID = '1574405082';
const bool ALIPAY_USE_RSA2 = true;
//顺丰快递查询
const String SF_LOGISTICS_QUERY_URL =
    'https://www.sf-express.com/mobile/cn/sc/dynamic_functions/waybill/detail/';
const String YZXB_LOGISTICS_QUERY_URL = 'https://m.ickd.cn/result.html#no=';
//其它快递查询
const String COMMON_LOGISTICS_QUERY_URL =
    'https://m.kuaidi100.com/result.jsp?nu=';
//app名称
const String APP_NAME = '岗隆数码';
//用户协议地址
const String USER_AGREEMENT_URL =
    'https://mate.ganglonggou.com/app_web_extend/agreement/userAgreement.html';
//隐私协议
const String PRIVACY_AGREEMENT_URL =
    'https://mate.ganglonggou.com/app_web_extend/agreement/privacyAgreement.html';
//关于我们
const String ABOUT_WE_URL =
    'https://mate.ganglonggou.com/app_web_extend/#/about';
//反馈
const String FEED_BACK_URL =
    'https://mate.ganglonggou.com/app_web_extend/#/feedback';

List<T> listDeepCopy<T>(List list) {
  if (list.length == 0 || list == null) return [];
  List<T> _tempList = [];
  list.forEach((item) {
    _tempList.add(item);
  });

  return _tempList;
}

bool checkPhoneNumber(String phoneNumber) {
  RegExp mobile = new RegExp(
      r"(0|86|17951)?(13[0-9]|15[0-35-9]|17[0678]|18[0-9]|14[57])[0-9]{8}");
  if (phoneNumber.isEmpty || !mobile.hasMatch(phoneNumber)) {
    Fluttertoast.showToast(msg: "填写的手机号不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkName(String name) {
  RegExp mobile = new RegExp(r"(^[\u4E00-\u9FA5]{2,6}$)");
  if (name.isEmpty || !mobile.hasMatch(name)) {
    Fluttertoast.showToast(msg: "填写的姓名不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkInvoicePhoneNumber(String phoneNumber) {
  RegExp mobile = new RegExp(
      r"(0|86|17951)?(13[0-9]|15[0-35-9]|17[0678]|18[0-9]|14[57])[0-9]{8}");
  if (phoneNumber == null ||
      phoneNumber.isEmpty ||
      !mobile.hasMatch(phoneNumber)) {
    Fluttertoast.showToast(msg: "发票信息：填写的手机号不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkInvoiceCompanyName(String name) {
  if (name == null || name.isEmpty) {
    Fluttertoast.showToast(msg: "发票信息：填写的企业名称不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkInvoiceTaxNumber(String number) {
  if (number.length != 15 && number.length != 18 && number.length != 20) {
    Fluttertoast.showToast(msg: "发票信息：纳税人识别号不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkInvoiceAddress(String name) {
  if (name == null || name.isEmpty) {
    Fluttertoast.showToast(msg: "发票信息：开票地址不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkInvoiceFixedPhoneNumber(String name) {
  if (name == null || name.isEmpty) {
    Fluttertoast.showToast(msg: "发票信息：座机号不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkInvoiceBankName(String name) {
  if (name == null || name.isEmpty) {
    Fluttertoast.showToast(msg: "发票信息：开户行不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkInvoiceBankNumber(String name) {
  if (name == null || name.isEmpty) {
    Fluttertoast.showToast(msg: "发票信息：银行账户不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkEmailAddress(String emailAddress) {
  RegExp mobile =
      new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
  if (emailAddress == null ||
      emailAddress.isEmpty ||
      !mobile.hasMatch(emailAddress)) {
    Fluttertoast.showToast(msg: "填写的邮箱地址不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkPasswordHard(String password) {
  RegExp mobile = new RegExp(r"(^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$)");
  if (password == null || password.isEmpty || !mobile.hasMatch(password)) {
    Fluttertoast.showToast(msg: "填写的密码强度不符合规范"); //短提示
    return false;
  }

  return true;
}

bool checkUserName(String userName) {
  RegExp mobile = new RegExp(r"(^([^#$@/\\()<>{}[\] ]){5,20}$)");
  if (userName == null || userName.isEmpty || !mobile.hasMatch(userName)) {
    Fluttertoast.showToast(msg: "用户名不符合规范"); //短提示
    return false;
  }

  return true;
}

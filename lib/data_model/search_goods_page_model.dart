import 'dart:convert';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/models/searchLogItem.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/request/fetch_search_log.dart';
import 'package:ganglong_shop_app/request/post_add_search_keyword.dart';
import 'package:ganglong_shop_app/sqflite_model/search_log_sqflite.dart';

class SearchGoodsPageModel with ChangeNotifier {
  List<SearchKeywordItem> _searchKeywordList = [];
  List<SearchLogItem> _searchLogItemList = [];
  String _searchKeyword = "";
  final int userId;

  SearchGoodsPageModel({@required this.userId});

  List<SearchKeywordItem> get searchKeywordList => _searchKeywordList;

  List<SearchLogItem> get searchLogItemList => _searchLogItemList;

  String get searchKeyword => _searchKeyword;

  set setSearchKeyWord(String val) {
    if (val.length <= 30) {
      _searchKeyword = val;
    }
    //notifyListeners();
  }

  Future<void> init() async {
    SearchKeywordList searchKeywordList = await FetchSearchLog.fetch();
    _searchKeywordList = searchKeywordList.data;
    List<Map<String, dynamic>> searchLogMap =
        await SearchLogSqFlite().queryUserAllSearchLog(userId);
    _searchLogItemList = searchLogMap.map((Map<String, dynamic> map) {
      return SearchLogItem.fromJson(map);
    }).toList();
    notifyListeners();
  }

  void cleanSearchKeyword() {
    _searchKeyword = "";
    notifyListeners();
  }

  ///开始搜索
  Future<void> startSearch(BuildContext context) async {
    if (_searchKeyword.isEmpty) return;
    MyLoading.eject();
    try {
      await PostAddSearchKeyword.post(searchKeyword: _searchKeyword);
      await SearchLogSqFlite()
          .insertUserSearchLog(searchWord: _searchKeyword, userId: userId);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
      Navigator.popAndPushNamed(context,
          'search_goods_complete?keyword=${base64UrlEncode(utf8.encode(_searchKeyword))}');
    }
  }

  ///清空搜索记录
  Future<void> cleanSearchLog() async {
    MyLoading.eject();
    try {
      await SearchLogSqFlite().cleanUserSearchLog(userId);
      _searchLogItemList.clear();
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }
}

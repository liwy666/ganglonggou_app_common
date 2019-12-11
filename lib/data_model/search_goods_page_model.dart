import 'dart:convert';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/request/fetch_search_log.dart';
import 'package:flutter_app/request/post_add_search_keyword.dart';
import 'package:flutter_app/routes/application.dart';

class SearchGoodsPageModel with ChangeNotifier {
  List<SearchKeywordItem> _searchKeywordList = [];
  String _searchKeyword = "";

  List<SearchKeywordItem> get searchKeywordList => _searchKeywordList;

  String get searchKeyword => _searchKeyword;

  set setSearchKeyWord(String val) {
    if (val.length <= 30) {
      _searchKeyword = val;
    }
    notifyListeners();
  }

  SearchGoodsPageModel() {
    FetchSearchLog.fetch().then((SearchKeywordList searchKeywordList) {
      _searchKeywordList = searchKeywordList.data;
      notifyListeners();
    });
  }

  void cleanSearchKeyword() {
    _searchKeyword = "";
    notifyListeners();
  }

  void startSearch(BuildContext context) {
    if (_searchKeyword.isEmpty) return;
    PostAddSearchKeyword.post(searchKeyword: _searchKeyword);

    Navigator.popAndPushNamed(context,
        'search_goods_complete?keyword=${base64UrlEncode(utf8.encode(_searchKeyword))}');
  }
}

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/cartItem.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';
import 'package:flutter_app/sqflite_model/sqlfite_config.dart';

class SearchLogSqFlite extends BaseSqflite {
  static String _tableName = SEARCH_LOG_TABLE_NAME;

  @override
  Future insertAllDate<T>(List<T> mapAllDate) {
    // TODO: implement insertAllDate
    return null;
  }

  @override
  Future insertData(Map<String, dynamic> mapDate) {
    // TODO: implement insertData
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() {
    // TODO: implement queryAll
    return null;
  }

  ///返回当前用户所有搜索历史
  Future<List<Map<String, dynamic>>> queryUserAllSearchLog(int userId) async {
    // TODO: implement queryAll
    List<Map<String, dynamic>> list =
        await BaseSqflite.db.query(_tableName, where: "user_id=$userId");
    return list;
  }

  ///插入搜索记录
  Future<void> insertUserSearchLog(
      {@required String searchWord, @required int userId}) async {
    //判断是否存在历史
    List<Map<String, dynamic>> list = await BaseSqflite.db.query(_tableName,
        where: "user_id=$userId and search_keyword='$searchWord'");
    if (list.length == 0) {
      await BaseSqflite.db.insert(
          _tableName, {"user_id": userId, "search_keyword": searchWord});
    }
  }

  ///清空用户搜索记录
  Future<void> cleanUserSearchLog(int userId) async {
    await BaseSqflite.db.delete(_tableName, where: "user_id=$userId");
  }
}

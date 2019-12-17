import 'package:flutter_app/sqflite_model/base_sqflite.dart';
import 'package:flutter_app/sqflite_model/sqlfite_config.dart';

import '../common_import.dart';

class ClassifySqflite extends BaseSqflite {
  final String _tableName = CLASSIFY_TABLE_NAME;

  @override
  insertData(Map<String, dynamic> mapDate) async {
    // TODO: implement insertData
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    // TODO: implement queryAll
    List<Map<String, dynamic>> list = await BaseSqflite.db.query(_tableName);
    return list;
  }

  @override
  Future insertAllDate<T>(List<T> mapAllDate) async {
    // TODO: implement insertAllDate
    //清空表
    await BaseSqflite.db.execute("DELETE FROM $_tableName");
    mapAllDate.forEach((T item) async {
      Map<String, dynamic> itemMap = (item as Map);
      BaseSqflite.db.insert(_tableName, itemMap);
    });
    //修改失效时间
    BaseSqflite.db.update(
        CONFIG_TABLE_NAME,
        {
          "config_value": (DateTime.now().millisecondsSinceEpoch +
              COMMON_SQL_DATA_INVALID_TIME)
        },
        where: 'config_key=\'classify_list_invalid_time\'');
  }
}

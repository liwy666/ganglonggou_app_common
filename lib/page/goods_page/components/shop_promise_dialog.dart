import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_model.dart';
import 'package:flutter_app/page/components/my_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ShopPromiseDialog extends StatelessWidget {
  final List<Map<String, dynamic>> textArray = [
    {"title": "原装正品", "lable": "正规渠道，全新原装", "icon": Icons.star},
    {"title": "电子发票", "lable": "根据国家政策，开具电子发票", "icon": Icons.payment},
    {"title": "专业服务商", "lable": "岗隆已服务千万级客户", "icon": Icons.thumb_up},
    {"title": "顺丰速运", "lable": "配送更快更优", "icon": Icons.airplanemode_active},
    {"title": "7天无理由", "lable": "未激活、无人为损坏不影响二次销售", "icon": Icons.alarm_on},
    {"title": "全国联保", "lable": "全国联保，国家三包", "icon": Icons.verified_user},
    {
      "title": "售后无忧",
      "lable": "专业售后团队让您的数码产品用得更加舒心和顺心",
      "icon": Icons.supervisor_account
    },
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil().setWidth(800),
            child: ListView(
              children: textArray.map<Widget>((Map<String, dynamic> item) {
                return MyCell(
                  title: item["title"],
                  label: item["lable"],
                  icon: item["icon"],
                );
              }).toList(),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.red,
              shape: StadiumBorder(
                  side: new BorderSide(
                style: BorderStyle.none,
              )),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "确定",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SMALL_FONT_SIZE,
                  ),
                ),
              ),
            ),
          ), //按钮,
        ],
      ),
    );
  }
}

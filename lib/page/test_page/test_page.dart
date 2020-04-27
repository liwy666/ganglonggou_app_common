import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/routes/application.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyTabBar(
        tabBarName: '实验室',
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        children: <Widget>[
          MySingleRowTile(
            onTapFunction: () async {
              Application.router.navigateTo(context, '/boot');
            },
            child: Text("启动页测试"),
          ),
          MySingleRowTile(
            onTapFunction: () async {
              Application.router.navigateTo(context, '/main');
            },
            child: Text("启动首页"),
          ),
          MySingleRowTile(
            onTapFunction: () async {
              Application.router.navigateTo(context, '/test_animation');
            },
            child: Text("动画页"),
          ),
        ],
      ),
    );
  }
}

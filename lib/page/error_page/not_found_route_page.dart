import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/components/my_page_tips.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';

class NotFoundRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyTabBar(
        tabBarName: '错误',
      ),
      body: Center(
          child: MyPageTips(
            title: '没有找到页面',
            imgRoute: 'static_images/browser-404.png',
          )),
    );
  }
}

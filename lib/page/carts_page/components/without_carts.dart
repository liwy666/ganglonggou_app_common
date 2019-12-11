import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/page/components/my_page_tips.dart';

class WithoutCarts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
      child: MyPageTips(
        imgRoute: "static_images/without_carts.png",
        title: "购物车是空的",
      ),
    );
  }
}

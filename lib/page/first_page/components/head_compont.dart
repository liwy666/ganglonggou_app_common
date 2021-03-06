import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/classify_list_ad_model.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HeadComponent extends StatefulWidget implements PreferredSizeWidget {
  TabController tabController;

  HeadComponent({this.tabController});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HeadComponent();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}

class _HeadComponent extends State<HeadComponent> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(SON_FIRST_PAGE_HEAD_BACKGROUND_IMG_URL),
              fit: BoxFit.cover)),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width, //屏幕宽度
        minHeight: ScreenUtil().setWidth(150),
      ),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //搜索框
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.search, color: Colors.grey),
                        Text(
                          "请输入搜索关键词",
                          style: TextStyle(
                              color: Colors.grey, fontSize: SMALL_FONT_SIZE),
                        )
                      ],
                    ),
                  )),
            ),
            onTap: () {
              Application.router.navigateTo(context, '/search_goods');
            },
          ),
          //顶部Tab
          Consumer(
              builder: (context, ClassifyListDataModel classifyListModel, _) {
            return Container(
                child: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: SMALL_FONT_SIZE),
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: TextStyle(fontSize: SMALL_FONT_SIZE),
              controller: widget.tabController,
              tabs: classifyListModel.headComponentTabs.map((tab) {
                return Tab(
                  text: tab,
                );
              }).toList(),
            ));
          }),
        ],
      ),
    );
  }
}

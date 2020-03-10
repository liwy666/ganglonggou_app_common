import 'package:ganglong_shop_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyList extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final List list;
  final Function scrollBottomFunction;
  final Function buildItemWidget;
  final bool isLoading;
  final bool isFinish;

  MyList(
      {@required this.list,
      @required this.scrollBottomFunction,
      @required this.buildItemWidget,
      @required this.isFinish,
      @required this.isLoading});

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        this.scrollBottomFunction();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (scrollController.position.maxScrollExtent == 0) {
        this.scrollBottomFunction();
      }
    });
    // TODO: implement build
    return ListView.builder(
        controller: this.scrollController,
        itemCount: this.list.length + 1,
        //列表长度+底部加载中提示
        itemBuilder: (BuildContext context, int index) {
          if (index < this.list.length) {
            return buildItemWidget(index);
          } else if (this.isLoading) {
            return _LoadList();
          } else if (this.isFinish) {
            return _LoadFinish();
          } else {
            return null;
          }
        });
    /* return*/
  }
}

class _LoadList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black54),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "加载中...",
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenUtil().setWidth(24)),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadFinish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Text(
        "—— 加载完毕 ——",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';
import 'package:ganglong_shop_app/page/components/my_goods_list/my_goods_list_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class MyGoodsList extends StatefulWidget {
  ScrollController scrollController;
  List<GoodsItem> initialGoodsList;
  final List<Widget> headWidgetList;

  MyGoodsList(
      {Key key,
      @required this.scrollController,
      @required this.initialGoodsList,
      @required this.headWidgetList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyGoodsList();
  }
}

class _MyGoodsList extends State<MyGoodsList> {
  List<GoodsItem> _goodsList = [];
  List<GoodsItem> _tempGoodsList = [];
  int _initialGoodsListLength;
  int _limit = 8; //每次加载数据条数
  int waitSecond = 300; //等待时间
  bool _isLoading = false; //是否正在请求新数据
  bool _isFinish = false; //数据是否加载完成

  @override
  void didUpdateWidget(MyGoodsList oldWidget) {
    if (oldWidget.initialGoodsList != widget.initialGoodsList) {
      _init();
    }
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _initialGoodsListLength = widget.initialGoodsList.length;
    widget.scrollController.addListener(() {
//      print(
//          "当前：${widget.scrollController.position.pixels}，最大：${widget.scrollController.position.maxScrollExtent}");
      if (widget.scrollController.position.maxScrollExtent -
              widget.scrollController.position.pixels <=
          10) {
        _scrollBottomFunction();
      }
    });
    _init();
    // TODO: implement initState
    super.initState();
  }

  void _init() {
    _tempGoodsList = listDeepCopy<GoodsItem>(widget.initialGoodsList);
    //print("MyGoodsList的init方法_tempGoodsList长度：${_tempGoodsList.length}");
    if (_initialGoodsListLength <= _limit) {
      _isFinish = true;
      _goodsList = _tempGoodsList;
      setState(() {});
    } else {
      _goodsList = _tempGoodsList.getRange(0, _limit).toList();
      _tempGoodsList.removeRange(0, _limit);
      _isLoading = false; //是否正在请求新数据
      _isFinish = false; //数据是否加载完成
      setState(() {});
    }
  }

  Future<void> _scrollBottomFunction() async {
    if (!this._isFinish && !this._isLoading) {
      this._isLoading = true;
      setState(() {});
      await Future.delayed(Duration(milliseconds: waitSecond));
      if (_goodsList.length + _limit >= _initialGoodsListLength) {
        _isFinish = true;
        _goodsList.addAll(_tempGoodsList);
      } else {
        _goodsList.addAll(_tempGoodsList.getRange(0, _limit));
        _tempGoodsList.removeRange(0, _limit);
      }
      this._isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(widget.headWidgetList),
        ),
        _MainGoodsList(
          goodsList: _goodsList,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _isLoading ? _LoadList() : Container(),
            _isFinish ? _LoadFinish() : Container(),
          ]),
        ),
      ],
    );
  }
}

class _MainGoodsList extends StatelessWidget {
  final List<GoodsItem> goodsList;

  const _MainGoodsList({Key key, @required this.goodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(goodsList[0].goods_name);
    // TODO: implement build
    return AnimationLimiter(
      child: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            childAspectRatio: 337 / 450),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            child: ScaleAnimation(
              //verticalOffset: 80.0,
              child: MyGoodsListCard(
                item: goodsList[index],
                index: index,
              ),
            ),
            columnCount: 2,
            duration: const Duration(milliseconds: 600),
          );
          //MyGoodsListCard(item: goodsList[index]);
        }, childCount: goodsList.length),
      ),
    );
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
              style:
                  TextStyle(color: Colors.black54, fontSize: COMMON_FONT_SIZE),
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
        style: TextStyle(color: Colors.black54, fontSize: COMMON_FONT_SIZE),
      ),
    );
  }
}


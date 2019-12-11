import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_list_data_model.dart';
import 'package:flutter_app/data_model/page_position_model.dart';
import 'package:flutter_app/models/goodsItem.dart';
import 'package:flutter_app/page/components/contain_head_goods_list.dart';
import 'package:flutter_app/page/components/my_page_tips.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:provider/provider.dart';

class SearchGoodsCompletePage extends StatelessWidget {
  final String keyword;
  final bool showKeyword;

  const SearchGoodsCompletePage(
      {Key key, @required this.keyword, this.showKeyword = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<PagePositionModel>(
      model: PagePositionModel(),
      child: AppBar(
        primary: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: _SearchBox(
          keyword: keyword,
          showKeyword: showKeyword,
        ),
      ),
      builder: (BuildContext context, PagePositionModel pagePositionModel,
          Widget _child) {
        return Scaffold(
          appBar: _child,
          body: Consumer<GoodsListDataModel>(
            builder: (BuildContext context,
                GoodsListDataModel goodsListDareModel, _) {
              List<GoodsItem> _tempGoodsList =
                  goodsListDareModel.getGoodsListByKeyWord(keyWord: keyword);
              return _tempGoodsList.length > 0
                  ? ContainHeadGoodsList(
                      initialGoodsList: _tempGoodsList,
                      scrollController: pagePositionModel.controller,
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            MyPageTips(
                              title: "没有找到相关宝贝",
                              imgRoute:
                                  "static_images/without_search_goods.png",
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
          floatingActionButton: pagePositionModel.showToTopBtn
              ? FloatingActionButton(
                  child: pagePositionModel.floatingActionButtonChild,
                  onPressed: () {
                    pagePositionModel.toTop();
                  },
                  foregroundColor: Colors.white,
                  heroTag: "search_goods_complete_page",
                )
              : null,
        );
      },
    );
  }
}

class _SearchBox extends StatelessWidget with PreferredSizeWidget {
  final String keyword;
  final bool showKeyword;

  _SearchBox({Key key, @required this.keyword, @required this.showKeyword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 3),
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: SMALL_FONT_SIZE,
            ),
            onPressed: () {
              Application.router.pop(context);
            },
            constraints: BoxConstraints(minWidth: 0),
          ),
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.search, color: Colors.grey),
                        Text(
                          "${showKeyword ? keyword : '请输入搜索关键词'}",
                          style: TextStyle(
                              color: showKeyword ? Colors.black87 : Colors.grey,
                              fontSize: SMALL_FONT_SIZE),
                        )
                      ],
                    ),
                  )),
            ),
            onTap: () {
              Application.router.navigateTo(context, '/search_goods');
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(0);
}

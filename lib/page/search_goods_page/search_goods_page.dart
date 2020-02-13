import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/search_goods_page_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/searchKeywordItem.dart';
import 'package:ganglong_shop_app/models/searchLogItem.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_options_align.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchGoodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Consumer<UserInfoModel>(
      builder: (BuildContext context, UserInfoModel userInfoModel, _) {
        return ProviderWidget<SearchGoodsPageModel>(
          child: Scaffold(
              backgroundColor: _themeModel.pageBackgroundColor1,
              primary: true,
              appBar: AppBar(
                primary: false,
                automaticallyImplyLeading: false,
                elevation: 0,
                bottom: _SearchBox(),
              ),
              body: ListView(
                children: <Widget>[
                  _HotSearchAlign(),
                  _LogSearchAlign(),
                ],
              )),
          onWidgetReady: (SearchGoodsPageModel searchGoodsPageModel) async {
            MyLoading.eject();
            try {
              searchGoodsPageModel.init();
            } catch (e) {
              print(e);
            } finally {
              MyLoading.shut();
            }
          },
          model: SearchGoodsPageModel(
              userId:
                  userInfoModel.isLogon ? userInfoModel.userInfo.user_id : 0),
          builder: (BuildContext context,
              SearchGoodsPageModel searchGoodsPageModel, Widget _child) {
            return _child;
          },
        );
      },
    );
  }
}

class _SearchBox extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
        bottom: 3,
      ),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Consumer<SearchGoodsPageModel>(
                builder: (BuildContext context,
                    SearchGoodsPageModel searchGoodsPageModel, _) {
                  return TextField(
                    scrollPadding: EdgeInsets.all(0),
                    autofocus: true,
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            // 设置内容
                            text: searchGoodsPageModel.searchKeyword,
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: searchGoodsPageModel
                                    .searchKeyword.length)))),
                    textInputAction: TextInputAction.search,
                    style: TextStyle(fontSize: SMALL_FONT_SIZE),
                    onChanged: (String val) {
                      searchGoodsPageModel.setSearchKeyWord = val;
                    },
                    onEditingComplete: () {
                      searchGoodsPageModel.startSearch(context);
                    },
                    decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.person),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "请输入搜索关键词",
                        isDense: true,
                        /*    contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),*/
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        suffixIcon:
                            searchGoodsPageModel.searchKeyword.length > 0
                                ? GestureDetector(
                                    child: Icon(
                                      Icons.cancel,
                                      size: COMMON_FONT_SIZE,
                                    ),
                                    onTap: () {
                                      searchGoodsPageModel.cleanSearchKeyword();
                                    },
                                  )
                                : null),
                  );
                },
              )),
          Consumer<SearchGoodsPageModel>(
            builder: (BuildContext context,
                SearchGoodsPageModel searchGoodsPageModel, _) {
              return RawMaterialButton(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  "搜索",
                  style:
                      TextStyle(fontSize: SMALL_FONT_SIZE, color: Colors.white),
                ),
                constraints: BoxConstraints(minWidth: 0, minHeight: 0),
                onPressed: () {
                  searchGoodsPageModel.startSearch(context);
                },
              );
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

class _HotSearchAlign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: Consumer<SearchGoodsPageModel>(
        builder: (BuildContext context,
            SearchGoodsPageModel searchGoodsPageModel, _) {
          return MyOptionsAlign(
            itemList: searchGoodsPageModel.searchKeywordList
                .map((SearchKeywordItem searchKeywordItem) {
              return MyOptionsAlignItem(
                itemValue: searchKeywordItem.search_keyword,
                onTap: () {
                  searchGoodsPageModel.setSearchKeyWord =
                      searchKeywordItem.search_keyword;
                  searchGoodsPageModel.startSearch(context);
                },
                isChoice: false,
              );
            }).toList(),
            title: "热门推荐",
          );
        },
      ),
    );
  }
}

class _LogSearchAlign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Consumer<SearchGoodsPageModel>(
      builder:
          (BuildContext context, SearchGoodsPageModel searchGoodsPageModel, _) {
        return Column(
          //padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyOptionsAlign(
              itemList: searchGoodsPageModel.searchLogItemList
                  .map((SearchLogItem searchLogItem) {
                return MyOptionsAlignItem(
                  itemValue: searchLogItem.search_keyword,
                  onTap: () {
                    searchGoodsPageModel.setSearchKeyWord =
                        searchLogItem.search_keyword;
                    searchGoodsPageModel.startSearch(context);
                  },
                  isChoice: false,
                );
              }).toList(),
              title: "搜索历史",
            ),
           searchGoodsPageModel.searchLogItemList.length>0?Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               FlatButton(
                 child: Text(
                   "清空搜索历史",
                   style: TextStyle(
                       fontSize: SMALL_FONT_SIZE, color: _themeModel.fontColor2),
                 ),
                 onPressed: () {
                   MyDialog().showConfirmDialog(
                       context: context,
                       title:
                       "确认清除全部历史记录吗？",
                       clickFun: searchGoodsPageModel.cleanSearchLog,
                       cancelButtonText: "取消",
                       confirmButtonText: "删除");

                 },
               )
             ],
           ):Container(),
          ],
        );
      },
    );
  }
}

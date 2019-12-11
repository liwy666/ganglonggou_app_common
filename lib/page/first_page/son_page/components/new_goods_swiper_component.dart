import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/first_page_model.dart';
import 'package:flutter_app/data_model/index_ad_list_data_model.dart';
import 'package:flutter_app/data_model/son_first_page_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/first_page/son_page/components/first_title_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class NewGoodsSwiperComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        FirstTitleComponent(
          textColor: Colors.red,
          firstText: "新品",
          lastText: "尝鲜",
        ),
        Consumer2<SonFirstPageModel, IndexAdListDataModel>(
          builder: (context, SonFirstPageModel sonFirstPageModel,
              IndexAdListDataModel indexAdListDataModel, _) {
            return Container(
                height: sonFirstPageModel.newGoodsSwiperHeight,
                child: Swiper(
                  itemCount: indexAdListDataModel.newGoodsList.length,
                  onTap: (int index) {
                    FirstPageModel.toControl(
                        indexAdItem: indexAdListDataModel.newGoodsList[index],
                        context: context);
                  },
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: _NewGoodsSwiperComponentItem(
                        item: indexAdListDataModel.newGoodsList[index],
                        updateHeight: (double itemHeight) {
                          sonFirstPageModel
                              .updateNewGoodsSwiperHeight(itemHeight);
                        },
                        updateHeightFlag:
                            sonFirstPageModel.newGoodsSwiperUpdateHeightFlag,
                      ),
                    );
                  },
                  viewportFraction: 0.4,
                  scale: 0.8,
                ));
          },
        ),
      ],
    );
  }
}

class _NewGoodsSwiperComponentItem extends StatelessWidget {
  final IndexAdItem item;
  final Function updateHeight;
  bool updateHeightFlag;

  _NewGoodsSwiperComponentItem({
    Key key,
    @required this.item,
    @required this.updateHeight,
    @required this.updateHeightFlag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (updateHeightFlag) {
      WidgetsBinding.instance.addPostFrameCallback((callback) {
        updateHeight(context.size.height + 5);
      });
    }

    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setWidth(16),
          horizontal: ScreenUtil().setWidth(20)),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(230),
            child: Image.network(item.ad_img, fit: BoxFit.fitHeight),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
            constraints: BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Text(
              item.goods_name,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SMALL_FONT_SIZE,
              ),
            ),
          ),
          Container(
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
              child: Text(
                "￥${item.goods_price}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: COMMON_FONT_SIZE,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(5)),
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Text(
                "￥${item.origin_goods_price}",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: SMALL_FONT_SIZE,
                    decoration: TextDecoration.lineThrough),
              )),
        ],
      ),
    );
  }
}

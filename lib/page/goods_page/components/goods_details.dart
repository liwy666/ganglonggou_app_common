import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class GoodsDetails extends StatefulWidget {
  final ScrollController scrollController;

  const GoodsDetails({Key key, @required this.scrollController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GoodsDetails();
  }
}

class _GoodsDetails extends State<GoodsDetails> {
  GoodsModel _goodsModel;
  bool _show = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _goodsModel = Provider.of<GoodsModel>(context);
      widget.scrollController.addListener(() {
        if (widget.scrollController.offset >=
                _goodsModel.widgetOffset["described"] - 500 &&
            !_show) {
          setState(() {
            _show = true;
          });
        }
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<GoodsModel>(
      builder: (BuildContext context, GoodsModel goodsModel, _) {
        return _show
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(
                          bottom: index + 1 == goodsModel.goodsDetails.length
                              ? ScreenUtil().setWidth(100)
                              : 0),
                      child: MyExtendedImage.network(
                        goodsModel.goodsDetails[index],
                        fit: BoxFit.fitWidth,
                        loadingWidth: MediaQuery.of(context).size.width,
                        loadingHeight: MediaQuery.of(context).size.width,
                      ),
                    );
                  },
                  childCount: goodsModel.goodsDetails.length,
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(100),
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase,
                        color: Colors.orange,
                      ),
                    );
                  },
                  childCount: 2,
                ),
              );
      },
    );
  }
}

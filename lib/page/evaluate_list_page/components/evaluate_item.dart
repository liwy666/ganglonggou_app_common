import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/evaluate_list_model.dart';
import 'package:flutter_app/models/goodsEvaluateItem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EvaluateItem extends StatelessWidget {
  final int index;

  EvaluateItem({@required this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Consumer<EvaluateListModel>(
          builder:
              (BuildContext context, EvaluateListModel evaluateListModel, _) {
            GoodsEvaluateItem evaluateItem =
                evaluateListModel.getGoodsEvaluateItem(index);
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          width: ScreenUtil().setWidth(100),
                          child: Image.network(
                            evaluateItem.user_img,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Text(
                          evaluateItem.user_name,
                          style: TextStyle(
                              fontSize: ScreenUtil().setWidth(20),
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Text(
                      evaluateItem.create_time,
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(20),
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(evaluateItem.evaluate_text,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(24),
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      )),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "购买规格：${evaluateItem.sku_desc}",
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(20),
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "评分：",
                            style: TextStyle(
                              fontSize: ScreenUtil().setWidth(20),
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                          SmoothStarRating(
                            starCount: 5,
                            rating: evaluateItem.rate.toDouble(),
                            size: ScreenUtil().setWidth(25),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

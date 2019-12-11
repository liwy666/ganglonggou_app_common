import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/evaluate_list_model.dart';
import 'package:flutter_app/page/components/my_list.dart';
import 'package:flutter_app/page/components/my_page_tips.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/page/evaluate_list_page/components/evaluate_item.dart';
import 'package:flutter_app/provider/provider_widget.dart';

class EvaluateListPage extends StatelessWidget {
  final int goodsId;

  EvaluateListPage({@required this.goodsId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<EvaluateListModel>(
      model: EvaluateListModel(goodsId: this.goodsId),
      builder: ((BuildContext context, EvaluateListModel evaluateListModel, _) {
        return Scaffold(
          appBar: MyTabBar(
            tabBarName: "商品评价",
          ),
          body: evaluateListModel.goodsEvaluateList.length > 0
              ? MyList(
                  buildItemWidget: buildItemWidget,
                  scrollBottomFunction: evaluateListModel.fetchEvaluateList,
                  list: evaluateListModel.goodsEvaluateList,
                  isLoading: evaluateListModel.isLoading,
                  isFinish: evaluateListModel.isFinish,
                )
              : Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Center(
                    child: MyPageTips(
                      title: '暂时还没有评价',
                      imgRoute: 'static_images/without_evaluate.png',
                    ),
                  ),
                ),
        );
      }),
    );
    ;
  }

  Widget buildItemWidget(int index) {
    return EvaluateItem(
      index: index,
    );
  }
}

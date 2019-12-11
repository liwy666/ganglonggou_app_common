import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/write_order_page_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_app/page/components/my_options_align.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WriteOrderPayTypeOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Consumer<WriteOrderPageModel>(
        builder:
            (BuildContext context, WriteOrderPageModel writeOrderPageModel, _) {
          return Container(
            height: ScreenUtil().setWidth(650),
            child: ListView(children: [
              MyOptionsAlign(
                itemList: _getPayWidgetList(writeOrderPageModel),
                title: "支付类型",
              ),
              MyOptionsAlign(
                itemList: _getByStagesWidgetList(writeOrderPageModel),
                title: "分期类型",
              ),
            ]),
          );
        },
      ),
    );
  }

  /*获取支付类型选项组件列*/
  List<MyOptionsAlignItem> _getPayWidgetList(
      WriteOrderPageModel writeOrderPageModel) {
    return writeOrderPageModel.payTypeList?.data
        .map<MyOptionsAlignItem>((PayTypeItem payTypeItem) {
      return MyOptionsAlignItem(
        itemValue: payTypeItem.pay_name,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyExtendedImage.asset('static_images/${payTypeItem.pay_code}.png',
                width: SO_LARGE_FONT_SIZE, fit: BoxFit.fitWidth),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                payTypeItem.pay_name,
                style: TextStyle(fontSize: SMALL_FONT_SIZE),
              ),
            )
          ],
        ),
        onTap: () {
          writeOrderPageModel.switchPayType(payTypeItem);
        },
        isChoice: payTypeItem.is_choice,
      );
    }).toList();
  }

/*获取分期类型选项组件列*/
  List<MyOptionsAlignItem> _getByStagesWidgetList(
      WriteOrderPageModel writeOrderPageModel) {
    return writeOrderPageModel.choicePayType?.ByStages
        .map<MyOptionsAlignItem>((ByStagesItem byStagesItem) {
      return MyOptionsAlignItem(
        itemValue: byStagesItem.bystages_val,
        onTap: () {
          writeOrderPageModel.switchByStages(byStagesItem);
        },
        isChoice: byStagesItem.is_choice,
      );
    }).toList();
  }
}

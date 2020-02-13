import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/cart_data_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/data_model/write_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_list_tile.dart';
import 'package:ganglong_shop_app/page/components/my_stepper.dart';
import 'package:provider/provider.dart';

class WriteOrderIntegral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      child: Icon(Icons.blur_on),
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return MyListTile(
          titleWidget: Text(
              "您有${writeOrderPageModel.userHaveIntegralNumber}$INTEGRAL_NAME,本单可使用${writeOrderPageModel.allowUseIntegral}"),
          subtitleWidget: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    "使用$INTEGRAL_NAME数量:${writeOrderPageModel.useIntegralNumber}"),
                Slider(
                  divisions: writeOrderPageModel.allowUseIntegral > 0
                      ? writeOrderPageModel.allowUseIntegral
                      : 1,
                  onChanged: (double value) {
                    writeOrderPageModel.setUseIntegralNumber = value.hashCode;
                  },
                  max: double.parse(
                      writeOrderPageModel.allowUseIntegral.toString()),
                  value: double.parse(
                      writeOrderPageModel.useIntegralNumber.toString()),
                ),
              ],
            ),
          ),
          iconWidget: child,
          onTapFunction: () {},
        );
      },
    );
  }
}

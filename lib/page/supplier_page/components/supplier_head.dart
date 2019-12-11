import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/supplier_page_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      color: _themeModel.pageBackgroundColor2,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<SupplierPageModel>(
        builder:
            (BuildContext context, SupplierPageModel supplierPageModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    MyExtendedImage.network(
                      supplierPageModel.supplierPreviewInfo.logo_img,
                      width: ScreenUtil().setWidth(150),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            supplierPageModel.supplierPreviewInfo.supplier_name,
                            style: TextStyle(
                                color: _themeModel.fontColor1,
                                fontWeight: FontWeight.w800,
                                fontSize: COMMON_FONT_SIZE),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                                supplierPageModel
                                    .supplierPreviewInfo.company_name,
                                style: TextStyle(
                                    color: _themeModel.fontColor1,
                                    fontSize: SMALL_FONT_SIZE)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ), //头部
              Container(
                margin: EdgeInsets.only(top: 20),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: _themeModel.fontColor1,
                    fontSize: SMALL_FONT_SIZE,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "宝贝描述:"),
                        TextSpan(
                            text: supplierPageModel
                                .supplierPreviewInfo.describe_rate,
                            style: TextStyle(color: Colors.red)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "卖家服务:"),
                        TextSpan(
                            text: supplierPageModel
                                .supplierPreviewInfo.service_rate,
                            style: TextStyle(color: Colors.red)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "物流服务:"),
                        TextSpan(
                            text: supplierPageModel
                                .supplierPreviewInfo.logistics_rate,
                            style: TextStyle(color: Colors.red)),
                      ])),
                    ],
                  ),
                ),
              ), //评分
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "售后电话：${supplierPageModel.supplierPreviewInfo.after_sale_tel}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: SMALL_FONT_SIZE,
                        ),
                      ),
                      onPressed: () {
                        launch(
                            "tel:${supplierPageModel.supplierPreviewInfo.after_sale_tel}");
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "服务电话：${supplierPageModel.supplierPreviewInfo.service_tel}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: SMALL_FONT_SIZE,
                        ),
                      ),
                      onPressed: () {
                        launch(
                            "tel:${supplierPageModel.supplierPreviewInfo.service_tel}");
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

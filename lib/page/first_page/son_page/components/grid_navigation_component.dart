import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/classify_list_ad_model.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/classifyItem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GridNavigationComponent extends StatelessWidget {
  ThemeModel _themeModel;

  @override
  Widget build(BuildContext context) {
    _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(RADIUS_COMMON_VALUE))),
        //设置圆角
        color: _themeModel.pageBackgroundColor2,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Consumer<ClassifyListDataModel>(
              builder: ((context, ClassifyListDataModel classifyList, _) {
                return Wrap(
                  alignment: WrapAlignment.spaceAround, //沿主轴方向居中
                  children: _getCreateNavigationItemAlign(
                      classifyList: classifyList.navigationClassifyList,
                      context: context),
                );
              }),
            )),
      ),
    );
  }

  List<Widget> _getCreateNavigationItemAlign(
      {@required List<ClassifyItem> classifyList,
      @required BuildContext context}) {
    return classifyList.map((ClassifyItem item) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.95 * 0.20,
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MyExtendedImage.network(item.logo_img,
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setWidth(80)),
              Container(
                child: Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                  child: Text(
                    item.classify_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SMALL_FONT_SIZE,
                        color: _themeModel.fontColor1),
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            FirstPageModel.classToControl(classifyItem: item, context: context);
          },
        ),
      );
    }).toList();
  }
}

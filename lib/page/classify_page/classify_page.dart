import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/classify_list_ad_model.dart';
import 'package:ganglong_shop_app/data_model/classify_page_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/classifyItem.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Color _leftListBackGroundColor = Colors.white;

class ClassifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    _leftListBackGroundColor =
        _themeModel.appThemeMode == AppThemeMode.nightMode
            ? _themeModel.pageBackgroundColor1
            : _themeModel.pageBackgroundColor2;
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor2,
      body: Consumer<ClassifyListDataModel>(
        builder: (BuildContext context,
            ClassifyListDataModel classifyListDataModel, _) {
          return ProviderWidget<ClassifyPageModel>(
            model: ClassifyPageModel(
                classifyItemListTemp: classifyListDataModel.classifyList),
            builder:
                (BuildContext context, ClassifyPageModel classifyPageModel, _) {
              return Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: _themeModel.pageBackgroundColor1,
                        border: Border(
                            right: BorderSide(
                                color: Color(0xff95a5a6), width: 0.25)) //右侧悬浮
                        ),
                    child: ListView(
                      children: classifyPageModel.classifyItemList
                          .map((ClassifyItem classifyItem) {
                        return _ClassifyItem(
                          classifyItem: classifyItem,
                          isChoice: classifyItem.id ==
                              classifyPageModel.choiceClassifyItemId,
                        );
                      }).toList(),
                    ),
                  ), //左侧选择栏
                  Container(
                    color: _themeModel.pageBackgroundColor2,
                    padding: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, //横轴三个子widget
                          childAspectRatio: 1.0 //宽高比为1时，子widget
                          ),
                      children: classifyPageModel.classifyItemChildren
                          .map((ClassifyItem classifyItem) {
                        return _ClassifyChild(classifyItem: classifyItem);
                      }).toList(),
                    ),
                  ), //右侧明细栏
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _ClassifyItem extends StatelessWidget {
  final ClassifyItem classifyItem;
  final bool isChoice;
  final double itemHeight = 50.0;

  const _ClassifyItem(
      {Key key, @required this.classifyItem, @required this.isChoice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Consumer<ClassifyPageModel>(
      builder: (BuildContext context, ClassifyPageModel classifyPageModel, _) {
        return GestureDetector(
          onTap: () {
            classifyPageModel.choiceClassifyItemId = classifyItem.id;
          },
          child: Container(
            color: isChoice
                ? _themeModel.pageBackgroundColor2
                : _themeModel.pageBackgroundColor1,
            height: itemHeight,
            child: Row(
              children: <Widget>[
                Container(
                  height: itemHeight * 0.5,
                  width: 5,
                  color: isChoice
                      ? Theme.of(context).accentColor
                      : _themeModel.pageBackgroundColor1,
                  margin: EdgeInsets.only(right: 10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    classifyItem.classify_name,
                    style: TextStyle(
                        fontSize: isChoice ? SMALL_FONT_SIZE : SMALL_FONT_SIZE,
                        color: isChoice
                            ? _themeModel.themeColor
                            : _themeModel.fontColor1,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ClassifyChild extends StatelessWidget {
  final ClassifyItem classifyItem;

  const _ClassifyChild({Key key, @required this.classifyItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Consumer<ClassifyPageModel>(
      builder: (BuildContext context, ClassifyPageModel classifyPageModel, _) {
        return FlatButton(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                MyExtendedImage.network(
                  classifyItem.logo_img,
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setWidth(80),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    classifyItem.classify_name,
                    style: TextStyle(
                        fontSize: SMALL_FONT_SIZE,
                        color: _themeModel.fontColor1),
                  ),
                )
              ],
            ),
          ),
          onPressed: () {
            classifyPageModel.classifyChildClick(
                context: context, classifyItem: classifyItem);
          },
        );
      },
    );
  }
}

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/classify_list_ad_model.dart';
import 'package:flutter_app/data_model/first_page_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/classifyItem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GridNavigationComponent extends StatelessWidget {
  ThemeModel _themeModel;
  @override
  Widget build(BuildContext context) {
    _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Center(
      child: Container(
          child:  Consumer<ClassifyListDataModel>(
            builder: ((context, ClassifyListDataModel classifyList, _) {
              return Wrap(
                alignment: WrapAlignment.spaceAround, //沿主轴方向居中
                children: _getCreateNavigationItemAlign(
                    classifyList: classifyList.classifyList,
                    context: context),
              );
            }),
          )),
    );
  }

  List<Widget> _getCreateNavigationItemAlign(
      {@required List<ClassifyItem> classifyList,
      @required BuildContext context}) {
    return classifyList.map((ClassifyItem item) {
      return Container(
        width: MediaQuery.of(context).size.width*0.25,
        margin: EdgeInsets.only(top: 10),
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: NetworkImage(item.logo_img),
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setWidth(80)),
              Container(
                child: Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                  child: Text(
                    item.classify_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: SMALL_FONT_SIZE,color: _themeModel.fontColor1),
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

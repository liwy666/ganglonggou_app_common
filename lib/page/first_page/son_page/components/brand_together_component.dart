import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/first_page_model.dart';
import 'package:flutter_app/data_model/index_ad_list_data_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/first_page/son_page/components/first_title_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandTogetherComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          FirstTitleComponent(
              textColor: Colors.blue, firstText: "品牌", lastText: "惠聚"),
          Center(
            child: Container(
              width: ScreenUtil().setWidth(700),
              height: ScreenUtil().setWidth(780),
              child: Consumer<IndexAdListDataModel>(
                builder: (BuildContext context,
                    IndexAdListDataModel indexAdList, _) {
                  int i = 0;
                  return Wrap(
                    spacing: ScreenUtil().setWidth(10),
                    runSpacing: ScreenUtil().setWidth(15),
                    children:
                        indexAdList.brandTogetherList.map((IndexAdItem item) {
                      Widget brandBox;
                      if (i == 0 || i == 6) {
                        brandBox = LongBrandBox(item: item);
                      } else {
                        brandBox = ShortBrandBox(item: item);
                      }
                      i++;
                      return brandBox;
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LongBrandBox extends StatelessWidget {
  final IndexAdItem item;

  LongBrandBox({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: ScreenUtil().setWidth(458),
          height: ScreenUtil().setWidth(251),
          child: Image.network(
            item.ad_img,
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        FirstPageModel.toControl(indexAdItem: item, context: context);
      },
    );
  }
}

class ShortBrandBox extends StatelessWidget {
  final IndexAdItem item;

  ShortBrandBox({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: ScreenUtil().setWidth(226),
          height: ScreenUtil().setWidth(251),
          child: Image.network(
            item.ad_img,
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        FirstPageModel.toControl(indexAdItem: item, context: context);
      },
    );
  }
}

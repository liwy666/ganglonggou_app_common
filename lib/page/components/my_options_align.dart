import 'package:flutter_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*分组*/
class MyOptionsAlign extends StatelessWidget {
  final List<MyOptionsAlignItem> itemList;
  final String title;

  MyOptionsAlign({
    @required this.itemList,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        left: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: TextStyle(fontSize: SMALL_FONT_SIZE),
            ),
          ), //分组名称
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 5.0, // 主轴(水平)方向间距
            runSpacing: 0.0, // 纵轴（垂直）方向间距
            children: itemList,
          )
        ],
      ),
    );
  }
}

/*分组选项*/
class MyOptionsAlignItem extends StatelessWidget {
  final String itemValue;
  final Function onTap;
  final bool isChoice;
  final Widget child;

  MyOptionsAlignItem({
    @required this.itemValue,
    @required this.onTap,
    @required this.isChoice,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: FlatButton(
          child: child == null
              ? Text(
                  itemValue,
                  style: TextStyle(
                    fontSize: SMALL_FONT_SIZE,
                  ),
                )
              : child,
          disabledColor: Theme.of(context).accentColor,
          disabledTextColor: Colors.white,
          color: Color.fromRGBO(0, 0, 0, .1),
          textColor: Colors.black87,
          shape: new StadiumBorder(
              side: new BorderSide(
            style: BorderStyle.none,
          )),
          onPressed: !isChoice
              ? () {
                  onTap();
                }
              : null),
    );
  }
}

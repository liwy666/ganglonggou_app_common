import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyTabBar extends StatelessWidget with PreferredSizeWidget {
  final String tabBarName;
  final bool hideLeftButton;
  final List<Widget> actions;
  final Color backgroundColor;
  final Color tabBarNameColor;
  final PreferredSizeWidget bottom;

  MyTabBar(
      {@required this.tabBarName,
      this.hideLeftButton,
      this.actions,
      this.bottom,
      this.backgroundColor = Colors.white,
      this.tabBarNameColor = Colors.black87});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return AppBar(
      backgroundColor: _themeModel.appThemeMode == AppThemeMode.nightMode
          ? _themeModel.pageBackgroundColor2
          : backgroundColor,
      title: Text(
        tabBarName,
        style: TextStyle(
            fontSize: COMMON_FONT_SIZE,
            color: _themeModel.appThemeMode == AppThemeMode.nightMode
                ? _themeModel.fontColor1
                : tabBarNameColor),
      ),
      leading: LeftIcon(
        hideLeftButton: hideLeftButton,
      ),
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
}

class LeftIcon extends StatelessWidget {
  final bool hideLeftButton;
  final Color color;

  const LeftIcon({Key key, this.hideLeftButton, this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Opacity(
      opacity: hideLeftButton == true ? 0 : 1,
      child: FlatButton(
        child: Icon(
          Icons.chevron_left,
          color: color,
        ),
        onPressed: () => Navigator.maybePop(context),
      ),
    );
  }
}

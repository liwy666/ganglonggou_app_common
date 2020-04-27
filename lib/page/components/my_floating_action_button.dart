import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:provider/provider.dart';

class MyFloatingActionButton extends StatefulWidget {
  final String heroTag;
  final double hoverElevation;
  final ScrollController scrollController;

  const MyFloatingActionButton(
      {Key key,
      @required this.heroTag,
      this.hoverElevation = 300.0,
      @required this.scrollController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFloatingActionButton();
  }
}

class _MyFloatingActionButton extends State<MyFloatingActionButton> {
  bool showToTopBtn = false;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      setState(() {
        if (widget.scrollController.offset < 1000 && showToTopBtn) {
          showToTopBtn = false;
        } else if (widget.scrollController.offset >= 1000 &&
            showToTopBtn == false) {
          showToTopBtn = true;
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeModel _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return showToTopBtn
        ? FloatingActionButton(
            heroTag: widget.heroTag,
            child: Icon(
              Icons.arrow_upward,
              size: 15,
            ),
            foregroundColor: _themeModel.pageBackgroundColor2,
            hoverElevation: 300,
            onPressed: () {
              widget.scrollController.animateTo(0.0,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
          )
        : Container();
  }
}

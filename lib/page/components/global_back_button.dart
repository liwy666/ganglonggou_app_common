import 'dart:async';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/routes/application.dart';

class GlobalBackButton {
  static bool existButton = false;

  static void show(BuildContext context) {
    if (!existButton) {
      Timer(const Duration(milliseconds: 500), () {
        Overlay.of(context)
            ?.insert(OverlayEntry(builder: (BuildContext context) {
          existButton = true;
          return _DraggableButtonWidget();
        }));
      });
    }
  }
}

class _DraggableButtonWidget extends StatefulWidget {
  final String title;
  final Function onTap;
  final double btnSize;

  _DraggableButtonWidget({
    this.title = '返回',
    this.onTap,
    this.btnSize = 66,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return __DraggableButtonWidgetState();
  }
}

class __DraggableButtonWidgetState extends State<_DraggableButtonWidget> {
  double left = 30;
  double top = 100;
  double screenWidth;
  double screenHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    ///默认点击事件
    var tap = () {
      Application.router.pop(context);
    };
    Widget w;
    Color primaryColor = Theme.of(context).primaryColor;
    primaryColor = primaryColor.withOpacity(0.9);
    w = GestureDetector(
      onTap: widget.onTap ?? tap,
      onPanUpdate: _dragUpdate,
      child: Container(
        width: widget.btnSize,
        height: widget.btnSize,
        color: primaryColor,
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );

    ///圆形
    w = ClipRRect(
      borderRadius: BorderRadius.circular(widget.btnSize / 2),
      child: w,
    );

    ///计算偏移量限制
    if (left < 1) {
      left = 1;
    }
    if (left > screenWidth - widget.btnSize) {
      left = screenWidth - widget.btnSize;
    }

    if (top < 1) {
      top = 1;
    }
    if (top > screenHeight - widget.btnSize) {
      top = screenHeight - widget.btnSize;
    }
    w = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top),
      child: w,
    );

    return w;
  }

  _dragUpdate(DragUpdateDetails detail) {
    Offset offset = detail.delta;
    left = left + offset.dx;
    top = top + offset.dy;
    setState(() {});
  }
}

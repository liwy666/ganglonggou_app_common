import 'dart:async';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

enum MyStepperSize {
  large,
  small,
}

class MyStepper extends StatelessWidget {
  int value;
  final int min;
  final int max;
  final int step;
  final Function changeFunction;
  final MyStepperSize size;

  MyStepper(
      {@required this.value,
      this.min = 0,
      @required this.max,
      this.step = 1,
      @required this.changeFunction,
      this.size = MyStepperSize.large});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            onPressed: this.value - this.step < this.min
                ? null
                : () {
                    this.value -= this.step;
                    this.changeFunction(this.value);
                  },
            padding: EdgeInsets.all(5),
            constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
            child: Icon(
              Icons.remove,
              color: _themeModel.fontColor1,
              size: size == MyStepperSize.large
                  ? COMMON_FONT_SIZE
                  : SMALL_FONT_SIZE,
            ),
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            height: size == MyStepperSize.large
                ? ScreenUtil().setWidth(70)
                : ScreenUtil().setWidth(40),
            width: size == MyStepperSize.large
                ? ScreenUtil().setWidth(70)
                : ScreenUtil().setWidth(40),
            child: Center(
              child: Text(
                this.value.toString(),
                style: TextStyle(
                    color: _themeModel.fontColor1,
                    fontSize: size == MyStepperSize.large
                        ? COMMON_FONT_SIZE
                        : SMALL_FONT_SIZE),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          RawMaterialButton(
            onPressed: this.value + this.step > this.max
                ? null
                : () {
                    this.value += this.step;
                    this.changeFunction(this.value);
                  },
            padding: EdgeInsets.all(5),
            constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
            child: Icon(
              Icons.add,
              color: _themeModel.fontColor1,
              size: size == MyStepperSize.large
                  ? COMMON_FONT_SIZE
                  : SMALL_FONT_SIZE,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyButton extends StatelessWidget {
  final Function onTapFunction;
  final Function onLongPressFunction;
  final Widget child;
  Function onLongPressEndFunction = () {};

  _MyButton(
      {Key key,
      @required this.onTapFunction,
      @required this.onLongPressFunction,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: child,
      onTap: onTapFunction,
      onLongPress: () {
        Timer timer = Timer.periodic(Duration(milliseconds: 500), (timer1) {
          onLongPressFunction();
        });
        this.onLongPressEndFunction = () {
          //print(timer == null);
          //print(timer);
          //timer.cancel();
        };
      },
      onLongPressEnd: (_) {
        this.onLongPressEndFunction();
      },
    );
  }
}

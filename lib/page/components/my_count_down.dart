import 'dart:async';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart';

class MyCountDown extends StatefulWidget {
  final int endTime;
  final String title;
  final double width;

  const MyCountDown(
      {Key key, @required this.endTime, @required this.title, this.width})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCountDown();
  }
}

class _MyCountDown extends State<MyCountDown> {
  String days = '00';
  String hours = '00';
  String minutes = '00';
  String seconds = "00";
  Timer timer;

  @override
  void initState() {
    _refreshDate();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
        _refreshDate();
      });
    });
    // TODO: implement initState
    super.initState();
  }

  void _refreshDate() {
    int _endTime = widget.endTime * 1000;
    int _nowTime = new DateTime.now().millisecondsSinceEpoch; //获取当前时间戳(ms)
    double _leftTime = (_endTime - _nowTime) / 1000;
    if (_leftTime > 0) {
      setState(() {
        days = _forMate(_leftTime / (24 * 60 * 60));
        hours = _forMate(_leftTime / (60 * 60) % 24);
        minutes = _forMate(_leftTime / 60 % 60);
        seconds = _forMate(_leftTime % 60);
      });
    }
  }

  String _forMate(double time) {
    int _time = time.toInt();
    if (_time >= 10) {
      return _time.toString();
    } else if (_time == 0) {
      return '00';
    } else {
      return "0$_time";
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _width =
        widget.width == null ? MediaQuery.of(context).size.width : widget.width;
    // TODO: implement build
    return Container(
      width: _width,
      //height: 50,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.red, Colors.orange[700]]), //背景渐变
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontSize: SMALL_FONT_SIZE, color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: DefaultTextStyle(
              style: TextStyle(fontSize: SMALL_FONT_SIZE),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _TimeValueBoxItem(
                    value: days,
                  ),
                  _TimeLabelBoxItem(
                    value: '天',
                  ),
                  _TimeValueBoxItem(
                    value: hours,
                  ),
                  _TimeLabelBoxItem(
                    value: '时',
                  ),
                  _TimeValueBoxItem(
                    value: minutes,
                  ),
                  _TimeLabelBoxItem(
                    value: '分',
                  ),
                  _TimeValueBoxItem(
                    value: seconds,
                  ),
                  _TimeLabelBoxItem(
                    value: '秒',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeValueBoxItem extends StatelessWidget {
  final String value;

  const _TimeValueBoxItem({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(50),
      height: ScreenUtil().setWidth(50),
      color: Colors.white,
      child: Center(
        child: Text(
          value,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

class _TimeLabelBoxItem extends StatelessWidget {
  final String value;

  const _TimeLabelBoxItem({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(50),
      height: ScreenUtil().setWidth(50),
      child: Center(
        child: Text(value),
      ),
      //color: Colors.white,
    );
  }
}

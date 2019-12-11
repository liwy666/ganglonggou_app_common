import 'package:flutter_app/common_import.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCouponCard extends StatelessWidget {
  final int couponId;
  final String couponName;
  final String couponDesc;
  final String startGrantTime;
  final String endGrantTime;
  final String startUseTime;
  final String endUseTime;
  final double foundSum;
  final double cutSum;
  final int couponNumber;
  final int couponRemainderNumber;

  const MyCouponCard(
      {Key key,
      @required this.couponId,
      @required this.couponName,
      @required this.couponDesc,
      this.startGrantTime = "",
      this.endGrantTime = "",
      this.startUseTime = "",
      this.endUseTime = "",
      @required this.foundSum,
      @required this.cutSum,
      this.couponNumber,
      this.couponRemainderNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 0),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: ScreenUtil().setWidth(24), color: Colors.black54),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text.rich(TextSpan(
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenUtil().setWidth(35)),
                      children: [
                        TextSpan(
                          text: "减",
                        ),
                        TextSpan(
                          text: "$cutSum",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: "元",
                          style: TextStyle(fontSize: ScreenUtil().setWidth(18)),
                        ),
                      ])),
                ), //减多少
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "$couponName",
                    style: TextStyle(
                        fontSize: ScreenUtil().setWidth(24),
                        color: Colors.black),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16, left: 10),
              child: Row(
                children: <Widget>[
                  Text("单笔订单满$foundSum元"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: startUseTime.isEmpty
                        ? Container()
                        : Text(
                            "有效期：${startUseTime.substring(0, 10)} - ${endUseTime.substring(0, 10)}"),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                "$couponDesc",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}

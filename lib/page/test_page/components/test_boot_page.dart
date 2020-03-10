import 'package:extended_image/extended_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/start_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TestBootPage extends StatelessWidget {
  final List<String> imagesList = [
    'static_images/boot_img1.jpeg',
    'static_images/boot_img2.jpeg',
    'static_images/boot_img3.jpeg',
    'static_images/boot_img4.jpeg',
    'static_images/boot_img5.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return _BootPageItem(
                index: index,
                imagesList: imagesList,
              );
            },
            itemCount: imagesList.length,
            loop: false,
            pagination: new SwiperPagination(),
            control: new SwiperControl(),
          )),
    );
  }
}

class _BootPageItem extends StatefulWidget {
  final int index;
  final List<String> imagesList;

  _BootPageItem({Key key, @required this.index, @required this.imagesList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return __BootPageItem();
  }
}

class __BootPageItem extends State<_BootPageItem> {
  String _buttonValue = "立即体验";
  bool _clickButton = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            ExtendedImage.asset(
              widget.imagesList[widget.index],
              fit: BoxFit.fitWidth,
            ),
            widget.index == widget.imagesList.length - 1
                ? Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Text(
                              _buttonValue,
                              style: TextStyle(
                                  fontSize: SO_LARGE_FONT_SIZE,
                                  color: Theme.of(context).accentColor),
                            ),
                            _clickButton
                                ? Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: LARGE_FONT_SIZE,
                                    height: LARGE_FONT_SIZE,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.circleStrokeSpin,
                                      color: Colors.orange,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        onPressed: () async {
                          setState(() {
                            _buttonValue = "开启中";
                            _clickButton = true;
                          });
                          StartModel _startModel =
                              Provider.of<StartModel>(context);
                          await _startModel.init();
                          Navigator.popAndPushNamed(context,
                              '/main?needUpdateApp=${false}&whetherInitialInstallation=${true}');
                        },
                      ),
                    ))
                : Container()
          ],
        ));
  }
}

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';

import 'my_goods_list/my_goods_list.dart';

class ContainHeadGoodsList extends StatefulWidget {
  final List<GoodsItem> initialGoodsList;
  final ScrollController scrollController;
  final Widget headWidget;

  ContainHeadGoodsList(
      {Key key,
      @required this.initialGoodsList,
      @required this.scrollController,
      this.headWidget})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContainHeadGoodsList();
  }
}

class _ContainHeadGoodsList extends State<ContainHeadGoodsList> {
  bool _comprehensiveIsChoice = true;
  bool _priceIsChoice = false;
  bool _volumeIsChoice = false;
  bool _newIsChoice = false;
  bool _risePrice = true;
  List<GoodsItem> _tempGoodsList = [];

  @override
  void initState() {
    _tempGoodsList = _getComprehensiveGoods();
    // TODO: implement initState
    super.initState();
  }

  List<GoodsItem> _getComprehensiveGoods() {
    if (widget.initialGoodsList.length == 0) return [];
    List<GoodsItem> _initialGoodsList = [];
    widget.initialGoodsList.forEach((item) {
      _initialGoodsList.add(item);
    });
    for (int i = 0; i < _initialGoodsList.length; i++) {
      for (int j = 0; j < _initialGoodsList.length - i - 1; j++) {
        if ((_initialGoodsList[j].goods_sales_volume +
                _initialGoodsList[j].evaluate_count) <
            (_initialGoodsList[j + 1].goods_sales_volume +
                _initialGoodsList[j + 1].evaluate_count)) {
          GoodsItem max = _initialGoodsList[j];
          _initialGoodsList[j] = _initialGoodsList[j + 1];
          _initialGoodsList[j + 1] = max;
        }
      }
    }
    return _initialGoodsList;
  }

  List<GoodsItem> _getPriceGoods() {
    if (widget.initialGoodsList.length == 0) return [];
    List<GoodsItem> _initialGoodsList = [];
    widget.initialGoodsList.forEach((item) {
      _initialGoodsList.add(item);
    });
    for (int i = 0; i < _initialGoodsList.length; i++) {
      for (int j = 0; j < _initialGoodsList.length - i - 1; j++) {
        if (_risePrice) {
          if (double.parse(_initialGoodsList[j].shop_price) <
              double.parse(_initialGoodsList[j + 1].shop_price)) {
            GoodsItem max = _initialGoodsList[j];
            _initialGoodsList[j] = _initialGoodsList[j + 1];
            _initialGoodsList[j + 1] = max;
          }
        } else {
          if (double.parse(_initialGoodsList[j].shop_price) >
              double.parse(_initialGoodsList[j + 1].shop_price)) {
            GoodsItem max = _initialGoodsList[j];
            _initialGoodsList[j] = _initialGoodsList[j + 1];
            _initialGoodsList[j + 1] = max;
          }
        }
      }
    }
    return _initialGoodsList;
  }

  List<GoodsItem> _getVolumeGoods() {
    if (widget.initialGoodsList.length == 0) return [];
    List<GoodsItem> _initialGoodsList = [];
    widget.initialGoodsList.forEach((item) {
      _initialGoodsList.add(item);
    });
    for (int i = 0; i < _initialGoodsList.length; i++) {
      for (int j = 0; j < _initialGoodsList.length - i - 1; j++) {
        if (_initialGoodsList[j].goods_sales_volume <
            _initialGoodsList[j + 1].goods_sales_volume) {
          GoodsItem max = _initialGoodsList[j];
          _initialGoodsList[j] = _initialGoodsList[j + 1];
          _initialGoodsList[j + 1] = max;
        }
      }
    }
    return _initialGoodsList;
  }

  List<GoodsItem> _getNewGoods() {
    if (widget.initialGoodsList.length == 0) return [];
    List<GoodsItem> _initialGoodsList = [];
    widget.initialGoodsList.forEach((item) {
      _initialGoodsList.add(item);
    });
    for (int i = 0; i < _initialGoodsList.length; i++) {
      for (int j = 0; j < _initialGoodsList.length - i - 1; j++) {
        if (_initialGoodsList[j].add_time < _initialGoodsList[j + 1].add_time) {
          GoodsItem max = _initialGoodsList[j];
          _initialGoodsList[j] = _initialGoodsList[j + 1];
          _initialGoodsList[j + 1] = max;
        }
      }
    }
    return _initialGoodsList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyGoodsList(
      scrollController: widget.scrollController,
      initialGoodsList: _tempGoodsList,
      headWidgetList: <Widget>[
        widget.headWidget == null? Container():widget.headWidget,
        Container(
//      padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.only(bottom: 8),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _HeadOption(
                iconData: Icons.apps,
                value: "综合",
                isChoice: _comprehensiveIsChoice,
                onPressed: () {
                  setState(() {
                    _comprehensiveIsChoice = true;
                    _priceIsChoice = false;
                    _volumeIsChoice = false;
                    _newIsChoice = false;
                    _tempGoodsList = _getComprehensiveGoods();
                  });
                },
              ),
              _HeadOption(
                iconData: _risePrice ? Icons.call_made : Icons.call_received,
                value: "价格",
                isChoice: _priceIsChoice,
                onPressed: () {
                  setState(() {
                    bool _tempBool = _priceIsChoice;
                    if (_tempBool) {
                      _risePrice = !_risePrice;
                    }
                    _comprehensiveIsChoice = false;
                    _priceIsChoice = true;
                    _volumeIsChoice = false;
                    _newIsChoice = false;
                    _tempGoodsList = _getPriceGoods();
                  });
                },
              ),
              _HeadOption(
                iconData: Icons.trending_up,
                value: "销量",
                isChoice: _volumeIsChoice,
                onPressed: () {
                  setState(() {
                    _comprehensiveIsChoice = false;
                    _priceIsChoice = false;
                    _volumeIsChoice = true;
                    _newIsChoice = false;
                    _tempGoodsList = _getVolumeGoods();
                  });
                },
              ),
              _HeadOption(
                iconData: Icons.fiber_new,
                value: "新品",
                isChoice: _newIsChoice,
                onPressed: () {
                  setState(() {
                    _comprehensiveIsChoice = false;
                    _priceIsChoice = false;
                    _volumeIsChoice = false;
                    _newIsChoice = true;
                    _tempGoodsList = _getNewGoods();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeadOption extends StatelessWidget {
  final IconData iconData;
  final String value;
  final bool isChoice;
  final Function onPressed;

  _HeadOption(
      {Key key,
      @required this.iconData,
      @required this.value,
      @required this.isChoice,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Icon(
              iconData,
              color: isChoice ? Theme.of(context).accentColor : Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isChoice ? COMMON_FONT_SIZE : SMALL_FONT_SIZE,
              color: isChoice ? Theme.of(context).accentColor : Colors.black87,
            ),
          )
        ],
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}

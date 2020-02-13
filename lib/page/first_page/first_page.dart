import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/classify_list_ad_model.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/page_position_model.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:provider/provider.dart';
import 'components/head_compont.dart';

class FirstPage extends StatefulWidget {
  final int classifyListLength;
  final List<Widget> firstPageClassifyPage;

  FirstPage(
      {Key key,
      @required this.classifyListLength,
      @required this.firstPageClassifyPage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FirstPage();
  }
}

class _FirstPage extends State<FirstPage> with TickerProviderStateMixin {
  TabController _tabController;
  TabBarView _barView;

  @override
  void initState() {
    _tabController = TabController(
        initialIndex: 0, length: widget.classifyListLength, vsync: this);
    _barView = TabBarView(
      controller: _tabController,
      children: widget.firstPageClassifyPage,
      physics: NeverScrollableScrollPhysics(),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FirstPageModel>(
      model: FirstPageModel(),
      child: Scaffold(
        appBar: HeadComponent(tabController: _tabController),
        body: _barView,
      ),
      builder: (BuildContext context, FirstPageModel firstPageModel, Widget child) {
        return child;
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

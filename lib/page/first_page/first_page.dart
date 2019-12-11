import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/classify_list_ad_model.dart';
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
    return Scaffold(
      appBar: HeadComponent(tabController: _tabController),
      body: _barView,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

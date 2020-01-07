import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/web_view_page_model.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class WebViewPage extends StatelessWidget {
  final String initialLink;
  final String title;

  const WebViewPage({Key key, @required this.initialLink, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<WebViewPageModel>(
      model: WebViewPageModel(),
      builder: (BuildContext context, WebViewPageModel webViewPageModel, _) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                child: Icon(
                  Icons.close,
                ),
                onTap: () {
                  Application.router.pop(context);
                },
              ),
              elevation: 1,
              title: Text(
                title == null ? webViewPageModel.webTitle : title,
                style: TextStyle(fontSize: COMMON_FONT_SIZE),
              ),
            ),
            body: Container(
                padding: EdgeInsets.only(top: 0),
                child: _WebViewPlugin(
                  initialLink: initialLink,
                )));
      },
    );
  }
}

class _WebViewPlugin extends StatelessWidget {
  final String initialLink;

  const _WebViewPlugin({Key key, @required this.initialLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WebViewPageModel>(
      builder: (BuildContext context, WebViewPageModel webViewPageModel, _) {
        return WebviewScaffold(
          withLocalUrl: true,
          withLocalStorage: true,
          withZoom: false,
          geolocationEnabled: true,
          url: initialLink,
          hidden: true,
          initialChild: Container(
            color: Colors.white,
            child: Center(
              child: Container(
                width: ScreenUtil().setWidth(150),
                height: ScreenUtil().setWidth(150),
                child: LoadingIndicator(
                  indicatorType: Indicator.pacman,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

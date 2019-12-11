import 'dart:async';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPageModel with ChangeNotifier {
  String _webTitle = "";
  final FlutterWebviewPlugin _flutterWebViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;

  String get webTitle => _webTitle;

  WebViewPageModel() {
    /*监听url改变*/
    _onUrlChanged = _flutterWebViewPlugin.onUrlChanged.listen((String url) async{
      String result = await _flutterWebViewPlugin.evalJavascript("document.title");
      _webTitle = result.replaceAll('"', '');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _flutterWebViewPlugin.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

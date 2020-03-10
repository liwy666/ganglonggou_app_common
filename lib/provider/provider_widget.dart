import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;
  final Function(T) onWidgetReady;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
    this.onModelReady,
    this.onWidgetReady,
  }) : super(key: key);

  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    if (widget.onWidgetReady != null) {
      WidgetsBinding.instance.addPostFrameCallback((callback) {
        widget.onWidgetReady(model);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelReady;
  final Function(A, B) onWidgetReady;

  ProviderWidget2({
    Key key,
    this.builder,
    this.model1,
    this.model2,
    this.child,
    this.onModelReady,
    this.onWidgetReady,
  }) : super(key: key);

  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;

    if (widget.onModelReady != null) {
      widget.onModelReady(model1, model2);
    }

    if (widget.onWidgetReady != null) {
      WidgetsBinding.instance.addPostFrameCallback((callback) {
        widget.onWidgetReady(model1, model2);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            create: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            create: (context) => model2,
          )
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}

/*
class ProxyProviderWidget<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Function(BuildContext context, A model1, B model2) providerBuilder;
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      consumerBuilder;

//  final A parentModel;
//  final B childModel;
  final Widget child;
  final Function(A, B) onModelReady;

  const ProxyProviderWidget(
      {Key key,
      @required this.providerBuilder,
      @required this.consumerBuilder,
      this.child,
      this.onModelReady})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProxyProviderWidget<A, B>();
  }
}

class _ProxyProviderWidget<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProxyProviderWidget<A, B>> {
  A parentModel;
  B childModel;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.onModelReady != null) {
      widget.onModelReady(parentModel, childModel);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProxyProvider<A, B>(create: widget.providerBuilder),
        ],
        child: Consumer2<A, B>(
          builder: widget.consumerBuilder,
          child: widget.child,
        ));
    ;
  }
}
*/

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';

class TestAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestAnimatedSwitcher();
  }
}

class _TestAnimationPage extends State<TestAnimationPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
//      dismissed	动画在起始点停止
//      forward	动画正在正向执行
//      reverse	动画正在反向执行
//      completed	动画在终点停止
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });
    //启动动画(正向执行)
    controller.forward();
  }

//  1.不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。
//  2.动画构建的范围缩小了，如果没有builder，setState()将会在父组件上下文中调用，这将会导致父组件的build方法重新调用；
//  而有了builder之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。
//3.通过AnimatedBuilder可以封装常见的过渡效果来复用动画。下面我们通过封装一个GrowTransition来说明，它可以对子widget实现放大动画：
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyTabBar(
        tabBarName: "动画测试",
      ),
      body: _GrowTransition(
        animation: animation,
        child: Image.asset("static_images/test_into.png"),
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class _TestAnimatedSwitcher extends State<TestAnimationPage>
    with SingleTickerProviderStateMixin {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyTabBar(
        tabBarName: "动画测试",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween =
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                return SlideTransition(
                  child: child,
                  position: tween.animate(animation),
                );
              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              child: const Text(
                '+1',
              ),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedImage extends AnimatedWidget {
  _AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "static_images/test_into.png",
        width: animation.value,
        height: animation.value,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class _GrowTransition extends StatelessWidget {
  _GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}

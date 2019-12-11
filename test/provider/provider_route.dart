import 'package:flutter_app/common_import.dart';

import 'Consumer.dart';
import 'item.dart';
import 'model/cart_model.dart';
import 'model/change_notifier_provider.dart';

class ProviderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Consumer<CartModel>(
                builder: (context, cart) {
                  return Text("总价: ${cart.totalPrice}");
                },
              ),
              Builder(builder: (context) {
                print("RaisedButton build");
                return RaisedButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    //给购物车中添加商品，添加后总价会更新
                    ChangeNotifierProvider.of<CartModel>(context)
                        .add(Item(20.0, 1));
                  },
                );
              })
            ],
          );
        }),
      ),
    );
  }
}

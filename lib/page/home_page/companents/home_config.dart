import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/page/components/my_single_row_tile.dart';
import 'package:flutter_app/routes/application.dart';

class HomeConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MySingleRowTile(
      child: Text("设置"),
      rightIcon: Icon(
        Icons.settings,
        color: Theme.of(context).accentColor,
      ),
      onTapFunction: () {
        Application.router.navigateTo(context, '/config');
      },
    );
  }
}

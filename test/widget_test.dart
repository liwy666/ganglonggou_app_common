import 'package:flutter_app/common_import.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  S();
}

abstract class BaseSqflite {
  final String name;

  BaseSqflite({@required this.name}) {
    if (name == null) {
      throw new FormatException('你需要在子类构造函数中实现super方法');
    }
    print(name);
  }

  String sqlFileName;

  void s();
}

class S extends BaseSqflite {
  S() : super(name: "呵呵") {
    print("hhh");
    this.init();
  }
  init() async {
    print("oio");
    String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
  }

  init2() {
    print("oio2");
  }

  @override
  void s() {
    // TODO: implement s
  }
}

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/write_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_options_align.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WriteOrderInvoiceOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyOptionsAlign(
                itemList: _getInvoiceTypeItemList(writeOrderPageModel),
                title: "发票类型",
              ),
              writeOrderPageModel.choiceInvoice["name"] == "不开票"
                  ? Container()
                  : MyOptionsAlign(
                      itemList: _getInvoiceHeadItemList(writeOrderPageModel),
                      title: "发票抬头",
                    ),
              writeOrderPageModel.choiceInvoice["name"] == "不开票"
                  ? Container(
                      height: ScreenUtil().setWidth(650),
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("发票信息",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(28))),
                          Container(
                            height: ScreenUtil().setWidth(650),
                            padding: EdgeInsets.only(left: 20, right: 15),
                            child: ListView(
                              children: writeOrderPageModel
                                  .choiceInvoiceHead["widgetList"],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  List<MyOptionsAlignItem> _getInvoiceTypeItemList(
      WriteOrderPageModel writeOrderPageModel) {
    return writeOrderPageModel.invoiceList
        .map<MyOptionsAlignItem>((Map<String, dynamic> item) {
      return MyOptionsAlignItem(
        onTap: () {
          writeOrderPageModel.switchInvoiceType(item["name"]);
        },
        itemValue: item["name"],
        isChoice: item["isChoice"],
      );
    }).toList();
  }

  List<MyOptionsAlignItem> _getInvoiceHeadItemList(
      WriteOrderPageModel writeOrderPageModel) {
    return writeOrderPageModel.choiceInvoice["list"].length > 0
        ? writeOrderPageModel.choiceInvoice["list"]
            .map<MyOptionsAlignItem>((Map<String, dynamic> item) {
            return MyOptionsAlignItem(
              onTap: () {
                writeOrderPageModel.switchInvoiceHead(item["name"]);
              },
              itemValue: item["name"],
              isChoice: item["isChoice"],
            );
          }).toList()
        : [];
  }
}

class TelephoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return TextField(
          keyboardType: TextInputType.number,
          maxLength: 11,
          style: TextStyle(fontSize: ScreenUtil().setWidth(21)),
          onChanged: (value) {
            writeOrderPageModel.setPhoneNumber = value;
          },
          decoration: InputDecoration(
            labelText: "请输入手机号",
          ),
        );
      },
    );
  }
}

class CompanyNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return TextField(
          maxLength: 35,
          style: TextStyle(fontSize: ScreenUtil().setWidth(21)),
          onChanged: (value) {
            writeOrderPageModel.setCompanyName = value;
          },
          decoration: InputDecoration(
            labelText: "请输入企业名称",
          ),
        );
      },
    );
  }
}

class TaxNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: ScreenUtil().setWidth(21)),
          maxLength: 20,
          onChanged: (value) {
            writeOrderPageModel.setTaxNumber = value;
          },
          decoration: InputDecoration(
            labelText: "请输入纳税人识别号",
          ),
        );
      },
    );
  }
}

class InvoiceAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: ScreenUtil().setWidth(21)),
          maxLength: 50,
          onChanged: (value) {
            writeOrderPageModel.setInvoiceAddress = value;
          },
          decoration: InputDecoration(
            labelText: "请输入开票地址",
          ),
        );
      },
    );
  }
}

class FixedPhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: ScreenUtil().setWidth(21)),
          maxLength: 20,
          onChanged: (value) {
            writeOrderPageModel.setFixedPhoneNumber = value;
          },
          decoration: InputDecoration(
            labelText: "请输入如:0510-80336198座机号",
          ),
        );
      },
    );
  }
}

class BankNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return TextField(
          style: TextStyle(fontSize: ScreenUtil().setWidth(21)),
          maxLength: 50,
          onChanged: (value) {
            writeOrderPageModel.setBankName = value;
          },
          decoration: InputDecoration(
            labelText: "请输入开户行名称",
          ),
        );
      },
    );
  }
}

class BankNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
          Widget child) {
        return TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: ScreenUtil().setWidth(21)),
          maxLength: 25,
          onChanged: (value) {
            writeOrderPageModel.setBankNumber = value;
          },
          decoration: InputDecoration(
            labelText: "请输入银行帐号",
          ),
        );
      },
    );
  }
}

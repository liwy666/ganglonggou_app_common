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
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("发票信息",
                              style: TextStyle(fontSize: SMALL_FONT_SIZE)),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            height: ScreenUtil().setWidth(650),
                            padding: EdgeInsets.only(left: 0, right: 10),
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
          controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: writeOrderPageModel.invoicePhoneNumber,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: writeOrderPageModel.invoicePhoneNumber.length)),
          )),
          keyboardType: TextInputType.number,
          maxLength: 11,
          style: TextStyle(fontSize: SMALL_FONT_SIZE),
          onChanged: (value) {
            writeOrderPageModel.setPhoneNumber = value;
          },
          decoration: InputDecoration(
            isDense: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
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
          controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: writeOrderPageModel.invoiceCompanyName,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: writeOrderPageModel.invoiceCompanyName.length)),
          )),
          maxLength: 35,
          style: TextStyle(fontSize: SMALL_FONT_SIZE),
          onChanged: (value) {
            writeOrderPageModel.setCompanyName = value;
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            isDense: true,
            contentPadding: EdgeInsets.all(5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
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
          controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: writeOrderPageModel.invoiceTaxNumber,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: writeOrderPageModel.invoiceTaxNumber.length)),
          )),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          style: TextStyle(fontSize: SMALL_FONT_SIZE),
          maxLength: 20,
          onChanged: (value) {
            writeOrderPageModel.setTaxNumber = value;
          },
          decoration: InputDecoration(
            isDense: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
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
          controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: writeOrderPageModel.invoiceAddress,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: writeOrderPageModel.invoiceAddress.length)),
          )),
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: SMALL_FONT_SIZE),
          maxLength: 50,
          onChanged: (value) {
            writeOrderPageModel.setInvoiceAddress = value;
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            alignLabelWithHint: true,
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
          controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: writeOrderPageModel.invoicefixedPhoneNumber,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: writeOrderPageModel.invoicefixedPhoneNumber.length)),
          )),
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: SMALL_FONT_SIZE),
          maxLength: 20,
          onChanged: (value) {
            writeOrderPageModel.setFixedPhoneNumber = value;
          },
          decoration: InputDecoration(
            isDense: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
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
          controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: writeOrderPageModel.invoicebankName,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: writeOrderPageModel.invoicebankName.length)),
          )),
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: SMALL_FONT_SIZE),
          maxLength: 50,
          onChanged: (value) {
            writeOrderPageModel.setBankName = value;
          },
          decoration: InputDecoration(
            isDense: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.all(5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
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
          controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: writeOrderPageModel.invoicebankNumber,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: writeOrderPageModel.invoicebankNumber.length)),
          )),
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: SMALL_FONT_SIZE),
          maxLength: 25,
          onChanged: (value) {
            writeOrderPageModel.setBankNumber = value;
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            alignLabelWithHint: true,
            labelText: "请输入银行帐号",
          ),
        );
      },
    );
  }
}

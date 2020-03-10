import 'package:json_annotation/json_annotation.dart';

part 'invoiceInfo.g.dart';

@JsonSerializable()
class InvoiceInfo {
    InvoiceInfo();

    String invoice_type;
    String invoice_head;
    String invoice_phone;
    String invoice_qymc;
    String invoice_nsrsbh;
    String invoice_kpdz;
    String invoice_zj;
    String invoice_khh;
    String invoice_yhzh;
    
    factory InvoiceInfo.fromJson(Map<String,dynamic> json) => _$InvoiceInfoFromJson(json);
    Map<String, dynamic> toJson() => _$InvoiceInfoToJson(this);
}

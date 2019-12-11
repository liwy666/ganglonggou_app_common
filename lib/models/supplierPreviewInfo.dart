import 'package:json_annotation/json_annotation.dart';
import "goodsItem.dart";
part 'supplierPreviewInfo.g.dart';

@JsonSerializable()
class SupplierPreviewInfo {
    SupplierPreviewInfo();

    num id;
    String supplier_name;
    String company_name;
    String service_tel;
    String after_sale_tel;
    String describe_rate;
    String service_rate;
    String logistics_rate;
    num follow_number;
    String colour;
    String logo_img;
    String head_img;
    List<GoodsItem> goods_list;
    
    factory SupplierPreviewInfo.fromJson(Map<String,dynamic> json) => _$SupplierPreviewInfoFromJson(json);
    Map<String, dynamic> toJson() => _$SupplierPreviewInfoToJson(this);
}

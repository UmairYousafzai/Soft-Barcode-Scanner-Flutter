import 'product.dart';
import 'package:soft_barcode_scanner/data/dataproviders/network/models/base_response.dart';

class ProductResponse extends BaseResponse{

  ProductResponse({this.data});

  ProductResponse.fromJson(dynamic json) {
    code = json['Code'];
    message = json['Message'];
    data = json['Data'] != null ?  Product.fromJson(json["Data"]) : null;
  }

 Product ? data;

}
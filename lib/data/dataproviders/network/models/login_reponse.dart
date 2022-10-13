import 'package:soft_barcode_scanner/data/dataproviders/network/models/base_response.dart';

import 'user.dart';

class LoginResponse extends BaseResponse {
  LoginResponse({this.data});

  LoginResponse.fromJson(Map<String , dynamic> json) {
    code = json["Code"];
    message = json['Message'];
    data = json['Data'] != null ? User.fromJson(json['Data']) : null;
  }

  User? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Code'] = code;
    map['Message'] = message;
    map['Data'] = data?.toJson();
    return map;
  }
}

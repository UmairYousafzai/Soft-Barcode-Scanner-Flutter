import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:soft_barcode_scanner/core/network/dio_factory.dart';
import 'package:soft_barcode_scanner/data/dataproviders/network/models/login_reponse.dart';
import 'package:soft_barcode_scanner/data/dataproviders/network/models/product_response.dart';
import 'package:soft_barcode_scanner/data/dataproviders/shared_preference/preference.dart';

class ApiClient {
  ApiClient() {
    DioFactory.getDefaultDio().then((value) => {_dio = value});
  }

  Dio? _dio;

  /// fetch & parse json in background
  /// should use only if large json, because compute() cost too
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    await checkIpUpdate();
    var response = await _dio!.request("/api/Account/Login",
        queryParameters: {'username': username, 'password': password});
    return LoginResponse.fromJson(jsonDecode(response.data));
  }

  Future<ProductResponse> fetchProduct(String barcode) async {
    final Response response = await _dio!.request("/api/Products/ProductByUan",
        queryParameters: {"UAN": barcode});
    return ProductResponse.fromJson(jsonDecode(response.data));
  }

  Future<void> checkIpUpdate() async {
    print("ip check fun");

    if (DioFactory.isIpChanged) {
      DioFactory.isIpChanged = false;
      print("ip changed");
      await Preference.ipAddress
          .then((value) => {_dio?.options.baseUrl = value});
    }
  }
}

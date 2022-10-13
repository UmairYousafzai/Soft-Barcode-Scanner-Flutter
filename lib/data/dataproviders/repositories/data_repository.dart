import 'package:soft_barcode_scanner/data/dataproviders/network/apis/barcode_scanner_api_client.dart';
import 'package:soft_barcode_scanner/data/dataproviders/network/exceptions/default_exception_handler.dart';
import 'package:soft_barcode_scanner/data/dataproviders/network/exceptions/exception_handler.dart';

import 'package:soft_barcode_scanner/data/dataproviders/network/models/login_reponse.dart';
import 'package:soft_barcode_scanner/data/dataproviders/network/models/product_response.dart';
import 'package:soft_barcode_scanner/utils/result.dart';

class DataRepository {
  DataRepository({
    ApiClient? apiClient,
    ExceptionHandler? exceptionHandler,
  })  : _apiClient = apiClient ?? ApiClient(),
        _exceptionHandler = exceptionHandler ?? DefaultExceptionHandler();

  final ApiClient _apiClient;
  final ExceptionHandler _exceptionHandler;

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    return await _apiClient.login(username: username, password: password);
  }

  //
  // Future<Result<LoginResponse>> login({
  //   required String username,
  //   required String password,
  // }) async {
  //   return Result.guardFuture(
  //     () async =>
  //         (await _apiClient.login(username: username, password: password)),
  //     _exceptionHandler,
  //   );
  // }

  Future<ProductResponse> fetchProduct(String barCode) async {
    return await _apiClient.fetchProduct(barCode);
  }
// Future<Result<ProductResponse>> fetchProduct(String barCode) async {
//   return Result.guardFuture(
//     () async => (await _apiClient.fetchProduct()),
//     _exceptionHandler,
//   );
// }
}

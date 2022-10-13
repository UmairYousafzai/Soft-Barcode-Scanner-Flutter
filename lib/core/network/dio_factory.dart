import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:soft_barcode_scanner/data/dataproviders/shared_preference/preference.dart';

class DioFactory {
  DioFactory._();

  static String _baseUrl = "192.168.10.1";
  static bool isIpChanged = false;

  static final Interceptor _prettyInterceptor = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90,
  );

  static Dio defaultDio = Dio()
    ..options.baseUrl = _baseUrl
    ..options.connectTimeout = 30000
    ..options.receiveTimeout = 30000
    ..options.responseType = ResponseType.plain
    ..interceptors.add(_prettyInterceptor);

   static Future<Dio> getDefaultDio() async {
    // await Preference.ipAddress.then((value) => {_baseUrl = value});
    // defaultDio.options.baseUrl = _baseUrl;
    defaultDio.options.baseUrl = "https://easyapitest.thevapehouse.pk";
    return defaultDio;
  }
}

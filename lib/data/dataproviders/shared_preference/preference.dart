import 'package:soft_barcode_scanner/core/network/dio_factory.dart';
import 'package:soft_barcode_scanner/data/dataproviders/shared_preference/shared_preference_helper.dart';
import 'package:soft_barcode_scanner/utils/const.dart';
import 'package:soft_barcode_scanner/utils/string_ext.dart';

class Preference {
  static Future<bool> get isLogin => PreferencesHelper.getBool(Const.IS_LOGIN);
  static Future<String> get ipAddress =>PreferencesHelper.getString(Const.IP_ADDRESS);

  // static String get ipAddress {
  //   PreferencesHelper.getString(Const.IP_ADDRESS).then((value) {
  //     if (value.isEmpty) {
  //       return "192.168.10.1";
  //     } else {
  //       return value;
  //     }
  //   }).catchError((onError) {
  //     return "192.168.10.1";
  //   });
  //   return "192.168.10.1";
  // }

  static Future setIsLogin(bool value) =>
      PreferencesHelper.setBool(Const.IS_LOGIN, value);

  static Future setIpAddress(String value) {
    DioFactory.isIpChanged = true;
    return PreferencesHelper.setString(Const.IP_ADDRESS, value);
  }

  Future<void> clear() async {
    await Future.wait(<Future>[
      setIsLogin(false),
    ]);
  }
}

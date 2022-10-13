import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/data/dataproviders/repositories/data_repository.dart';
import 'package:soft_barcode_scanner/presentation/login/loginBloc.dart';
import 'package:soft_barcode_scanner/presentation/login/login_view.dart';
import 'package:soft_barcode_scanner/presentation/splash/splash_view.dart';

import '../barcode/barcode_bloc.dart';
import '../barcode/barcode_scanner_page.dart';

class AppRouter {
  static const String home = '/';
  static const String login = 'login';
  static const String barcode = 'barcode';

  const AppRouter._();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(dataRepository: DataRepository()),
            child: LoginPage(),
          ),
        );
      case barcode:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<BarcodeScanBloc>(
            create: (context) =>
                BarcodeScanBloc(dataRepository: DataRepository()),
            child: BarcodePage(),
          ),
        );
      default:
        throw Exception('Route name:${settings.name} not found');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/data/dataproviders/repositories/data_repository.dart';
import 'package:soft_barcode_scanner/presentation/login/loginBloc.dart';
import 'package:soft_barcode_scanner/presentation/login/login_state.dart';
import 'package:soft_barcode_scanner/presentation/login/login_view.dart';
import 'package:soft_barcode_scanner/presentation/router/app_router.dart';
import 'package:soft_barcode_scanner/presentation/splash/splash_view.dart';

void main() {
  runApp(const MaterialApp(
    onGenerateRoute: AppRouter.onGenerateRoute,
  ));
}

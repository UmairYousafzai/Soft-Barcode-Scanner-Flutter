import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/presentation/login/loginBloc.dart';
import 'package:soft_barcode_scanner/presentation/login/login_state.dart';
import 'package:soft_barcode_scanner/utils/extensions.dart';

import '../../data/dataproviders/repositories/data_repository.dart';
import '../login/login_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2500,
      splashIconSize: 200.0,
      splash: "assets/images/softlogo.png",
      nextScreen:BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(dataRepository: DataRepository()),
        child: LoginPage(),
      ),
      splashTransition: SplashTransition.slideTransition,

      backgroundColor: "2d2d2d".toColor(),
    );
  }
}

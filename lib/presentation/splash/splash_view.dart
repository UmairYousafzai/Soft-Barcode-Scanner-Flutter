import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/data/dataproviders/shared_preference/preference.dart';
import 'package:soft_barcode_scanner/presentation/barcode/barcode_bloc.dart';
import 'package:soft_barcode_scanner/presentation/barcode/barcode_scanner_page.dart';
import 'package:soft_barcode_scanner/presentation/login/loginBloc.dart';
import 'package:soft_barcode_scanner/presentation/login/login_state.dart';
import 'package:soft_barcode_scanner/utils/extensions.dart';

import '../../data/dataproviders/repositories/data_repository.dart';
import '../login/login_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget futureWidget = BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(dataRepository: DataRepository()),
    child: LoginPage(),
  );


  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2500,
      splashIconSize: 200.0,
      splash: "assets/images/softlogo.png",
      nextScreen: futureWidget,
      splashTransition: SplashTransition.slideTransition,
      backgroundColor: "2d2d2d".toColor(),
    );
  }

  Future<void> checkIsLogin() async {
    bool isLogin = false;
    await Preference.isLogin.then((value) => {isLogin = value});
    if (isLogin) {
      setState(() {
        futureWidget = BlocProvider<BarcodeScanBloc>(
          create: (context) =>
              BarcodeScanBloc(dataRepository: DataRepository()),
          child: BarcodePage(),
        );
      });
    }
  }

// class SplashPage extends  {
//   Widget widget = BlocProvider<LoginBloc>(
//     create: (context) => LoginBloc(dataRepository: DataRepository()),
//     child: LoginPage(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       duration: 2500,
//       splashIconSize: 200.0,
//       splash: "assets/images/softlogo.png",
//       nextScreen: widget,
//       splashTransition: SplashTransition.slideTransition,
//       backgroundColor: "2d2d2d".toColor(),
//     );
//   }

}
// }

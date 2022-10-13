import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/core/ui/snack_bar_ext.dart';
import 'package:soft_barcode_scanner/data/dataproviders/shared_preference/preference.dart';

// import 'package:soft_barcode_scanner/data/dataproviders/shared_preference/pr';
import 'package:soft_barcode_scanner/presentation/login/loginBloc.dart';
import 'package:soft_barcode_scanner/presentation/login/login_event.dart';
import 'package:soft_barcode_scanner/presentation/login/login_state.dart';
import 'package:soft_barcode_scanner/presentation/router/app_router.dart';
import 'package:soft_barcode_scanner/utils/extensions.dart';
import 'package:soft_barcode_scanner/utils/form_submission_status.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: "2d2d2d".toColor(),
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: loginForm(),
      )),
    );
  }

  Widget loginForm() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionFailed) {
          final formStatus = state.formStatus as SubmissionFailed;
          context.showNegativeSnackBar("Opps,${formStatus.errorMessage}");
        }
        if (state.formStatus is SubmissionSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.barcode, (Route<dynamic> route) => false);
          Preference.setIsLogin(true);
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/images/softlogo.png",
                height: 100.0,
                scale: 2.5,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Barcode Scanner",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: "#caab50".toColor(),
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              fieldsSection(),
              const SizedBox(
                height: 10.0,
              ),
              buttonSection(context)
            ],
          ),
        );
      },
    );
  }

  Widget fieldsSection() {
    return Form(
      key: formKey,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: "#caab50".toColor(),
        elevation: 5.0,
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              userNameField(),
              const SizedBox(
                height: 20.0,
              ),
              passwordField()
            ],
          ),
        ),
      ),
    );
  }

  Widget userNameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        validator: (value) =>
            state.isValidPassword ? null : "Username is too short",
        onChanged: (value) => {
          context
              .read<LoginBloc>()
              .add(LoginUserNameChangedEvent(userName: value.trim()))
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            hintText: "User Name",
            labelText: "UserName",
            labelStyle: TextStyle(color: Colors.black),
            fillColor: Colors.white,
            filled: true,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      );
    });
  }

  Widget passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        validator: (value) =>
            state.isValidPassword ? null : "Password is too short",
        onChanged: (value) => {
          context
              .read<LoginBloc>()
              .add(LoginPasswordChangedEvent(password: value))
        },
        obscureText: state.isShowPassword,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                context.read<LoginBloc>().add(
                      LoginPasswordShowEvent(
                          isShowPassword: state.isShowPassword ? false : true),
                    );
              },
              icon: state.isShowPassword
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            hintText: "Password",
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black),
            fillColor: Colors.white,
            filled: true,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      );
    });
  }

  Widget buttonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [ipButton(context), loginButton()],
    );
  }

  Widget loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmittingStatus
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () => {
                    if (formKey.currentState!.validate())
                      {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginCredentialsSubmittedEvent())
                      }
                  },
              style: ElevatedButton.styleFrom(primary: "#caab50".toColor()),
              child: Row(
                children: const [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
              ));
    });
  }

  Widget ipButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showIpAddressDialog(context);
        },
        style: ElevatedButton.styleFrom(primary: "#caab50".toColor()),
        child: Row(
          children: const [
            Text(
              "Configuration IP",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ));
  }

  Future<void> showIpAddressDialog(BuildContext context) async {
    String ipAddress = "192.168.10.1";
    Preference.ipAddress.then((value) => {
          if (value.isNotEmpty) {ipAddress = value}
        });
    return await showDialog(
        context: context,
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
            backgroundColor: "2d2d2d".toColor(),
            title: Center(
                child: Text(
              "Ip Address",
              style: TextStyle(
                  color: "#caab50".toColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            )),
            content: SizedBox(
              height: 150,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    initialValue: ipAddress,
                    onChanged: (value) {
                      ipAddress = value;
                    },
                    cursorColor: "#caab50".toColor(),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: "#caab50".toColor()),
                      ),
                      hintText: ipAddress,
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: "#caab50".toColor())),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: "#caab50".toColor()),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Preference.setIpAddress(ipAddress);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: "#caab50".toColor()),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ],
          );
        });
  }
}

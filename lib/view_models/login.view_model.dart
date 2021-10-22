import 'package:cool_alert/cool_alert.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginViewModel extends MyBaseViewModel {
  //the textediting controllers
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController phoneTEC = new TextEditingController();

  TextEditingController passwordTEC = new TextEditingController();
  Country selectedCountry;
  String accountPhoneNumber;
  //
  AuthRequest _authRequest = AuthRequest();

  LoginViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() {
    //
    // emailTEC.text = kReleaseMode ? "" : "client@demo.com";
    phoneTEC.text = kReleaseMode ? "" : "1866541002";
    passwordTEC.text = kReleaseMode ? "" : "password";
  }

  void processLogin() async {
    // Validate returns true if the form is valid, otherwise false.
    if (formKey.currentState.validate()) {
      //

      setBusy(true);

      final apiResponse = await _authRequest.loginRequest(
        // email: emailTEC.text,
        phone: phoneTEC.text,
        password: passwordTEC.text,
      );

      try {
        if (apiResponse.hasError()) {
          //there was an error
          CoolAlert.show(
            context: viewContext,
            type: CoolAlertType.error,
            title: "Login Failed",
            text: apiResponse.message,
          );
          setBusy(false);
        } else {
          //everything works well
          //firebase auth
          final fbToken = apiResponse.body["fb_token"];
          await FirebaseAuth.instance.signInWithCustomToken(fbToken);
          await AuthServices.saveUser(apiResponse.body["user"]);
          await AuthServices.setAuthBearerToken(apiResponse.body["token"]);
          await AuthServices.isAuthenticated();
          viewContext.pop(true);
        }
        setBusy(false);
      } on FirebaseAuthException catch (error) {
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Login Failed",
          text: "${error.message}",
        );
        setBusy(false);
      } catch (error) {
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Login Failed",
          text: "${error['message'] ?? error}",
        );
        setBusy(false);
      }
    }
  }

  void openRegister() async {
    viewContext.navigator.pushNamed(
      AppRoutes.registerRoute,
    );
  }

  void openForgotPassword() {
    viewContext.navigator.pushNamed(
      AppRoutes.forgotPasswordRoute,
    );
  }
}

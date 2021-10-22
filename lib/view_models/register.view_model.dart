import 'package:cool_alert/cool_alert.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/views/pages/splash.page.dart';
import 'package:fuodz/widgets/bottomsheets/account_verification_entry.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterViewModel extends MyBaseViewModel {
  //
  AuthRequest _authRequest = AuthRequest();
  // FirebaseAuth auth = FirebaseAuth.instance;
  //the textediting controllers
  TextEditingController nameTEC =
      new TextEditingController(text: !kReleaseMode ? "John Doe" : "");
  TextEditingController addressTEC =
      new TextEditingController(text: !kReleaseMode ? "Mirpur , Dhaka" : "");
  String accountTypeTEC;

  TextEditingController accountNumberTEC =
      new TextEditingController(text: !kReleaseMode ? "01866541002" : "");
  TextEditingController emailTEC =
      new TextEditingController(text: !kReleaseMode ? "" : "");
  TextEditingController phoneTEC =
      new TextEditingController(text: !kReleaseMode ? "557484181" : "");
  TextEditingController passwordTEC =
      new TextEditingController(text: !kReleaseMode ? "password" : "");
  TextEditingController referralCodeTEC = new TextEditingController();
  Country selectedCountry;
  String accountPhoneNumber;
  bool agreed = false;

  RegisterViewModel(BuildContext context) {
    this.viewContext = context;
    try {
      this.selectedCountry = Country.parse(AppStrings.countryCode
          .toUpperCase()
          .replaceAll("AUTO,", "")
          .split(",")[0]);
    } catch (error) {
      this.selectedCountry = Country.parse("BD");
    }
  }

  //
  showCountryDialPicker() {
    showCountryPicker(
      context: viewContext,
      showPhoneCode: true,
      onSelect: countryCodeSelected,
    );
  }

  countryCodeSelected(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  void processRegister() async {
    //
    // accountPhoneNumber = "+${selectedCountry.phoneCode}${phoneTEC.text}";
    accountPhoneNumber = "${phoneTEC.text}";

    //
    // Validate returns true if the form is valid, otherwise false.
    if (formKey.currentState.validate()) {
      if (AppStrings.isFirebaseOtp) {
        processFirebaseOTPVerification();
      } else if (AppStrings.isCustomOtp) {
        processCustomOTPVerification();
      } else {
        finishAccountRegistration();
      }
    }
  }

  //PROCESSING VERIFICATION
  processFirebaseOTPVerification() async {
    setBusy(true);
    //firebase authentication
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: accountPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // firebaseVerificationId = credential.verificationId;
        // verifyFirebaseOTP(credential.smsCode);
        finishAccountRegistration();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          viewContext.showToast(
              msg: "Invalid Phone Number", bgColor: Colors.red);
        } else {
          viewContext.showToast(msg: e.message, bgColor: Colors.red);
        }
        //
        setBusy(false);
      },
      codeSent: (String verificationId, int resendToken) async {
        firebaseVerificationId = verificationId;
        showVerificationEntry();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout called");
      },
    );
  }

  processCustomOTPVerification() async {
    setBusy(true);
    try {
      await _authRequest.sendOTP(accountPhoneNumber);
      setBusy(false);
      showVerificationEntry();
    } catch (error) {
      setBusy(false);
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
  }

  //
  void showVerificationEntry() {
    //
    setBusy(false);
    //
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return AccountVerificationEntry(
          vm: this,
          onSubmit: (smsCode) {
            //
            if (AppStrings.isFirebaseOtp) {
              verifyFirebaseOTP(smsCode);
            } else if (AppStrings.isCustomOtp) {
              verifyCustomOTP(smsCode);
            }

            viewContext.pop();
          },
        );
      },
    );
  }

  //
  void verifyFirebaseOTP(String smsCode) async {
    //
    setBusyForObject(firebaseVerificationId, true);

    // Sign the user in (or link) with the credential
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseVerificationId,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      finishAccountRegistration();
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    //
    setBusyForObject(firebaseVerificationId, false);
  }

  void verifyCustomOTP(String smsCode) async {
    //
    setBusyForObject(firebaseVerificationId, true);
    // Sign the user in (or link) with the credential
    try {
      await _authRequest.verifyOTP(accountPhoneNumber, smsCode);
      finishAccountRegistration();
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    //
    setBusyForObject(firebaseVerificationId, false);
  }

///////
  ///
  void finishAccountRegistration() async {
    setBusy(true);

    final apiResponse = await _authRequest.registerRequest(
        name: nameTEC.text,
        email: emailTEC.text,
        phone: accountPhoneNumber,
        countryCode: selectedCountry.countryCode,
        password: passwordTEC.text,
        code: referralCodeTEC.text ?? "",
        useraddress: addressTEC.text,
        actype: accountTypeTEC,
        acnumber: accountNumberTEC.text);

    setBusy(false);

    try {
      if (apiResponse.hasError()) {
        //there was an error
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Registration Failed",
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
        viewContext.navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SplashPage()),
          (route) => false,
        );
        setBusy(false);
      }
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
    }
    setBusy(false);
  }

  void openLogin() async {
    viewContext.pop();
  }

  verifyRegistrationOTP(String text) {}
}
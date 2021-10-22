import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/login.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';

import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          body: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: context.mq.viewInsets.bottom),
              child: VStack(
                [
                  Image.asset(
                    "assets/images/regpic.png",
                  ).hOneForth(context).centered(),
                  //
                  VStack(
                    [
                      //
                      "Welcome Back".text.xl2.semiBold.make(),
                      "Login to continue".text.light.make(),

                      //form
                      Form(
                        key: model.formKey,
                        child: VStack(
                          [
                            //
                            HStack(
                              [
                                CustomTextFormField(
                                  prefixIcon: HStack(
                                    [
                                      //icon/flag
                                      Flag(
                                        "BD",
                                        width: 20,
                                        height: 20,
                                      ),
                                      UiSpacer.horizontalSpace(space: 5),
                                      //text
                                      ("+880").text.make(),
                                    ],
                                  ).px8(),
                                  labelText: "Phone",
                                  hintText: "1737250324",
                                  keyboardType: TextInputType.phone,
                                  textEditingController: model.phoneTEC,
                                  validator: FormValidator.validatePhone,
                                ).expand(),
                              ],
                            ).py12(),

                            // CustomTextFormField(
                            //   labelText: "Email",
                            //   keyboardType: TextInputType.emailAddress,
                            //   textEditingController: model.emailTEC,
                            //   validator: FormValidator.validateEmail,
                            // ).py12(),
                            CustomTextFormField(
                              labelText: "Password",
                              obscureText: true,
                              textEditingController: model.passwordTEC,
                              validator: FormValidator.validatePassword,
                            ).py12(),

                            //
                            "Forgot Password ?"
                                .text
                                .semiBold
                                .color(Colors.red)
                                .make()
                                .onInkTap(
                                  model.openForgotPassword,
                                ),
                            //
                            CustomButton(
                              title: "Login",
                              loading: model.isBusy,
                              onPressed: model.processLogin,
                            ).centered().py12(),

                            //register
                            "OR".text.light.makeCentered(),
                            "Create An Account"
                                .text
                                .bold
                                .color(Colors.green)
                                .makeCentered()
                                .py12()
                                .onInkTap(model.openRegister),
                          ],
                          crossAlignment: CrossAxisAlignment.end,
                        ),
                      ).py20(),
                    ],
                  ).wFull(context).p20(),
                  //
                ],
              ).scrollVertical(),
            ),
          ),
        );
      },
    );
  }
}

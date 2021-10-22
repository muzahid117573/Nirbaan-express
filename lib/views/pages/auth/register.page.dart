import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/register.view_model.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _dropDownValue;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(context),
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
                  // Image.asset(
                  //   "assets/images/regpic.png",
                  // ).hOneForth(context).centered(),
                  // //
                  VStack(
                    [
                      //
                      Center(
                          child: "SignUp As Merchant".text.xl2.semiBold.make()),

                      //form
                      Form(
                        key: model.formKey,
                        child: VStack(
                          [
                            //
                            CustomTextFormField(
                              labelText: "Name",
                              textEditingController: model.nameTEC,
                              validator: FormValidator.validateName,
                            ).py12(),
                            //
                            CustomTextFormField(
                              labelText: "Email (Optional)",
                              keyboardType: TextInputType.emailAddress,
                              textEditingController: model.emailTEC,
                              //  validator: FormValidator.validateEmail,
                            ).py12(),
                            //
                            HStack(
                              [
                                CustomTextFormField(
                                  prefixIcon: HStack(
                                    [
                                      //icon/flag
                                      Flag(
                                        model.selectedCountry.countryCode,
                                        width: 20,
                                        height: 20,
                                      ),
                                      UiSpacer.horizontalSpace(space: 5),
                                      //text
                                      ("+" + model.selectedCountry.phoneCode)
                                          .text
                                          .make(),
                                    ],
                                  ).px8(),
                                  labelText: "Phone",
                                  hintText: "171*******",
                                  keyboardType: TextInputType.phone,
                                  textEditingController: model.phoneTEC,
                                  validator: FormValidator.validatePhone,
                                ).expand(),
                              ],
                            ).py12(),
                            //
                            CustomTextFormField(
                              labelText: "Password",
                              obscureText: true,
                              textEditingController: model.passwordTEC,
                              validator: FormValidator.validatePassword,
                            ).py12(),

                            CustomTextFormField(
                              maxLines: 2,
                              labelText: "Address",
                              textEditingController: model.addressTEC,
                              validator: FormValidator.validateName,
                            ).py12(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Account Information"
                                    .text
                                    .xl
                                    .bold
                                    .color(Colors.orange)
                                    .medium
                                    .make()
                                    .py8(),
                              ],
                            ),
                            Container(
                              height: 70,
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all()),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: DropdownButtonFormField(
                                  validator: (value) => value == null
                                      ? 'Please Select Account Type'
                                      : null,
                                  hint: _dropDownValue == null
                                      ? Text('Select Account Type')
                                      : Text(
                                          _dropDownValue,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  items: [
                                    'Bkash Personal',
                                    'Bkash Merchant',
                                    'Nagad Personal',
                                    'Nagad Merchant'
                                  ].map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    setState(
                                      () {
                                        FocusScope.of(context).unfocus();
                                        _dropDownValue = val;
                                        model.accountTypeTEC = val;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),

                            CustomTextFormField(
                              labelText: "Account Number",
                              keyboardType: TextInputType.number,
                              textEditingController: model.accountNumberTEC,
                              validator: (value) => FormValidator.validateEmpty(
                                  value,
                                  errorTitle: "Account Number"),
                            ).py12(),

                            AppStrings.enableReferSystem
                                ? CustomTextFormField(
                                    labelText: "Referral Code(optional)",
                                    textEditingController:
                                        model.referralCodeTEC,
                                  ).py12()
                                : UiSpacer.emptySpace(),

                            //terms
                            // HStack(
                            //   [
                            //     Checkbox(
                            //       value: model.agreed,
                            //       onChanged: (value) {
                            //         FocusScope.of(context).unfocus();
                            //         model.agreed = value;
                            //         model.notifyListeners();
                            //       },
                            //     ),
                            //     //
                            //     "I agree with".i18n.text.make(),
                            //     UiSpacer.horizontalSpace(space: 2),
                            //     "Terms & Conditions"
                            //         .i18n
                            //         .text
                            //         .color(AppColor.primaryColor)
                            //         .bold
                            //         .underline
                            //         .make()
                            //         .onInkTap(model.openTerms)
                            //         .expand(),
                            //   ],
                            // ),

                            //
                            CustomButton(
                              title: "Create Account",
                              loading: model.isBusy,
                              onPressed: model.processRegister,
                            ).centered().py12(),

                            //register
                            "OR".text.light.makeCentered(),
                            "Already have an Account"
                                .text
                                .semiBold
                                .makeCentered()
                                .py12()
                                .onInkTap(model.openLogin),
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

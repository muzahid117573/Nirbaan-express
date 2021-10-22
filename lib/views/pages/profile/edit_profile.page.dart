import 'package:cached_network_image/cached_network_image.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/edit_profile.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          title: "Edit Profile",
          body: SafeArea(
              top: true,
              bottom: false,
              child:
                  //
                  VStack(
                [
                  //
                  Stack(
                    children: [
                      //
                      model.currentUser == null
                          ? BusyIndicator()
                          : model.newPhoto == null
                              ? CachedNetworkImage(
                                  imageUrl: model.currentUser?.photo ?? "",
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return BusyIndicator();
                                  },
                                  errorWidget: (context, imageUrl, progress) {
                                    return Image.asset(
                                      AppImages.user,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                )
                                  .wh(
                                    Vx.dp64 * 1.3,
                                    Vx.dp64 * 1.3,
                                  )
                                  .box
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .make()
                              : Image.file(
                                  model.newPhoto,
                                  fit: BoxFit.cover,
                                )
                                  .wh(
                                    Vx.dp64 * 1.3,
                                    Vx.dp64 * 1.3,
                                  )
                                  .box
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .make(),

                      //
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          FlutterIcons.camera_ant,
                          size: 16,
                        )
                            .p8()
                            .box
                            .color(context.theme.backgroundColor)
                            .roundedFull
                            .shadow
                            .make()
                            .onInkTap(model.changePhoto),
                      ),
                    ],
                  ).box.makeCentered(),

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
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: model.emailTEC,
                          // validator: FormValidator.validateEmail,
                        ).py12(),
                        //
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
                          ).px8().onInkTap(model.showCountryDialPicker),
                          labelText: "Phone",
                          keyboardType: TextInputType.phone,
                          textEditingController: model.phoneTEC,
                          validator: FormValidator.validatePhone,
                        ).py12(),

                        CustomTextFormField(
                          maxLines: 2,
                          labelText: "Pickup Address",
                          textEditingController: model.addressTEC,
                          validator: FormValidator.validateName,
                        ).py12(),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     "Account Information"
                        //         .text
                        //         .xl
                        //         .color(Colors.blueGrey[800])
                        //         .medium
                        //         .make()
                        //         .py8(),
                        //   ],
                        // ),

                        // Padding(
                        //   padding: EdgeInsets.all(5),
                        //   child: DropdownButton(
                        //     hint: _dropDownValue == null
                        //         ? Text('Select Account Type')
                        //         : Text(
                        //             _dropDownValue,
                        //             style: TextStyle(color: Colors.black),
                        //           ),
                        //     isExpanded: true,
                        //     items: [
                        //       'Bkash Personal',
                        //       'Bkash Merchant',
                        //       'Nagad Personal',
                        //       'Nagad Merchant'
                        //     ].map(
                        //       (val) {
                        //         return DropdownMenuItem<String>(
                        //           value: val,
                        //           child: Text(val),
                        //         );
                        //       },
                        //     ).toList(),
                        //     onChanged: (val) {
                        //       FocusScope.of(context)
                        //           .requestFocus(new FocusNode());
                        //       setState(
                        //         () {
                        //           FocusScope.of(context).unfocus();
                        //           _dropDownValue = val;
                        //           model.actypeTEC = val;
                        //         },
                        //       );
                        //     },
                        //   ),
                        // ),
                        CustomTextFormField(
                          labelText: "Account Number",
                          keyboardType: TextInputType.number,
                          textEditingController: model.acnumTEC,
                          validator: (value) => FormValidator.validateEmpty(
                              value,
                              errorTitle: "Account Number"),
                        ).py12(),
                        //
                        CustomButton(
                          title: "Update Profile",
                          loading: model.isBusy,
                          onPressed: model.processUpdate,
                        ).centered().py12(),
                      ],
                    ),
                  ).py20(),
                ],
              ).p20().scrollVertical()),
        );
      },
    );
  }
}

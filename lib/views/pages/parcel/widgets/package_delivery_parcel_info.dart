import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:fuodz/widgets/list_items/payment_method.list_item.dart';
import 'package:velocity_x/velocity_x.dart';

class PackageDeliveryParcelInfo extends StatefulWidget {
  const PackageDeliveryParcelInfo({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;

  @override
  _PackageDeliveryParcelInfoState createState() =>
      _PackageDeliveryParcelInfoState();
}

class _PackageDeliveryParcelInfoState extends State<PackageDeliveryParcelInfo> {
  String _dropDownValue;
  NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.vm.packageInfoFormKey,
      child: VStack(
        [
          //
          VStack(
            [
              "Package Parameters".text.xl.medium.make().py20(),
              UiSpacer.formVerticalSpace(),
              //
              ("Weight" + " (kg)").text.make(),
              CustomTextFormField(
                underline: true,
                hintText: "Enter package weight",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: widget.vm.packageWeightTEC,
                validator: (value) => FormValidator.validateCustom(value,
                    name: "Weight", rules: "required"),
              ),
              UiSpacer.formVerticalSpace(),
              //
              ("Product" + " Price").text.make(),
              CustomTextFormField(
                underline: true,
                hintText: "Amount Of Collection Money",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: widget.vm.packageWidthTEC,
                validator: (value) => FormValidator.validateCustom(value,
                    name: "Width",
                    rules: widget.vm.requireParcelInfo ? "required|gt:0" : ''),
              ),

              UiSpacer.formVerticalSpace(),

              // "Account Information".text.xl.medium.make().py20(),

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
              //       FocusScope.of(context).requestFocus(new FocusNode());
              //       setState(
              //         () {
              //           FocusScope.of(context).unfocus();
              //           _dropDownValue = val;
              //           widget.vm.packageLengthTEC = val;
              //         },
              //       );
              //     },
              //   ),
              // ),
              // UiSpacer.formVerticalSpace(),

              // ("Bkash/Nagad" + " Number").text.make(),
              // CustomTextFormField(
              //   underline: true,
              //   hintText: "Account Number",
              //   textInputAction: TextInputAction.next,
              //   keyboardType: TextInputType.phone,
              //   textEditingController: widget.vm.packageHeightTEC,
              //   validator: (value) => FormValidator.validateCustom(value,
              //       name: "Height",
              //       rules: widget.vm.requireParcelInfo ? "required|gt:0" : ''),
              // ),
              // UiSpacer.formVerticalSpace(),

              // //
              // ("Width".i18n + " (cm)").text.make(),
              // CustomTextFormField(
              //   underline: true,
              //   hintText: "Enter package width".i18n,
              //   textInputAction: TextInputAction.next,
              //   keyboardType: TextInputType.number,
              //   textEditingController: vm.packageWidthTEC,
              //   validator: (value) => FormValidator.validateCustom(value,
              //       name: "Width".i18n,
              //       rules: vm.requireParcelInfo ? "required|gt:0" : ''),
              // ),
              // UiSpacer.formVerticalSpace(),

              // //
              // ("Height".i18n + " (cm)").text.make(),
              // CustomTextFormField(
              //   underline: true,
              //   hintText: "Enter package height".i18n,
              //   textInputAction: TextInputAction.done,
              //   keyboardType: TextInputType.number,
              //   textEditingController: vm.packageHeightTEC,
              //   validator: (value) => FormValidator.validateCustom(
              //     value,
              //     name: "Height".i18n,
              //     rules: vm.requireParcelInfo ?"required|gt:0":''
              //   ),
              // ),

              //finish btn
              UiSpacer.formVerticalSpace(),
            ],
          ).scrollVertical().expand(),

          //
          FormStepController(
            onPreviousPressed: () => widget.vm.nextForm(3),
            onNextPressed: widget.vm.validateDeliveryParcelInfo,
          ),
        ],
      ),
    );
  }
}

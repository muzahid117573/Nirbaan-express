import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_form_input.dart';
import 'package:velocity_x/velocity_x.dart';

class PackageStopRecipientView extends StatefulWidget {
  const PackageStopRecipientView(
    this.stop,
    this.recipientNameTEC,
    this.recipientPhoneTEC,
    this.noteTEC, {
    Key key,
    this.isOpen = false,
    this.viewKey,
  }) : super(key: key);

  final DeliveryAddress stop;
  final TextEditingController recipientNameTEC;
  final TextEditingController recipientPhoneTEC;
  final TextEditingController noteTEC;
  final bool isOpen;
  final Key viewKey;

  @override
  _PackageStopRecipientViewState createState() =>
      _PackageStopRecipientViewState();
}

class _PackageStopRecipientViewState extends State<PackageStopRecipientView> {
  //
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
    isOpen = widget.isOpen;
  }

  //
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        HStack(
          [
            ("Contact Info" + " (${widget.stop.name})")
                .text
                .xl
                .medium
                .make()
                .expand(),
            Icon(
              isOpen ? FlutterIcons.caret_down_faw : FlutterIcons.caret_up_faw,
              color: AppColor.primaryColor,
            ),
          ],
        ).onInkTap(() {
          //
          setState(() {
            isOpen = !isOpen;
          });
        }),

        //
        Visibility(
            key: widget.viewKey,
            visible: isOpen,
            child: VStack(
              [
                UiSpacer.verticalSpace(),
                //name
                ParcelFormInput(
                  isReadOnly: false,
                  iconData: FlutterIcons.user_fea,
                  iconColor: AppColor.primaryColor,
                  labelText: "Name".toUpperCase(),
                  hintText: "Contact Name",
                  tec: widget.recipientNameTEC,
                  formValidator: (value) => FormValidator.validateCustom(
                    value,
                    name: "Name",
                  ),
                ),
                UiSpacer.formVerticalSpace(),
                //phone
                ParcelFormInput(
                  isReadOnly: false,
                  iconData: FlutterIcons.phone_fea,
                  iconColor: AppColor.primaryColor,
                  labelText: "phone".toUpperCase(),
                  hintText: "Contact Phone number",
                  keyboardType: TextInputType.phone,
                  tec: widget.recipientPhoneTEC,
                  formValidator: (value) => FormValidator.validatePhone(
                    value,
                    name: "phone".allWordsCapitilize(),
                  ),
                ),
                UiSpacer.formVerticalSpace(),
                //note
                // ParcelFormInput(
                //   isReadOnly: false,
                //   iconData: FlutterIcons.note_oct,
                //   iconColor: AppColor.primaryColor,
                //   labelText: "Note".toUpperCase(),
                //   hintText: "Further instruction",
                //   tec: widget.noteTEC,
                // ),
              ],
            )),
      ],
    ).p12().box.p12.py4.border(color: AppColor.primaryColor).roundedSM.make();
  }
}

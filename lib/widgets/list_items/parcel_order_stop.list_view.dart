import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/order_stop.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ParcelOrderStopListView extends StatefulWidget {
  const ParcelOrderStopListView(
    this.title,
    this.stop, {
    Key key,
    this.canCall = false,
  }) : super(key: key);

  final OrderStop stop;
  final String title;
  final bool canCall;

  @override
  _ParcelOrderStopListViewState createState() =>
      _ParcelOrderStopListViewState();
}

class _ParcelOrderStopListViewState extends State<ParcelOrderStopListView> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        "${widget.title}".text.gray500.medium.sm.make(),
        "${widget.stop?.deliveryAddress?.name}".text.xl.medium.make(),
        "${widget.stop?.deliveryAddress?.address}"
            .text
            .make()
            .pOnly(bottom: Vx.dp4),

        //
        HStack(
          [
            "Contact Info".text.gray500.medium.sm.make().expand(),
            //
            Icon(
              isOpen ? FlutterIcons.caret_up_faw : FlutterIcons.caret_down_faw,
              color: AppColor.primaryColor,
            ),
          ],
        ).onInkTap(() {
          setState(() {
            isOpen = !isOpen;
          });
        }),
        //
        Visibility(
          visible: isOpen,
          child: HStack(
            [
              //
              VStack(
                [
                  "Name".text.gray500.medium.sm.make(),
                  "${widget.stop.name}"
                      .text
                      .medium
                      .xl
                      .make()
                      .pOnly(bottom: Vx.dp20),
                  // "Note".text.gray500.medium.sm.make(),
                  // "${widget.stop.note}"
                  //     .text
                  //     .medium
                  //     .xl
                  //     .make()
                  //     .pOnly(bottom: Vx.dp20),
                ],
              ).expand(),
              //call
              (widget.stop.phone.isNotBlank && widget.canCall)
                  ? CustomButton(
                      icon: FlutterIcons.phone_call_fea,
                      iconColor: Colors.white,
                      title: "",
                      color: Colors.greenAccent[700],
                      shapeRadius: Vx.dp16,
                      onPressed: () async {
                        final phoneNumber = "tel:${widget.stop.phone}";
                        if (await canLaunch(phoneNumber)) {
                          launch(phoneNumber);
                        }
                      },
                    ).wh(Vx.dp64, Vx.dp40).p12()
                  : UiSpacer.emptySpace(),
            ],
          ),
        ),
      ],
    )
        .wFull(context)
        .p12()
        .box
        .roundedSM
        .border(color: AppColor.primaryColor)
        .make()
        .pOnly(bottom: Vx.dp12);
  }
}

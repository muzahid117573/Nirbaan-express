import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetailsVendorInfoView extends StatelessWidget {
  const OrderDetailsVendorInfoView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HStack(
          [
            //
            VStack(
              [
                "Contact Support".text.red800.xl2.bold.make(),
                // vm.order.vendor.name.text.medium.xl
                //     .make()
                //     .pOnly(bottom: Vx.dp20),
              ],
            ).expand(),
            //call
            vm.order.canChatVendor
                ? CustomButton(
                    icon: FlutterIcons.phone_call_fea,
                    iconColor: Colors.white,
                    color: Colors.greenAccent[700],
                    shapeRadius: Vx.dp20,
                    onPressed: vm.callVendor,
                  ).wh(Vx.dp64, Vx.dp40).p12()
                : UiSpacer.emptySpace(),
          ],
        ),

        //chat
        // vm.order.canChatVendor
        //     ? CustomButton(
        //         icon: FlutterIcons.chat_ent,
        //         iconColor: Colors.white,
        //         title: "Chat with vendor",
        //         color: AppColor.primaryColor,
        //         onPressed: vm.chatVendor,
        //       ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
        //     : UiSpacer.emptySpace(),

        //rate vendor
      ],
    );
  }
}

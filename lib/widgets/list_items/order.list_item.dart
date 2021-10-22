import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    this.order,
    this.onPayPressed,
    this.orderPressed,
    Key key,
  }) : super(key: key);

  final Order order;
  final Function onPayPressed;
  final Function orderPressed;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HStack(
          [
            //vendor image
            // CustomImage(
            //   imageUrl: order.vendor.featureImage,
            //   width: context.percentWidth * 20,
            //   boxFit: BoxFit.cover,
            //   height: context.percentHeight * 12,
            // ),

            //
            VStack(
              [
                //
                HStack(
                  [
                    "#${order.code}".text.xl.medium.make().expand(),
                    "${AppStrings.currencySymbol} ${order.total.numCurrency}"
                        .text
                        .xl
                        .semiBold
                        .make(),
                  ],
                ),
                Divider(),

                //
                "${order.vendor.name}".text.xl.semiBold.make().py2(),
                //amount and total products
                HStack(
                  [
                    (order.isPackageDelivery
                            ? order.packageType.name
                            : "${order.orderProducts.length ?? 0} Product(s)")
                        .text
                        .medium
                        .make()
                        .expand(),
                    "${order.status}"
                        .allWordsCapitilize()
                        .text
                        .lg
                        .color(
                          AppColor.getStausColor(order.status),
                        )
                        .medium
                        .make(),
                  ],
                ),
                //time & status
                HStack(
                  [
                    //time
                    "${order.paymentMethod?.name}"
                        .text
                        .lg
                        .medium
                        .make()
                        .expand(),
                    "${order.formattedDate}".text.sm.make(),
                  ],
                ),
              ],
            ).p12().expand(),
          ],
        ),

        //
        //payment is pending
        // order.isPaymentPending
        //     ? CustomButton(
        //         title: "PAY FOR ORDER".i18n,
        //         titleStyle: context.textTheme.bodyText1.copyWith(
        //           color: Colors.white,
        //         ),
        //         icon: FlutterIcons.credit_card_fea,
        //         iconSize: 18,
        //         onPressed: onPayPressed,
        //         shapeRadius: 0,
        //       )
        UiSpacer.emptySpace(),
      ],
    )
        .box
        .roundedSM
        .border(color: Colors.grey[300])
        .make()
        .onInkTap(orderPressed)
        .card
        .elevation(1)
        .clip(Clip.antiAlias)
        .roundedSM
        .make();
  }
}

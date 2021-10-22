import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    this.subTotal,
    this.discount,
    this.deliveryFee,
    this.tax,
    this.vendorTax,
    this.total,
    this.driverTip = 0.00,
    Key key,
  }) : super(key: key);

  final double subTotal;
  final double discount;
  final double deliveryFee;
  final double tax;
  final String vendorTax;
  final double total;
  final double driverTip;
  @override
  Widget build(BuildContext context) {
    OrderDetailsViewModel vm;
    final currencySymbol = AppStrings.currencySymbol;
    return VStack(
      [
        "Order Summary".text.semiBold.xl.make().pOnly(bottom: Vx.dp12),
        AmountTile("Subtotal", (subTotal ?? 0).numCurrency).py2(),
        AmountTile(
                "Discount", "- $currencySymbol ${(discount ?? 0).numCurrency}")
            .py2(),
        AmountTile("Delivery Fee",
                "+ $currencySymbol ${(deliveryFee ?? 0).numCurrency}")
            .py2(),
        // AmountTile("Tax (%s)".i18n.fill([vendorTax ?? 0]),
        //         "+ $currencySymbol ${(tax ?? 0).numCurrency}")
        //     .py2(),
        DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
        Visibility(
          visible: driverTip != null && driverTip > 0,
          child: VStack(
            [
              AmountTile("Driver Tip",
                      "+ $currencySymbol ${(driverTip ?? 0).numCurrency}")
                  .py2(),
              DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
            ],
          ),
        ),
        AmountTile(
            "Total Amount", "$currencySymbol ${(total ?? 0).numCurrency}"),
      ],
    );
  }
}

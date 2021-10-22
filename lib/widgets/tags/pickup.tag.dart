import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class PickupTag extends StatelessWidget {
  const PickupTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "Pickup"
        .text
        .white
        .make()
        .py4()
        .px8()
        .box
        .roundedLg
        .color(AppColor.pickupColor)
        .make();
  }
}
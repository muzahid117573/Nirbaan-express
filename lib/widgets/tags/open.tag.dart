import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class OpenTag extends StatelessWidget {
  const OpenTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "Open"
        .text
        .white
        .make()
        .py4()
        .px8()
        .box
        .roundedLg
        .color(AppColor.openColor)
        .make();
  }
}

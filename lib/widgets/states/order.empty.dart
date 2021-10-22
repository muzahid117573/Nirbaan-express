import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      imageUrl: AppImages.emptyCart,
      title: "No Order",
      description: "When you place an order, they will appear here",
    ).p20();
  }
}

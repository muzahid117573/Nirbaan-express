import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/states/empty.state.dart';

class EmptyDeliveryAddress extends StatelessWidget {
  const EmptyDeliveryAddress({
    Key key,
    this.selection = false,
  }) : super(key: key);

  final bool selection;
  @override
  Widget build(BuildContext context) {
    return EmptyState(
      imageUrl: AppImages.addressPin,
      title: selection
          ? "No Delivery Address Selected"
          : "No Delivery Address Found",
      description: selection
          ? "Please select a delivery address"
          : "When you add delivery addresses, they will appear here",
    );
  }
}

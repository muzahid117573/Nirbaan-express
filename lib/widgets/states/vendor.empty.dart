import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/states/empty.state.dart';

class EmptyVendor extends StatelessWidget {
  const EmptyVendor({this.showDescription = true, Key key}) : super(key: key);

  final bool showDescription;
  @override
  Widget build(BuildContext context) {
    return EmptyState(
      imageUrl: AppImages.onboarding1,
      title: "Service Not Available",
      description:
          showDescription ? "Service will be available in your area soon" : "",
    );
  }
}

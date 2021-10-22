import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/services/auth.service.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class OnboardingViewModel extends MyBaseViewModel {
  OnboardingViewModel(BuildContext context) {
    this.viewContext = context;
  }

  final PageController pageController = PageController();

  final List<OnBoardModel> onBoardData = [
    OnBoardModel(
      title: "PickUp From Doorstep",
      description: "Our Pickup Man Pickup Your Parcel",
      imgUrl: AppImages.onboarding1,
    ),
    OnBoardModel(
      title: "Deliver To Customers",
      description: "We deliver Your Products To Your Customers Fastly & Safely",
      imgUrl: AppImages.onboarding2,
    ),
    OnBoardModel(
      title: "Fastest Delivery & Payment",
      description: "We Ensure Fastest Delivery & Instant Payment",
      imgUrl: AppImages.onboarding3,
    ),
  ];

  void onDonePressed() async {
    //
    await AuthServices.firstTimeCompleted();
    viewContext.navigator.pushNamedAndRemoveUntil(
      AppRoutes.homeRoute,
      (route) => false,
    );
  }
}

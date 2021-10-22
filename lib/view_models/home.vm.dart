import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';

import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/parcel/parcel.page.dart';

class HomeViewModel extends MyBaseViewModel {
  //
  HomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  Widget homeView;

  @override
  void initialise() async {
    VendorType vendorType = VendorType.fromJson(AppStrings.enabledVendorType);
    getHomeView(vendorType);
    notifyListeners();
    //determine if homeview should be multiple vendor types or single vendor page
    if (!AppStrings.isSingleVendorMode) {}
  }

  void getHomeView(VendorType vendorType) {
    // switch (vendorType.slug) {
    //   case "parcel":
    homeView = ParcelPage(vendorType);
    // break;
    // case "grocery":
    //   homeView = GroceryPage(vendorType);
    //   break;
    // case "food":
    //   homeView = VendorPage(vendorType);
    //   break;
    // case "pharmacy":
    //   homeView = PharmacyPage(vendorType);
    //   break;
    // case "service":
    //   homeView = ServicePage(vendorType);
    //   break;
    // default:
    //   homeView = VendorPage(vendorType);
    //   break;
    // }
  }
}

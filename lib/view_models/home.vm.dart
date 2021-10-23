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

    homeView = ParcelPage(vendorType);
    notifyListeners();
  }
}

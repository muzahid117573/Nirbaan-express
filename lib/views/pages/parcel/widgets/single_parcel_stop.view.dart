import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_form_input.dart';
import 'package:velocity_x/velocity_x.dart';

class SingleParcelDeliveryStopsView extends StatelessWidget {
  const SingleParcelDeliveryStopsView(this.vm, {Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        //from
        ParcelFormInput(
          iconData: FlutterIcons.car_ant,
          iconColor: Colors.green[700],
          labelText: "FROM",
          hintText: "Pickup Location",
          tec: vm.fromTEC,
          onInputTap: vm.changePickupAddress,
          formValidator: (value) => FormValidator.validateDeliveryAddress(
            value,
            errorTitle: "Pickup Location",
            deliveryaddress: vm.pickupLocation,
            vendor: vm.selectedVendor,
          ),
        ),
        UiSpacer.formVerticalSpace(),

        //to
        ParcelFormInput(
          iconData: FlutterIcons.location_pin_ent,
          iconColor: Colors.red[700],
          labelText: "TO",
          hintText: "Dropoff Location",
          tec: vm.toTEC,
          onInputTap: vm.changeDropOffAddress,
          formValidator: (value) => FormValidator.validateDeliveryAddress(
            value,
            errorTitle: "Dropoff Location",
            deliveryaddress: vm.dropoffLocation,
            vendor: vm.selectedVendor,
          ),
        ),
        UiSpacer.formVerticalSpace(),
      ],
    );
  }
}

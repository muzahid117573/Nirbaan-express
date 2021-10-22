import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorTypeListItem extends StatelessWidget {
  const VendorTypeListItem(this.vendorType, {this.onPressed, Key key})
      : super(key: key);

  final VendorType vendorType;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: vendorType.id,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: InkWell(
            onTap: onPressed,
            child: Container(
                height: 80,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: vendorType.logo,
                        fit: BoxFit.cover,
                      ),
                    )),
                    // CustomImage(
                    //   imageUrl: vendorType.logo,
                    //   width: Vx.dp40,
                    //   height: Vx.dp40,
                    // ).p12(),
                    //
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.95),
                                Colors.transparent
                              ])),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Place Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
              .box
              .withRounded(value: 20)
              .shadow
              .color(Vx.hexToColor(vendorType.color).withOpacity(0.7))
              .make()
              .pOnly(bottom: Vx.dp20),
        ),
      ),
    );
  }
}

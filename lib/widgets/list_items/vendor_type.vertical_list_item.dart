import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorTypeVerticalListItem extends StatelessWidget {
  const VendorTypeVerticalListItem(this.vendorType, {this.onPressed, Key key})
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
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.85),
                                  Colors.transparent
                                ])),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: VStack(
                            [
                              vendorType.name.text.xl.white.semiBold.make(),
                              //vendorType.description.text.white.sm.make(),
                            ],
                          ),
                        )),
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

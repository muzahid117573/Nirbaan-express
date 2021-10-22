import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    this.title,
    this.icon,
    this.child,
    this.divider = true,
    this.topDivider = false,
    this.suffix,
    this.onPressed,
    Key key,
  }) : super(key: key);

  //
  final String title;
  final Icon icon;
  final Widget child;
  final bool divider;
  final bool topDivider;
  final Widget suffix;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.green[500],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: HStack(
              [
                //

                (child ?? title.text.lg.light.make()).expand(),
                //
                suffix ?? icon
              ],
            ).py12().px8(),
          ),
        ),

        //
        // topDivider
        //     ? Divider(
        //         height: 1,
        //         thickness: 2,
        //       )
        //     : SizedBox.shrink(),

        //

        //
        // divider
        //     ? Divider(
        //         height: 1,
        //         thickness: 2,
        //       )
        //     : SizedBox.shrink(),
      ],
    ).onInkTap(onPressed);
  }
}

import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key key,
    this.imageUrl,
    this.title = "",
    this.actionText = "Action",
    this.description = "",
    this.showAction = false,
    this.showImage = true,
    this.actionPressed,
    this.auth = false,
  }) : super(key: key);

  final String title;
  final String actionText;
  final String description;
  final String imageUrl;
  final Function actionPressed;
  final bool showAction;
  final bool showImage;
  final bool auth;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        (imageUrl != null && imageUrl.isNotBlank)
            ? Image.asset(imageUrl)
                .wh(
                  Vx.dp64 * 1.2,
                  Vx.dp64 * 1.2,
                )
                .box
                .makeCentered()
                .wFull(context)
            : UiSpacer.emptySpace(),

        //
        (title != null && title.isNotEmpty)
            ? title.text.xl.semiBold.center.makeCentered()
            : SizedBox.shrink(),

        //
        (auth && showImage)
            ? Image.asset("assets/images/user.png")
                .wh(
                  100,
                  100,
                )
                .box
                .makeCentered()
                .py12()
                .wFull(context)
            : SizedBox.shrink(),
        //
        auth
            ? "Please login To Access Your Profile"
                .text
                .center
                .lg
                .light
                .makeCentered()
                .py4()
            : description.isNotEmpty
                ? description.text.lg.light.center.makeCentered()
                : SizedBox.shrink(),

        //
        auth
            ? Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomButton(
                  title: "Login",
                  onPressed: actionPressed,
                ).centered(),
              )
            : showAction
                ? CustomButton(
                    title: actionText,
                    onPressed: actionPressed,
                  ).centered().py24()
                : SizedBox.shrink(),
      ],
    );
  }
}

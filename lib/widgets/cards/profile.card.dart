import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/profile.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/menu_item.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.model, {Key key}) : super(key: key);

  final ProfileViewModel model;
  @override
  Widget build(BuildContext context) {
    return model.authenticated
        ? VStack(
            [
              //profile card
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HStack(
                  [
                    //
                    CachedNetworkImage(
                      imageUrl: model.currentUser.photo,
                      progressIndicatorBuilder: (context, imageUrl, progress) {
                        return BusyIndicator();
                      },
                      errorWidget: (context, imageUrl, progress) {
                        return Image.asset(
                          AppImages.user,
                        );
                      },
                    ).wh(Vx.dp64, Vx.dp64).box.roundedFull.make(),

                    //
                    VStack(
                      [
                        //name
                        model.currentUser.name.text.xl.semiBold.make(),
                        //email
                        model.currentUser.email.text.light.make(),
                        //share invation code
                        AppStrings.enableReferSystem
                            ? "Share & Earn Money"
                                .text
                                .sm
                                .color(context.textTheme.bodyText1.color)
                                .make()
                                .box
                                .px4
                                .roundedSM
                                .border(color: Colors.grey)
                                .make()
                                .onInkTap(model.shareReferralCode)
                                .py4()
                            : UiSpacer.emptySpace(),
                      ],
                    ).px20()

                    //
                  ],
                )
                    .wFull(context)
                    .px12()
                    .py8()
                    .box
                    .border(color: Theme.of(context).cardColor)
                    .color(Theme.of(context).cardColor)
                    .shadow
                    .roundedSM
                    .make(),
              ),

              //
              MenuItem(
                icon: Icon(
                  Icons.manage_accounts_outlined,
                ),
                title: "Edit Profile",
                onPressed: model.openEditProfile,
                topDivider: true,
              ),
              //change password
              MenuItem(
                icon: Icon(
                  Icons.vpn_key_outlined,
                ),
                title: "Change Password",
                onPressed: model.openChangePassword,
                topDivider: true,
              ),
              //Wallet
              MenuItem(
                icon: Icon(
                  Icons.account_balance_wallet_outlined,
                ),
                title: "Wallet",
                onPressed: model.openWallet,
                topDivider: true,
              ),
              //addresses
              MenuItem(
                icon: Icon(
                  Icons.local_shipping_outlined,
                ),
                title: "Delivery Addresses",
                onPressed: model.openDeliveryAddresses,
                topDivider: true,
              ),
              //favourites
              // MenuItem(
              //   icon: Icon(
              //     Icons.favorite_border_outlined,
              //   ),
              //   title: "Favourites",
              //   onPressed: model.openFavourites,
              //   topDivider: true,
              // ),
              //
              MenuItem(
                icon: Icon(
                  Icons.logout_outlined,
                ),
                child: "Logout".text.red500.make(),
                onPressed: model.logoutPressed,
                divider: false,
                suffix: Icon(
                  FlutterIcons.logout_ant,
                  size: 16,
                ),
              ),
            ],
          )
            .wFull(context)
            .px12()
            .py8()
            .box
            .border(color: Theme.of(context).cardColor)
            .color(Theme.of(context).cardColor)
            .shadow
            .roundedSM
            .make()
        // .wFull(context)
        // .box
        // .border(color: Theme.of(context).cardColor)
        // .color(Theme.of(context).cardColor)
        // .shadow
        // .roundedSM
        // .make()
        : EmptyState(
            auth: true,
            showAction: true,
            actionPressed: model.openLogin,
          ).py12();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/profile.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/cards/profile.card.dart';
import 'package:fuodz/widgets/menu_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return BasePage(
            body: VStack(
              [
                //
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: "Settings".text.xl2.semiBold.make(),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: "Profile & App Settings".text.lg.light.make(),
                  ),
                ),

                //profile card
                ProfileCard(model).py12(),

                //menu
                VxBox(
                  child: VStack(
                    [
                      //
                      MenuItem(
                        icon: Icon(
                          Icons.notifications_active_outlined,
                        ),
                        title: "Notifications",
                        onPressed: model.openNotification,
                      ),

                      //
                      // MenuItem(
                      //   title: "Rate & Review".i18n,
                      //   onPressed: model.openReviewApp,
                      // ),

                      //
                      MenuItem(
                        title: "Version",
                        suffix: model.appVersionInfo.text.make(),
                      ),

                      //
                      MenuItem(
                        icon: Icon(
                          Icons.security_outlined,
                        ),
                        title: "Privacy Policy",
                        onPressed: model.openPrivacyPolicy,
                      ),
                      //
                      // MenuItem(
                      //   icon: Icon(
                      //     Icons.gavel_outlined,
                      //   ),
                      //   title: "Terms & Conditions",
                      //   onPressed: model.openTerms,
                      // ),
                      //
                      // MenuItem(
                      //   icon: Icon(
                      //     Icons.contact_support_outlined,
                      //   ),
                      //   title: "Contact Us",
                      //   onPressed: model.openContactUs,
                      // ),
                      //
                      // MenuItem(
                      //   title: "Language".i18n,
                      //   divider: false,
                      //   suffix: Icon(
                      //     FlutterIcons.language_ent,
                      //   ),
                      //   onPressed: model.changeLanguage,
                      // ),
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
                )
                    // .border(color: Theme.of(context).cardColor)
                    // .color(Theme.of(context).cardColor)
                    // .shadow
                    // .roundedSM
                    .make(),

                //
              ],
            ).p20().scrollVertical(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/orders.vm.dart';
import 'package:fuodz/view_models/parcel.vm.dart';
import 'package:fuodz/views/pages/order/orders.page.dart';
import 'package:fuodz/views/pages/parcel/new_parcel.page.dart';
import 'package:fuodz/views/pages/profile/profile.page.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ParcelPage extends StatefulWidget {
  ParcelPage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;

  @override
  _ParcelPageState createState() => _ParcelPageState();
}

class _ParcelPageState extends State<ParcelPage> {
  var pendinglength;
  var acceptlength;
  var canceledlength;
  var inshiplength;
  var deliveredlength;
  var pikedlength;

  int _selectedIndex = 0;
  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pagelist = <Widget>[
      createFooOrBarWidget(context),
      OrdersPage(),
      ProfilePage(),
    ];

    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: pagelist[pageindex],
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          pageindex = value;
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(FlutterIcons.home_ant), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FlutterIcons.inbox_ant), label: 'Orders'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin_outlined,
            ),
            label: 'Profile'),
        // icon: CircleAvatar(
        //   radius: 14,
        //   backgroundImage: AssetImage("assets/images/user.png"),
        // ),
        // label: "Profile",
      ],
    );
  }

  Widget createFooOrBarWidget(BuildContext context) {
    String pendingCount = pendinglength.toString();
    String acceptCount = acceptlength.toString();
    String cancelCount = canceledlength.toString();
    String deliverCount = deliveredlength.toString();
    String inshipCount = inshiplength.toString();
    String pickedCount = pikedlength.toString();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    OrdersViewModel vmm = OrdersViewModel(context);
    GlobalKey pageKey = GlobalKey<State>();
    return ViewModelBuilder<ParcelViewModel>.reactive(
        viewModelBuilder: () =>
            ParcelViewModel(context, vendorType: widget.vendorType),
        builder: (context, vm, child) {
          return BasePage(
            //showAppBar: true,
            // showLeadingAction: !AppStrings.isSingleVendorMode,
            // elevation: 0,
            // showCart: true,
            // title: "${vm.vendorType.name}",
            appBarColor: AppColor.primaryColor,
            appBarItemColor: context.theme.backgroundColor,
            key: pageKey,
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: vm.refreshController,
              onRefresh: () {
                vm.refreshController.refreshCompleted();
                setState(() {
                  pageKey = GlobalKey<State>();
                });
              },
              child: SingleChildScrollView(
                child: VStack(
                  [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                      ),
                      child: VStack(
                        [
                          UiSpacer.verticalSpace(),
                          UiSpacer.verticalSpace(),

                          Center(
                            child: Text(
                              "Parcel Tracking",
                              style: new TextStyle(
                                fontSize: 30.0,
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          //
                          CustomTextFormField(
                            // labelText: "Order Code",
                            isReadOnly: vm.isBusy,

                            hintText: "Search By Order Code",
                            onFieldSubmitted: vm.trackOrder,
                            fillColor: context.brightness != Brightness.dark
                                ? Colors.white
                                : Colors.blueGrey[400],
                            // loading and scan icon
                            suffixIcon: !vm.isBusy
                                ? Icon(
                                    FlutterIcons.scan1_ant,
                                  ).p4()
                                // .onInkTap(vm.openCodeScanner)
                                : BusyIndicator(
                                    color: AppColor.primaryColor,
                                  ).p8(),
                          ).py12().px20(),
                        ],
                      )
                          .p20()
                          .box
                          // .color(context.brightness != Brightness.dark
                          //     ? AppColor.primaryColor
                          //     : Colors.blueGrey[800])
                          .make(),
                    ),

                    UiSpacer.verticalSpace(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 120,
                              width: screenWidth / 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.orange[100],
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            bottom: 2,
                                            top: 5),
                                        child: pendingCount == "null"
                                            ? Text(
                                                "0",
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              )
                                            : Text(
                                                pendingCount,
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "Pending",
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                elevation: 8,
                                shadowColor: Colors.grey[100],
                                margin: EdgeInsets.all(15),
                              ),
                            ),
                            Container(
                              height: 120,
                              width: screenWidth / 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.orange[100],
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            bottom: 2,
                                            top: 5),
                                        child: acceptCount == "null"
                                            ? Text(
                                                "0",
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              )
                                            : Text(
                                                acceptCount,
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "Accepted",
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                elevation: 8,
                                shadowColor: Colors.grey[100],
                                margin: EdgeInsets.all(15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 120,
                              width: screenWidth / 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.orange[100],
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            bottom: 2,
                                            top: 5),
                                        child: pickedCount == "null"
                                            ? Text(
                                                "0",
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              )
                                            : Text(
                                                pickedCount,
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "Picked",
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                elevation: 8,
                                shadowColor: Colors.grey[100],
                                margin: EdgeInsets.all(15),
                              ),
                            ),
                            Container(
                              height: 120,
                              width: screenWidth / 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.orange[100],
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            bottom: 2,
                                            top: 5),
                                        child: inshipCount == "null"
                                            ? Text(
                                                "0",
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              )
                                            : Text(
                                                inshipCount,
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "In Shipment",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                elevation: 8,
                                shadowColor: Colors.grey[100],
                                margin: EdgeInsets.all(15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 120,
                              width: screenWidth / 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.orange[100],
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            bottom: 2,
                                            top: 5),
                                        child: deliverCount == "null"
                                            ? Text(
                                                "0",
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              )
                                            : Text(
                                                deliverCount,
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "Delivered",
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                elevation: 8,
                                shadowColor: Colors.grey[100],
                                margin: EdgeInsets.all(15),
                              ),
                            ),
                            Container(
                              height: 120,
                              width: screenWidth / 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.orange[100],
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            bottom: 2,
                                            top: 5),
                                        child: cancelCount == "null"
                                            ? Text(
                                                "0",
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              )
                                            : Text(
                                                cancelCount,
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.blueGrey[800],
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "Canceled",
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                elevation: 8,
                                shadowColor: Colors.grey[100],
                                margin: EdgeInsets.all(15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    //
                    UiSpacer.verticalSpace(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          child: Text(
                            "Place Order",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              primary: Colors.blueGrey[800],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            context.nextPage(NewParcelPage(widget.vendorType));
                          },
                        ),
                      ),
                    ),

                    UiSpacer.verticalSpace(),
                    // VendorTypeListItem(
                    //   vm.vendorType,
                    //   onPressed: () {
                    //     //open the new parcel page

                    //   },
                    // ).px20(),
                    //recent orders
                    // UiSpacer.verticalSpace(),
                    // RecentOrdersView(vendorType: widget.vendorType),
                    // UiSpacer.verticalSpace(),
                  ],
                ).scrollVertical(),
              ),
            ),
          );
        });
  }

  Future<bool> _getpendingStatus() async {
    final userToken = await AuthServices.getAuthBearerToken();

    print(userToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userToken",
    };

    var urlorder =
        Uri.parse('https://admin.nirbaanexpress.com/api/order/pending');
    var response = await http.get(urlorder, headers: headers);

    pendinglength = response.body;
  }

  Future<bool> _getAcceptedStatus() async {
    final userToken = await AuthServices.getAuthBearerToken();

    print(userToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userToken",
    };

    var urlorder =
        Uri.parse('https://admin.nirbaanexpress.com/api/order/preparing');
    var response = await http.get(urlorder, headers: headers);

    acceptlength = response.body;
  }

  Future<bool> _getPickedStatus() async {
    final userToken = await AuthServices.getAuthBearerToken();

    print(userToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userToken",
    };

    var urlorder =
        Uri.parse('https://admin.nirbaanexpress.com/api/order/ready');
    var response = await http.get(urlorder, headers: headers);

    pikedlength = response.body;
  }

  Future<bool> _getInshipStatus() async {
    final userToken = await AuthServices.getAuthBearerToken();

    print(userToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userToken",
    };

    var urlorder =
        Uri.parse('https://admin.nirbaanexpress.com/api/order/enroute');
    var response = await http.get(urlorder, headers: headers);

    inshiplength = response.body;
  }

  Future<bool> _getDeliveredStatus() async {
    final userToken = await AuthServices.getAuthBearerToken();

    print(userToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userToken",
    };

    var urlorder =
        Uri.parse('https://admin.nirbaanexpress.com/api/order/delivered');
    var response = await http.get(urlorder, headers: headers);

    deliveredlength = response.body;
  }

  Future<bool> _getCancelledStatus() async {
    final userToken = await AuthServices.getAuthBearerToken();

    print(userToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userToken",
    };

    var urlorder =
        Uri.parse('https://admin.nirbaanexpress.com/api/order/cancelled');
    var response = await http.get(urlorder, headers: headers);

    canceledlength = response.body;
  }

  @override
  void initState() {
    if (isAuthenticated()) {
      _getAcceptedStatus();
      _getpendingStatus();
      _getCancelledStatus();
      _getDeliveredStatus();
      _getPickedStatus();
      _getInshipStatus();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (isAuthenticated()) {
      _getAcceptedStatus();
      _getpendingStatus();
      _getCancelledStatus();
      _getDeliveredStatus();
      _getPickedStatus();
      _getInshipStatus();
    }

    super.dispose();
  }

  bool isAuthenticated() {
    return AuthServices.authenticated();
  }
}

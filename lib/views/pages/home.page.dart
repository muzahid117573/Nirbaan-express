import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/view_models/home.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget homeView;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => LocationService.prepareLocationListener(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: "Press back again to close",
      child: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return BasePage(
            body: model.homeView,
          );
        },
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/views/pages/cart/cart.page.dart';
import 'package:velocity_x/velocity_x.dart';

class PageCartAction extends StatefulWidget {
  const PageCartAction({this.color = Colors.white, Key key}) : super(key: key);
  final Color color;

  @override
  _PageCartActionState createState() => _PageCartActionState();
}

class _PageCartActionState extends State<PageCartAction> {
  @override
  void initState() {
    super.initState();
    CartServices.getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CartServices.cartItemsCountStream.stream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Icon(
          FlutterIcons.cart_mco,
          color: context.brightness != Brightness.dark
              ? Colors.blueGrey[800]
              : Colors.amber[300],
          size: 30,
        )
            .badge(
              count: snapshot.data,
              size: 17,
              color: context.brightness != Brightness.dark
                  ? Colors.blueGrey[800]
                  : Colors.amber[300],
              textStyle: TextStyle(
                  color: context.brightness != Brightness.dark
                      ? Colors.amber[300]
                      : Colors.blueGrey[800],
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            )
            .centered()
            .pOnly(right: 12)
            .onInkTap(
          () async {
            //
            context.nextPage(CartPage());
          },
        );
      },
    );
  }
}

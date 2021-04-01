import 'package:flutter/material.dart';
import 'package:test_203version/app/modules/test_page/menu_drawer.dart';
import 'app_bar.dart' as app;
import 'explore.dart';
import 'side_bar.dart';

class TestPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isWeb770 = size.width <= 770;
    return Scaffold(
      drawer: isWeb770 ? Drawer(child: MenuDrawer()) : null,
      body: SafeArea(
        child: !isWeb770
            ? Row(children: [const SideBar(), const Explore()])
            : Column(children: [const app.AppBar(), const Explore()]),
      ),
    );
  }
}

// ignore_for_file: unused_field, library_private_types_in_public_api, camel_case_types, unused_import, prefer_const_constructors, file_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:milkmandeliveryboynew/controller/route_controller.dart';
import 'package:milkmandeliveryboynew/helpar/fontfamily_model.dart';
import 'package:milkmandeliveryboynew/screen/Routes/total_routes.dart';
import 'package:milkmandeliveryboynew/screen/dashboard_screen.dart';
import 'package:milkmandeliveryboynew/screen/myorder_screen.dart';
import 'package:milkmandeliveryboynew/screen/subscription_order.dart';
import 'package:milkmandeliveryboynew/screen/profile_screen.dart';
import 'package:milkmandeliveryboynew/utils/Colors.dart';
import 'package:flutter/material.dart';

int selectedIndex = 0;

class BottoBarScreen extends StatefulWidget {
  const BottoBarScreen({Key? key}) : super(key: key);

  @override
  _BottoBarScreenState createState() => _BottoBarScreenState();
}

class _BottoBarScreenState extends State<BottoBarScreen>
    with TickerProviderStateMixin {
  RouteController routeController = Get.put(RouteController());
  late int _lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      routeController.getRouteData();
    });
    tabController = TabController(length: 4, vsync: this);
  }

  List<Widget> myChilders = [
    DashBoardScreen(),
    MyBookingScreen(isBack: "2"),

    //MyPriscriptionOrder(isBack: "2"),
    TotalRoutes(isBack: "2"),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exit(0);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: greyColor,
          // backgroundColor: BlackColor,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontFamily: FontFamily.gilroyBold,
            // fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          fixedColor: gradient.defoultColor,
          unselectedLabelStyle: const TextStyle(
            fontFamily: FontFamily.gilroyMedium,
          ),
          currentIndex: selectedIndex,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/dashboard.png",
                color: selectedIndex == 0 ? gradient.defoultColor : greycolor,
                height: MediaQuery.of(context).size.height / 40,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/myorder.png",
                color: selectedIndex == 1 ? gradient.defoultColor : greycolor,
                height: MediaQuery.of(context).size.height / 37,
              ),
              label: 'My Order',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/Prescription.png",
                color: selectedIndex == 2 ? gradient.defoultColor : greycolor,
                height: MediaQuery.of(context).size.height / 35,
              ),
              label: 'Subscription',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/Profile.png",
                color: selectedIndex == 3 ? gradient.defoultColor : greycolor,
                height: MediaQuery.of(context).size.height / 35,
              ),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {});
            selectedIndex = index;
          },
        ),
        body: myChilders[selectedIndex],
      ),
    );
  }
}

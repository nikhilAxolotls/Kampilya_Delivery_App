// ignore_for_file: unused_field, library_private_types_in_public_api, camel_case_types, unused_import, prefer_const_constructors, file_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:milkmandeliveryboynew/controller/bottombar_controller.dart';
import 'package:milkmandeliveryboynew/controller/route_controller.dart';
import 'package:milkmandeliveryboynew/helpar/fontfamily_model.dart';
import 'package:milkmandeliveryboynew/screen/Routes/total_routes.dart';
import 'package:milkmandeliveryboynew/screen/dashboard_screen.dart';
import 'package:milkmandeliveryboynew/screen/myorder_screen.dart';
import 'package:milkmandeliveryboynew/screen/no_internet_screen.dart';
import 'package:milkmandeliveryboynew/screen/subscription_order.dart';
import 'package:milkmandeliveryboynew/screen/profile_screen.dart';
import 'package:milkmandeliveryboynew/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:milkmandeliveryboynew/utils/connectivity_service.dart';

class BottoBarScreen extends StatefulWidget {
  const BottoBarScreen({Key? key}) : super(key: key);

  @override
  _BottoBarScreenState createState() => _BottoBarScreenState();
}

class _BottoBarScreenState extends State<BottoBarScreen>
    with TickerProviderStateMixin {
  BottomBarController bottomBarController = Get.find();
  RouteController routeController = Get.put(RouteController());
  late int _lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;
  late TabController tabController;

  final ConnectivityService _connectivityService = ConnectivityService();
  bool _showingNoInternetScreen = false;
  int _pendingNavigationIndex = -1;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      routeController.getRouteData();
    });
    tabController = TabController(length: 4, vsync: this);

    // Initialize connectivity service
    _connectivityService.initialize();

    // Listen to connectivity changes
    _connectivityService.isConnected.addListener(_onConnectivityChanged);
  }

  @override
  void dispose() {
    _connectivityService.isConnected.removeListener(_onConnectivityChanged);
    tabController.dispose();
    super.dispose();
  }

  void _onConnectivityChanged() {
    if (_connectivityService.isConnected.value) {
      // Connection restored
      if (_showingNoInternetScreen) {
        // Dismiss no internet screen
        Navigator.of(context).pop();
        _showingNoInternetScreen = false;

        // Navigate to pending tab if any
        if (_pendingNavigationIndex >= 0) {
          bottomBarController.changeIndex(_pendingNavigationIndex);
          _pendingNavigationIndex = -1;
        }
      }
    }
  }

  void _handleBottomNavTap(int index) {
    // Check if connected
    if (!_connectivityService.hasConnection) {
      // Show no internet screen
      _pendingNavigationIndex = index;
      _showNoInternetScreen();
    } else {
      // Normal navigation
      bottomBarController.changeIndex(index);
    }
  }

  void _showNoInternetScreen() {
    if (_showingNoInternetScreen) return;

    _showingNoInternetScreen = true;

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => NoInternetScreen(
              onConnected: () {
                // This callback is triggered when connection is restored
                if (_showingNoInternetScreen) {
                  Navigator.of(context).pop();
                  _showingNoInternetScreen = false;

                  // Navigate to pending tab
                  if (_pendingNavigationIndex >= 0) {
                    bottomBarController.changeIndex(_pendingNavigationIndex);
                    _pendingNavigationIndex = -1;
                  }
                }
              },
            ),
            fullscreenDialog: true,
          ),
        )
        .then((_) {
          // Screen dismissed manually (e.g., back button)
          _showingNoInternetScreen = false;
          _pendingNavigationIndex = -1;
        });
  }

  List<Widget> myChilders = [
    DashBoardScreen(),
    MyBookingScreen(isBack: "2"),

    //MyPriscriptionOrder(isBack: "2"),
    TotalRoutes(isBack: false),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exit(0);
      },
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: greyColor,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
              fontFamily: FontFamily.gilroyBold,
              fontSize: 12,
            ),
            fixedColor: gradient.defoultColor,
            unselectedLabelStyle: const TextStyle(
              fontFamily: FontFamily.gilroyMedium,
            ),
            currentIndex: bottomBarController.selectedIndex.value,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/dashboard.png",
                  color: bottomBarController.selectedIndex.value == 0
                      ? gradient.defoultColor
                      : greycolor,
                  height: MediaQuery.of(context).size.height / 40,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/myorder.png",
                  color: bottomBarController.selectedIndex.value == 1
                      ? gradient.defoultColor
                      : greycolor,
                  height: MediaQuery.of(context).size.height / 37,
                ),
                label: 'My Order',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/Prescription.png",
                  color: bottomBarController.selectedIndex.value == 2
                      ? gradient.defoultColor
                      : greycolor,
                  height: MediaQuery.of(context).size.height / 35,
                ),
                label: 'Assigned Routes',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/Profile.png",
                  color: bottomBarController.selectedIndex.value == 3
                      ? gradient.defoultColor
                      : greycolor,
                  height: MediaQuery.of(context).size.height / 35,
                ),
                label: 'Profile',
              ),
            ],
            onTap: _handleBottomNavTap,
          ),
        ),
        body: Obx(() => myChilders[bottomBarController.selectedIndex.value]),
      ),
    );
  }
}

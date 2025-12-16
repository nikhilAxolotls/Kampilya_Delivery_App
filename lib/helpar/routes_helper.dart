// ignore_for_file: prefer_const_constructors

import 'package:milkmandeliveryboynew/onbording_screen.dart';
import 'package:milkmandeliveryboynew/screen/Routes/route_details_screen.dart';
import 'package:milkmandeliveryboynew/screen/Routes/total_routes.dart';
import 'package:milkmandeliveryboynew/screen/myorder_screen.dart';
import 'package:milkmandeliveryboynew/screen/orderdetails_screen.dart';
import 'package:milkmandeliveryboynew/screen/subscription_order.dart';
import 'package:milkmandeliveryboynew/screen/subscriptiondetails_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String initial = "/";
  static String myBookingScreen = "/myBookingScreen";
  static String orderDetailsScreen = "/orderDetailsScreen";
  static String myPriscriptionOrder = "/MyPriscriptionOrder";
  static String myPriscriptionInfo = "/MyPriscriptionInfo";
  static String routeDetailsScreen = "/routeDetailsScreen";

  //Routes
  static String totalRoutes = "/totalRoutes";
}

final getPages = [
  GetPage(name: Routes.initial, page: () => onbording()),
  GetPage(
    name: Routes.myBookingScreen,
    page: () => MyBookingScreen(isBack: "1"),
  ),
  GetPage(name: Routes.orderDetailsScreen, page: () => OrderdetailsScreen()),
  GetPage(
    name: Routes.myPriscriptionOrder,
    page: () => MyPriscriptionOrder(isBack: "1"),
  ),
  GetPage(name: Routes.myPriscriptionInfo, page: () => MyPriscriptionInfo()),
  //Routes
  GetPage(
    name: Routes.totalRoutes,
    page: () => TotalRoutes(isBack: "2"),
  ),
  GetPage(name: Routes.routeDetailsScreen, page: () => RouteDetailsScreen()),
];

// ignore_for_file: unused_local_variable

import 'package:milkmandeliveryboynew/controller/dashboard_controller.dart';
import 'package:milkmandeliveryboynew/controller/myorder_controller.dart';
import 'package:milkmandeliveryboynew/controller/notificatio_controller.dart';
import 'package:milkmandeliveryboynew/controller/pagelist_controller.dart';
import 'package:milkmandeliveryboynew/controller/priscription_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => DashboardController());
  Get.lazyPut(() => MyOrderController());
  Get.lazyPut(() => PreScriptionControllre());
  Get.lazyPut(() => NotificationController());
  Get.lazyPut(() => PageListController());
}

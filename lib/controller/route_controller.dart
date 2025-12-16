// ignore_for_file: avoid_print, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:milkmandeliveryboynew/Api/Config.dart';
import 'package:milkmandeliveryboynew/Api/data_store.dart';
import 'package:milkmandeliveryboynew/model/route_model.dart';
import 'package:milkmandeliveryboynew/model/user_store_product_model.dart';
import 'package:milkmandeliveryboynew/onbording_screen.dart';

class RouteController extends GetxController implements GetxService {
  bool isLoading = false;
  RouteInfo? routeInfo;
  List<AssignedRoutes>? allRoutes = [];

  String routeId = "2";
  // int rider_id = 2;

  Future<void> getRouteData() async {
    try {
      // Map map = {"rider_id": rider_id ?? 2};
      //print("Request map: " + map.toString());
      int rider_id = int.parse(getData.read("StoreLogin")["id"]) ?? 0;
      Uri uri = Uri.parse(
        Config.path + Config.routeApi + "?rider_id=${rider_id}",
      );
      var response = await http.get(uri);
      print("<<<<<<<<Response>>>>>>>>>>" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("Parsed result: " + result.toString());

        if (result["AssignedRoutes"] != null ||
            result["AssignedRoutes"] != []) {
          routeInfo = RouteInfo.fromJson(result);

          print("Route Info: " + routeInfo.toString());
        }
      } else {
        print("API error: ${response.statusCode}");
      }
      isLoading = true;
      update();
    } catch (e) {
      print("Error in getRouteData: " + e.toString());
      isLoading = true;
      update();
    }
  }
}

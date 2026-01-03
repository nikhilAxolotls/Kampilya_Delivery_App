// ignore_for_file: avoid_print, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:milkmandeliveryboynew/Api/Config.dart';
import 'package:milkmandeliveryboynew/Api/data_store.dart';
import 'package:milkmandeliveryboynew/model/route_model.dart';
import 'package:milkmandeliveryboynew/utils/Custom_widget.dart';

class RouteController extends GetxController implements GetxService {
  bool isLoading = false;
  RouteInfo? routeInfo;
  List<AssignedRoutes>? allRoutes = [];
  //RxBool isMaterialAccepted = false.obs;

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

  //acceptance api
  Future<void> acceptRouteMaterial(AssignedRoutes? route) async {
    try {
      isLoading = false;
      update();

      // Optimistic update for instant UI change
      String? originalStatus = route?.materialStatus;
      route?.materialStatus = "accepted";
      update();

      int rider_id = int.parse(getData.read("StoreLogin")["id"]) ?? 0;
      Map map = {
        "rider_id": rider_id.toString(),
        "route_id": route?.routeId?.toString() ?? "",
        "accept_status": "1",
      };
      Uri uri = Uri.parse(Config.path + Config.materialAcceptApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${getData.read("StoreLogin")["token"]}",
        },
      );
      print("<<<<<<<<Response>>>>>>>>>>" + response.body);
      var result = jsonDecode(response.body);
      print("Parsed result: " + result.toString());
      if (response.statusCode == 200) {
        if (result["Result"] == "true") {
          showToastMessage(result["ResponseMsg"]);
          await getRouteData();
        } else {
          // Rollback on failure
          if (route != null) route.materialStatus = originalStatus;
          showToastMessage(result["ResponseMsg"]);
        }
      } else {
        // Rollback on failure
        if (route != null) route.materialStatus = originalStatus;
        showToastMessage("Something went wrong");
      }
      isLoading = true;
      update();
    } catch (e) {
      // Rollback on error
      showToastMessage("Something went wrong");
      isLoading = true;
      update();
    }
  }
}

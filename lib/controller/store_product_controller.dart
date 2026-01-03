// ignore_for_file: avoid_print, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:milkmandeliveryboynew/Api/Config.dart';
import 'package:milkmandeliveryboynew/Api/data_store.dart';
import 'package:milkmandeliveryboynew/model/user_store_product_model.dart';
import 'package:milkmandeliveryboynew/onbording_screen.dart';

class StoreDataContoller extends GetxController implements GetxService {
  bool isLoading = false;
  StoreDataInfo? storeDataInfo;

  String storeid = "2";

  getStoreData({String? storeId}) async {
    try {
      // Ensure location is available before making API call
      if (lat == null || long == null) {
        print("Location not available yet. Using default coordinates.");
        // Use default coordinates or return error
        lat = 18.457912456163026; // fallback latitude
        long = 73.82913630194933; // fallback longitude
      }

      Map map = {
        "uid": getData.read("StoreLogin")["id"] ?? "",
        "store_id": storeId ?? "2",
        "lats": lat?.toString() ?? "0.0",
        "longs": long?.toString() ?? "0.0",
      };
      print("Request map: " + map.toString());
      Uri uri = Uri.parse(Config.userPath + Config.userStoreDataApi);
      var response = await http.post(uri, body: jsonEncode(map));
      print("<<<<<<<<Response>>>>>>>>>>" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("Parsed result: " + result.toString());

        if (result["StoreInfo"] != null) {
          storeid = result["StoreInfo"]["store_id"]?.toString() ?? "2";
          print("Store ID: " + storeid);
        }

        storeDataInfo = StoreDataInfo.fromJson(result);
      } else {
        print("API error: ${response.statusCode}");
      }
      isLoading = true;
      update();
    } catch (e) {
      print("Error in getStoreData: " + e.toString());
      isLoading = true;
      update();
    }
  }
}

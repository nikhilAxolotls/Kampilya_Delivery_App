// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

class Config {
  static const String oneSignel = "*****************";
  // static const String baseUrl = 'https://milkyway.cscodetech.cloud/';
  static const String baseUrl = 'https://admin.kampilya.com/';

  static const String imageurl = baseUrl;

  static const String path = baseUrl + '/rider_api/';

  //--------------- Store path ----------------//
  static const String storePath = baseUrl + '/store_api/';

  //--------------- User path ----------------//
  static const String userPath = baseUrl + '/user_api/';

  static const String loginApi = "u_login_user.php";
  static const String dashboard = 'u_dashboard.php';
  static const String myOrderApi = "u_order_history.php";
  static const String orderInformetion = "u_order_information.php";
  static const String subScriptionHistory = "u_subscription_history.php";
  static const String subScriptionInformetion = "d_sub_order_product_list.php";

  static const String makeDecision = "make_decision.php";
  static const String completeOrder = "complete_order.php";

  static const String preDecision = "sub_decision.php";
  static const String preCompleteOrder = "sub_complete.php";

  static const String notificationApi = "u_notification_list.php";

  static const String pageListApi = "u_pagelist.php";
  static const String deletAccount = "acc_delete.php";

  static const String conpleteDeliveries = "completedate.php";
  //---------------store Products ----------------//
  static const String storeProductsApi = "product_list.php";

  //--------------- User Profile ----------------//
  static const String userStoreDataApi = "u_store_data.php";
  //--------------- Route ----------------//
  static const String routeApi = "get_rider_routes.php";
  static const String materialAcceptApi = "material_accept.php";
}

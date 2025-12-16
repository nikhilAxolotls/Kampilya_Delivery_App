// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unused_element, unused_field, prefer_final_fields

import 'dart:convert';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:milkmandeliveryboynew/Api/Config.dart';
import 'package:milkmandeliveryboynew/controller/priscription_controller.dart';
import 'package:milkmandeliveryboynew/controller/store_product_controller.dart';
import 'package:milkmandeliveryboynew/helpar/fontfamily_model.dart';
import 'package:milkmandeliveryboynew/screen/dashboard_screen.dart';
import 'package:milkmandeliveryboynew/utils/Colors.dart';
import 'package:milkmandeliveryboynew/utils/Custom_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class MyPriscriptionInfo extends StatefulWidget {
  const MyPriscriptionInfo({super.key});

  @override
  State<MyPriscriptionInfo> createState() => _MyPriscriptionInfoState();
}

class _MyPriscriptionInfoState extends State<MyPriscriptionInfo> {
  String oID = Get.arguments["oID"];
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  PreScriptionControllre preScriptionControllre = Get.find();
  StoreDataContoller storeDataContoller = Get.put(
    StoreDataContoller(),
    permanent: false,
  );

  //StoreProductController storeProductController =Get.put(StoreProductController(), permanent: false);

  final note = TextEditingController();
  final quantityController = TextEditingController();
  int selectedIndex = -1;
  var selectedRadioTile;
  String? rejectmsg = '';

  String imageEncoded = "";

  // new local state for add-product + cart in bottom sheet
  List<Map<String, dynamic>> _availableProducts = [];
  List<Map<String, dynamic>> _cartItems = [];
  int _selectedProductIndex = -1;

  double get _cartSubtotal => _cartItems.fold(
    0.0,
    (sum, it) => sum + (double.parse(it['price1'] ?? "0") * (it['qty'] ?? 1)),
  );

  void _addToCart(Map<String, dynamic> product) {
    final idx = _cartItems.indexWhere((c) => c['id'] == product['id']);
    if (idx >= 0) {
      _cartItems[idx]['qty'] = (_cartItems[idx]['qty'] ?? 1) + 1;
    } else {
      _cartItems.add({
        'id': product['id'],
        'title': product['title'],
        'price': product['price'] ?? "0",
        'qty': 1,
      });
    }
  }

  void _changeQty(String id, int delta) {
    final idx = _cartItems.indexWhere((c) => c['id'] == id);
    if (idx >= 0) {
      final newQty = (_cartItems[idx]['qty'] ?? 1) + delta;
      if (newQty <= 0) {
        _cartItems.removeAt(idx);
      } else {
        _cartItems[idx]['qty'] = newQty;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _signaturePadKey.currentState?.clear();
      imageEncoded = "";
    });
    // initialize available products for add-product + cart bottom sheet
    storeDataContoller.getStoreData(
      storeId: storeDataContoller.storeid == ""
          ? "2"
          : storeDataContoller.storeid,
    );
    //storeProductController.fetchStoreProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: BackButton(color: BlackColor),
        title: Text(
          "${"Order ID:".tr} #$oID",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            color: BlackColor,
            fontSize: 17,
          ),
        ),
        elevation: 0,
        backgroundColor: WhiteColor,
      ),
      bottomNavigationBar: GetBuilder<PreScriptionControllre>(
        builder: (context) {
          return preScriptionControllre
                      .preDetailsInfo
                      ?.orderProductList
                      .flowId ==
                  "3"
              ? Container(
                  color: WhiteColor,
                  height: Get.height * 0.1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "$currency${preScriptionControllre.preDetailsInfo?.orderProductList.orderTotal}",
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.02),
                                Image.asset(
                                  "assets/downarrow.png",
                                  // height: 14,
                                  // width: 14,
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.004),
                            Text(
                              "Total",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                color: greyColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: InkWell(
                            onTap: () {
                              preScriptionControllre.mackDecisionApi(
                                orderID: oID,
                                status: "1",
                                reson: "n/a",
                              );
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: gradient.btnGradient,
                              ),
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: WhiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : preScriptionControllre
                        .preDetailsInfo
                        ?.orderProductList
                        .flowId ==
                    "4"
              ? Container(
                  color: WhiteColor,
                  height: Get.height * 0.09,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "$currency${preScriptionControllre.preDetailsInfo?.orderProductList.orderTotal}",
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.02),
                                Image.asset(
                                  "assets/downarrow.png",
                                  height: 14,
                                  width: 14,
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.004),
                            Text(
                              "Total",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                color: greyColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: InkWell(
                            onTap: () {
                              //find the index for the todays date

                              var selectedDate = DateTime.now()
                                  .toString()
                                  .split(" ")[0];
                              int index = -1;
                              int totalDatesLength = preScriptionControllre
                                  .preDetailsInfo!
                                  .orderProductList
                                  .orderProductData[preScriptionControllre
                                      .currentIndex]
                                  .totaldates
                                  .length;
                              for (int i = 0; i < totalDatesLength; i++) {
                                if (preScriptionControllre
                                        .preDetailsInfo!
                                        .orderProductList
                                        .orderProductData[preScriptionControllre
                                            .currentIndex]
                                        .totaldates[i]
                                        .date
                                        .toString()
                                        .split(" ")[0] ==
                                    selectedDate) {
                                  index = i;
                                }
                              }
                              if (index == -1) {
                                showToastMessage(
                                  "Today's Delivery already completed",
                                );
                              } else if (preScriptionControllre
                                      .preDetailsInfo
                                      ?.orderProductList
                                      .flowId !=
                                  "3") {
                                if (preScriptionControllre
                                        .preDetailsInfo
                                        ?.orderProductList
                                        .orderProductData[preScriptionControllre
                                            .currentIndex]
                                        .totaldates[index]
                                        .isComplete ==
                                    false) {
                                  deliveryCompliteSheet(
                                    id: oID,
                                    selectDate: preScriptionControllre
                                        .preDetailsInfo
                                        ?.orderProductList
                                        .orderProductData[preScriptionControllre
                                            .currentIndex]
                                        .totaldates[index]
                                        .date
                                        .toString(),
                                    productId: preScriptionControllre
                                        .preDetailsInfo
                                        ?.orderProductList
                                        .orderProductData[preScriptionControllre
                                            .currentIndex]
                                        .productId,
                                  );
                                } else {
                                  showToastMessage(
                                    "Today's Delivery already completed",
                                  );
                                }
                              } else {
                                showToastMessage("Please accept order!");
                              }

                              // if (preScriptionControllre.isComplite == "0") {
                              //   if (imageEncoded != "") {
                              //     preScriptionControllre.completeOrderApi(
                              //       orderID: oID,
                              //       image: imageEncoded,
                              //     );
                              //     imageEncoded = "";
                              //   } else {
                              //     showToastMessage("Please Signature");
                              //   }
                              // } else {
                              //   showToastMessage(
                              //     "Kindly ensure that all delivery dates are marked as completed before proceeding.",
                              //   );
                              // }
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: gradient.btnGradient,
                              ),
                              child: Text(
                                "Delivered",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: WhiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox();
        },
      ),
      body: GetBuilder<PreScriptionControllre>(
        builder: (context) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: preScriptionControllre.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: WhiteColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Info".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 14,
                                  color: gradient.defoultColor,
                                ),
                              ),
                              SizedBox(height: 5),
                              SizedBox(
                                height: 120,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: preScriptionControllre
                                      .preDetailsInfo
                                      ?.orderProductList
                                      .orderProductData
                                      .length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        preScriptionControllre
                                            .changeIndexProductWise(
                                              index: index,
                                            );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 100,
                                              padding: EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      "assets/ezgif.com-crop.gif",
                                                  placeholderCacheHeight: 80,
                                                  placeholderCacheWidth: 100,
                                                  placeholderFit: BoxFit.cover,
                                                  image:
                                                      "${Config.imageurl}${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[index].productImage}",
                                                  height: 80,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 2,
                                                ),
                                                child: Text(
                                                  "${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[index].productName}",
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: greytext,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          border:
                                              preScriptionControllre
                                                      .currentIndex ==
                                                  index
                                              ? Border.all(
                                                  color: gradient.defoultColor,
                                                )
                                              : Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                          // color: preScriptionControllre
                                          //             .currentIndex ==
                                          //         index
                                          //     ? Color(0xffdaedfd)
                                          //     : WhiteColor,
                                          color: WhiteColor,
                                          borderRadius: BorderRadius.circular(
                                            7,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.size.height * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivery Date".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 14,
                                  color: gradient.defoultColor,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  itemCount: preScriptionControllre
                                      .preDetailsInfo
                                      ?.orderProductList
                                      .orderProductData[preScriptionControllre
                                          .currentIndex]
                                      .totaldates
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.orderProductList
                                                    .flowId !=
                                                "3") {
                                              if (preScriptionControllre
                                                      .preDetailsInfo
                                                      ?.orderProductList
                                                      .orderProductData[preScriptionControllre
                                                          .currentIndex]
                                                      .totaldates[index]
                                                      .isComplete ==
                                                  false) {
                                                deliveryCompliteSheet(
                                                  id: oID,
                                                  selectDate: preScriptionControllre
                                                      .preDetailsInfo
                                                      ?.orderProductList
                                                      .orderProductData[preScriptionControllre
                                                          .currentIndex]
                                                      .totaldates[index]
                                                      .date
                                                      .toString(),
                                                  productId: preScriptionControllre
                                                      .preDetailsInfo
                                                      ?.orderProductList
                                                      .orderProductData[preScriptionControllre
                                                          .currentIndex]
                                                      .productId,
                                                );
                                              }
                                            } else {
                                              showToastMessage(
                                                "Please accept order!",
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 50,
                                            margin: EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              preScriptionControllre
                                                      .preDetailsInfo
                                                      ?.orderProductList
                                                      .orderProductData[preScriptionControllre
                                                          .currentIndex]
                                                      .totaldates[index]
                                                      .formatDate ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                fontSize: 12,
                                                color: Colors.grey,
                                                height: 1.2,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border:
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.orderProductList
                                                          .orderProductData[preScriptionControllre
                                                              .currentIndex]
                                                          .totaldates[index]
                                                          .isComplete ==
                                                      false
                                                  ? Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                    )
                                                  : Border.all(
                                                      color:
                                                          gradient.defoultColor,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.orderProductList
                                                    .orderProductData[preScriptionControllre
                                                        .currentIndex]
                                                    .totaldates[index]
                                                    .isComplete ==
                                                true
                                            ? Positioned(
                                                right: 0,
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  padding: EdgeInsets.all(1),
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    "assets/double-check.png",
                                                    color: WhiteColor,
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        gradient.defoultColor,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: WhiteColor,
                          ),
                        ),
                        SizedBox(height: Get.size.height * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Item Info".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 14,
                                  color: gradient.defoultColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${currency}${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[preScriptionControllre.currentIndex].productPrice}",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Total".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${currency}${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[preScriptionControllre.currentIndex].productTotal}",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Variation".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[preScriptionControllre.currentIndex].productVariation}",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Qty".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[preScriptionControllre.currentIndex].productQuantity}",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Start Date".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[preScriptionControllre.currentIndex].startdate.toString().split(" ").first}",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Total Delivery".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          ":",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 13,
                                            color: greytext,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[preScriptionControllre.currentIndex].totaldelivery}",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              OrderInfo(
                                title: "Delivery time".tr,
                                subtitle:
                                    "${preScriptionControllre.preDetailsInfo?.orderProductList.orderProductData[preScriptionControllre.currentIndex].deliveryTimeslot}",
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: WhiteColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          width: Get.size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Info".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 14,
                                  color: gradient.defoultColor,
                                ),
                              ),
                              SizedBox(height: 13),
                              OrderInfo(
                                title: "Subtotal".tr,
                                subtitle:
                                    "${currency}${preScriptionControllre.preDetailsInfo?.orderProductList.orderSubTotal}",
                              ),
                              SizedBox(height: 13),
                              OrderInfo(
                                title: "Delivery Charge".tr,
                                subtitle:
                                    "${currency}${preScriptionControllre.preDetailsInfo?.orderProductList.deliveryCharge}",
                              ),
                              SizedBox(height: 13),
                              OrderInfo(
                                title: "Store Charge".tr,
                                subtitle:
                                    "${currency}${preScriptionControllre.preDetailsInfo?.orderProductList.storeCharge}",
                              ),
                              preScriptionControllre
                                          .preDetailsInfo
                                          ?.orderProductList
                                          .couponAmount !=
                                      "0"
                                  ? SizedBox(height: 1)
                                  : SizedBox(),
                              preScriptionControllre
                                          .preDetailsInfo
                                          ?.orderProductList
                                          .couponAmount !=
                                      "0"
                                  ? OrderInfo(
                                      title: "Coupon Amount".tr,
                                      subtitle:
                                          "${currency}${preScriptionControllre.preDetailsInfo?.orderProductList.couponAmount}",
                                    )
                                  : SizedBox(),
                              SizedBox(height: 13),
                              OrderInfo(
                                title: "Total".tr,
                                subtitle:
                                    "${currency}${preScriptionControllre.preDetailsInfo?.orderProductList.orderTotal}",
                              ),
                              SizedBox(height: 13),

                              OrderInfo(
                                title: "Payment Method".tr,
                                subtitle:
                                    "${preScriptionControllre.preDetailsInfo?.orderProductList.pMethodName ?? ""}",
                              ),

                              SizedBox(height: 13),

                              // myOrderController.nDetailsInfo?.orderProductList
                              //             .deliveryTimeslot !=
                              //         "0"
                              //     ?
                              // : SizedBox(),
                              OrderInfo(
                                title: "Address".tr,
                                subtitle:
                                    "${preScriptionControllre.preDetailsInfo?.orderProductList.customerAddress ?? ""}",
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: WhiteColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        preScriptionControllre
                                    .preDetailsInfo
                                    ?.orderProductList
                                    .additionalNote !=
                                ""
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                width: Get.size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Addition Note".tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        color: gradient.defoultColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      preScriptionControllre
                                              .preDetailsInfo
                                              ?.orderProductList
                                              .additionalNote ??
                                          "",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: WhiteColor,
                                ),
                              )
                            : SizedBox(),
                        preScriptionControllre
                                        .preDetailsInfo
                                        ?.orderProductList
                                        .flowId ==
                                    "4" &&
                                preScriptionControllre.isComplite == "0"
                            ? Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SfSignaturePad(
                                        key: _signaturePadKey,
                                        minimumStrokeWidth: 1,
                                        maximumStrokeWidth: 3,
                                        strokeColor: Colors.blue,
                                        backgroundColor: WhiteColor,
                                        onDrawEnd: () async {
                                          ui.Image signatureData =
                                              await _signaturePadKey
                                                  .currentState!
                                                  .toImage();
                                          ByteData? byteData =
                                              await signatureData.toByteData(
                                                format: ui.ImageByteFormat.png,
                                              );
                                          imageEncoded = base64.encode(
                                            byteData!.buffer.asUint8List(),
                                          );
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    height: 200,
                                    width: Get.size.width,
                                    decoration: BoxDecoration(
                                      color: WhiteColor,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: InkWell(
                                      onTap: () {
                                        imageEncoded = "";
                                        _signaturePadKey.currentState?.clear();
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/Thrash.png",
                                              height: 20,
                                              width: 20,
                                              color: WhiteColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "Clear",
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color: WhiteColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: gradient.btnGradient,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    )
                  : SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: gradient.defoultColor,
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Future deliveryCompliteSheet({
    String? id,
    String? selectDate,
    productId,
  }) async {
    _availableProducts = [];
    // initialize available product list every time sheet opens
    await storeDataContoller.getStoreData(
      storeId: storeDataContoller.storeid == ""
          ? "2"
          : storeDataContoller.storeid,
    );
    quantityController.text =
        preScriptionControllre
            .preDetailsInfo
            ?.orderProductList
            .orderProductData[preScriptionControllre.currentIndex]
            .productQuantity
            .toString() ??
        "0";
    selectedIndex = quantityController.text == "0.5"
        ? 0
        : quantityController.text == "1"
        ? 1
        : quantityController.text == "1.5"
        ? 2
        : quantityController.text == "2"
        ? 3
        : quantityController.text == "2.5"
        ? 4
        : quantityController.text == "3"
        ? 5
        : -1;

    // fetch ALL products from all categories

    if (storeDataContoller.storeDataInfo?.catwiseproduct != null) {
      for (var category in storeDataContoller.storeDataInfo!.catwiseproduct!) {
        if (category.productdata != null && category.productdata!.isNotEmpty) {
          for (var product in category.productdata!) {
            // extract product info (use first variant or loop all)
            if (product.productInfo != null &&
                product.productInfo!.isNotEmpty) {
              final info = product.productInfo![0]; // use first variant
              _availableProducts.add({
                'id': product.productId ?? '',
                'title': product.productTitle ?? '',
                // 'description': product.productDescription ?? '',
                'price': info.normalPrice ?? '0',

                'discount': info.productDiscount ?? '0',
                'image': (product.productImg ?? '').isNotEmpty
                    ? (Config.baseUrl + product.productImg!)
                    : null,
                'out_of_stock': info.productOutStock == '1',
              });
            }
          }
        }
      }
    }

    _cartItems = [];

    return Get.bottomSheet(
      isScrollControlled: true,
      StatefulBuilder(
        builder: (BuildContext c, StateSetter setState) {
          final deliveryCharge =
              double.tryParse(
                preScriptionControllre
                        .preDetailsInfo
                        ?.orderProductList
                        ?.deliveryCharge
                        ?.toString() ??
                    "0",
              ) ??
              0.0;
          final subtotal = _cartSubtotal;
          final total = subtotal + deliveryCharge;

          return Container(
            height:
                460, //_cartItems.isEmpty?350: 800, // taller to accommodate product picker + cart summary
            width: Get.size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 8,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Mark Delivered".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontFamily.gilroyBold,
                      color: BlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: 30,
                        // width: 150,
                        // decoration: BoxDecoration(
                        //   //color: gradient.defoultColor,
                        //   border: Border.all(
                        //     color: gradient.defoultColor,
                        //     width: 1.5,
                        //   ),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Center(
                          child: Text(
                            "Selected Delivery Date".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              fontSize: 15,
                              color: gradient.defoultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "${selectDate!.split(" ")[0]}  ",
                        style: TextStyle(
                          fontSize: 14,
                          color: gradient.defoultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Container(
                    height: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(color: greycolor),
                        Text(
                          "Select Quantity for today's delivery".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyMedium,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            Text(
                              "Selected Quantity/Liters : ".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 16,
                                color: BlackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    quantityController.text = value;
                                  });
                                },
                                controller: quantityController,
                                cursorColor: BlackColor,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 15,

                                  fontWeight: FontWeight.w600,
                                  color: BlackColor,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  // prefixIcon: SizedBox(
                                  //   height: 20,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //       vertical: 14,
                                  //     ),
                                  //     child: Image.asset(
                                  //       'assets/wallet.png',
                                  //       width: 20,
                                  //     ),
                                  //   ),
                                  // ),
                                  hintText: quantityController.text,
                                  hintStyle: TextStyle(color: greytext),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    quantityController.text = "0.5";
                                    selectedIndex = 0;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "0.5 L",
                                      style: TextStyle(color: BlackColor),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == 0
                                            ? gradient.defoultColor
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    quantityController.text = "1";
                                    selectedIndex = 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "1 L",
                                      style: TextStyle(color: BlackColor),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == 1
                                            ? gradient.defoultColor
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    quantityController.text = "1.5";
                                    selectedIndex = 2;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "1.5 L",
                                      style: TextStyle(color: BlackColor),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == 2
                                            ? gradient.defoultColor
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    quantityController.text = "2";
                                    selectedIndex = 3;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "2 L",
                                      style: TextStyle(color: BlackColor),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == 3
                                            ? gradient.defoultColor
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    quantityController.text = "2.5";
                                    selectedIndex = 4;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "2.5 L",
                                      style: TextStyle(color: BlackColor),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == 4
                                            ? gradient.defoultColor
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    quantityController.text = "3";
                                    selectedIndex = 5;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "3 L",
                                      style: TextStyle(color: BlackColor),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == 5
                                            ? gradient.defoultColor
                                            : Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*
                  //--- horizontal product picker
                  if (_availableProducts.isEmpty)
                    Center(
                      child: Text("No products available".tr,
                          style: TextStyle(color: Colors.grey)),
                    )
                  else
                    Container(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _availableProducts.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8),
                        itemBuilder: (_, i) {
                          final p = _availableProducts[i];
                          final cartIdx = _cartItems.indexWhere((it) => it['id'] == p['id']);
                          final qty = cartIdx >= 0 ? (_cartItems[cartIdx]['qty'] ?? 0) : 0;

                          return Container(
                            width: 140,
                            decoration: BoxDecoration(
                              color: WhiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: _selectedProductIndex == i
                                      ? gradient.defoultColor
                                      : Colors.grey.shade200),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: p['image'] != null
                                            ? FadeInImage.assetNetwork(
                                                placeholder: 'assets/ezgif.com-crop.gif',
                                                image: p['image']!,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/ezgif.com-crop.gif',
                                                width: 50,
                                                height: 50,
                                              ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              p['title'] ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily: FontFamily.gilroyMedium,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "$currency ${p['price'] ?? '0'}",
                                              style: TextStyle(
                                                  fontFamily: FontFamily.gilroyBold,
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    qty == 0
                                        ? Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _selectedProductIndex = i;
                                                  _addToCart(p);
                                                });
                                              },
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    fontFamily: FontFamily.gilroyBold,
                                                    color: gradient.defoultColor),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            spacing: 10,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_cartItems.any((it) => it['id'] == p['id'])) {
                                                      _changeQty(p['id']!, -1);
                                                    }
                                                  });
                                                },
                                                icon: Icon(Icons.remove_circle_outline,
                                                    color: Colors.grey),
                                                visualDensity: VisualDensity.compact,
                                                splashRadius: 18,
                                              ),
                                              Text(
                                                (_cartItems
                                                            .firstWhere(
                                                                (it) => it['id'] == p['id'],
                                                                orElse: () => {'qty': 0})['qty'] ??
                                                        0)
                                                    .toString(),
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _addToCart(p);
                                                  });
                                                },
                                                icon: Icon(Icons.add_circle_outline,
                                                    color: Colors.grey),
                                                visualDensity: VisualDensity.compact,
                                                splashRadius: 18,
                                              ),
                                            ],
                                          )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  if (_cartItems.isEmpty)
                    SizedBox()
                  else
                    ...[
                      Divider(
                        height: 10,
                        color: greycolor,
                        thickness: 0.5,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: WhiteColor, borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected Product ".tr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              height: 60,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) => SizedBox(height: 8),
                                itemCount: _cartItems.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 40,
                                    width: Get.size.width * 0.4,
                                    margin: EdgeInsets.only(bottom: 1, right: 4),
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: WhiteColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey.shade200),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _cartItems[index]['title']!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: FontFamily.gilroyMedium,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "$currency${_cartItems[index]['price'] ?? '0'}",
                                              style: TextStyle(color: Colors.grey, fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          tooltip: "Remove product",
                                          onPressed: () {
                                            setState(() {
                                              final removedId = _cartItems[index]['id'];
                                              _cartItems.removeWhere((it) => it['id'] == removedId);
                                              _selectedProductIndex = -1;
                                            });
                                            showToastMessage("Product removed");
                                          },
                                          icon: Icon(Icons.delete_outline, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal".tr,
                                    style: TextStyle(color: Colors.grey)),
                                Text("$currency${subtotal.toStringAsFixed(2)}"),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Charge".tr,
                                    style: TextStyle(color: Colors.grey)),
                                Text("$currency${deliveryCharge.toStringAsFixed(2)}"),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total".tr,
                                    style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold, fontSize: 16)),
                                Text("$currency${total.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold, fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    */
                  Divider(height: 10, color: greycolor, thickness: 0.5),
                  SizedBox(height: 10),
                  Text(
                    "Do you want to deliver the products today?".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: BlackColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  /*
                  Divider(
                    height: 12,
                    color: greycolor,
                    thickness: 0.5,
                  ),*/
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: gradient.defoultColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "No".tr,
                              style: TextStyle(
                                color: gradient.defoultColor,
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            preScriptionControllre.compliteDeliveries(
                              orderId: id,
                              selectDate: selectDate,
                              productId: productId,
                              // extras: _cartItems,
                              quantity: quantityController.text,
                            );
                            Get.back();
                            showToastMessage(
                              "Delivery confirmed. Added items: ${_cartItems.length}",
                            );
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: gradient.btnGradient,
                              borderRadius: BorderRadius.circular(45),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Yes".tr,
                              style: TextStyle(
                                color: WhiteColor,
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: WhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
    );
  }

  // Future<void> _showSimpleDialog(
  //     {String? id, String? selectDate, productId}) async {
  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           children: <Widget>[
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Deliveries',
  //                     style: TextStyle(
  //                         fontFamily: FontFamily.gilroyBold,
  //                         color: BlackColor,
  //                         fontSize: 18),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text(
  //                 'Do you want to deliver the product today?',
  //                 style: TextStyle(
  //                     fontFamily: FontFamily.gilroyBold,
  //                     color: BlackColor,
  //                     fontSize: 16),
  //               ),
  //             ),
  //             SizedBox(height: Get.height * 0.02),
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     'No'.toUpperCase(),
  //                     style: TextStyle(
  //                         fontFamily: FontFamily.gilroyBold,
  //                         color: gradient.defoultColor,
  //                         fontSize: 14),
  //                   ),
  //                   SizedBox(width: Get.width * 0.04),
  //                   InkWell(
  //                     onTap: () {
  //                       preScriptionControllre.compliteDeliveries(
  //                         orderId: id,
  //                         selectDate: selectDate,
  //                         productId: productId,
  //                       );
  //                     },
  //                     child: Text(
  //                       'Yes'.toUpperCase(),
  //                       style: TextStyle(
  //                           fontFamily: FontFamily.gilroyBold,
  //                           color: gradient.defoultColor,
  //                           fontSize: 14),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  ticketCancell(orderId) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: WhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    Container(
                      height: 6,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Select Reason".tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Gilroy Bold',
                        color: BlackColor,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Please select the reason for cancellation:".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Gilroy Medium',
                        color: BlackColor,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ListView.builder(
                      itemCount: cancelList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return RadioListTile(
                          dense: true,
                          value: i,
                          activeColor: Color(0xFF246BFD),
                          tileColor: BlackColor,
                          selected: true,
                          groupValue: selectedRadioTile,
                          title: Text(
                            cancelList[i]["title"],
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Gilroy Medium',
                              color: BlackColor,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {});
                            selectedRadioTile = val;
                            rejectmsg = cancelList[i]["title"];
                          },
                        );
                      },
                    ),
                    rejectmsg == "Others".tr
                        ? SizedBox(
                            height: 50,
                            width: Get.width * 0.85,
                            child: TextField(
                              controller: note,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF246BFD),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF246BFD),
                                    width: 1,
                                  ),
                                ),
                                hintText: 'Enter reason'.tr,
                                hintStyle: TextStyle(
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: Get.size.height / 55,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Cancel".tr,
                            bgColor: RedColor,
                            titleColor: Colors.white,
                            ontap: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Confirm".tr,
                            gradient1: gradient.btnGradient,
                            titleColor: Colors.white,
                            ontap: () {
                              preScriptionControllre.mackDecisionApi(
                                orderID: orderId,
                                status: "2",
                                reson: rejectmsg == "Others".tr
                                    ? note.text
                                    : rejectmsg,
                              );
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List cancelList = [
    {"id": 1, "title": "Financing fell through".tr},
    {"id": 2, "title": "Inspection issues".tr},
    {"id": 3, "title": "Change in financial situation".tr},
    {"id": 4, "title": "Title issues".tr},
    {"id": 5, "title": "Seller changes their mind".tr},
    {"id": 6, "title": "Competing offer".tr},
    {"id": 7, "title": "Personal reasons".tr},
    {"id": 8, "title": "Others".tr},
  ];

  ticketbutton({
    Function()? ontap,
    String? title,
    Color? bgColor,
    titleColor,
    Gradient? gradient1,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: Get.height * 0.04,
        width: Get.width * 0.40,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: gradient1,
          borderRadius: (BorderRadius.circular(18)),
        ),
        child: Center(
          child: Text(
            title!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: titleColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              fontFamily: 'Gilroy Medium',
            ),
          ),
        ),
      ),
    );
  }

  OrderInfo({String? title, subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 13,
            color: greytext,
          ),
        ),

        Text(
          " : ",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 13,
            color: greytext,
          ),
        ),
        Spacer(),
        Text(
          subtitle ?? "",
          maxLines: 2,
          textAlign: TextAlign.right,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Paymentinfo({String? text, infotext}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text!,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
            Text(
              infotext,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                color: BlackColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.015),
      ],
    );
  }
}

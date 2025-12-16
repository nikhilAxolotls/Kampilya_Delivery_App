import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:milkmandeliveryboynew/controller/priscription_controller.dart';
import 'package:milkmandeliveryboynew/helpar/fontfamily_model.dart';
import 'package:milkmandeliveryboynew/helpar/routes_helper.dart';
import 'package:milkmandeliveryboynew/model/route_model.dart';
import 'package:milkmandeliveryboynew/utils/Colors.dart';

class RouteDetailsScreen extends StatefulWidget {
  const RouteDetailsScreen({super.key});

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  PreScriptionControllre preScriptionControllre = Get.find();
  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context)!.settings.arguments as AssignedRoutes;
    List customers = route.customers ?? [];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.only(right: 25),
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: BlackColor,
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              route.routeName ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: FontFamily.gilroyBold,
                                color: BlackColor,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                // Text(
                                //   "${customers.length} Customers",
                                //   style: TextStyle(
                                //     fontSize: 14,
                                //     fontFamily: FontFamily.gilroyMedium,
                                //     color: BlackColor,
                                //   ),
                                // ),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          //color: gradientColor.withOpacity(0.1),
                          // borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: gradientColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          "${customers.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: FontFamily.gilroyBold,
                            color: gradientColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 10, color: Colors.grey),

            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                //  controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: customers.length,
                itemBuilder: (_, i) => InkWell(
                  onTap: () {
                    String oID = customers[i].orderDetails?[0].orderId ?? "";

                    preScriptionControllre.myPriscriptionInformetion(oID: oID);
                    Get.toNamed(
                      Routes.myPriscriptionInfo,
                      arguments: {"oID": oID},
                    );
                  },
                  child: _buildCustomerCard(customers[i], i),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerCard(Customers customer, int index) {
    Color statusColor = _getStatusColor(customer.orderStatus);
    IconData statusIcon = _getStatusIcon(customer.orderStatus);
    bool isSubscriptionOrder = customer.orderType == 'Subscription'
        ? true
        : false;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: lightgrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Name + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      customer.name ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.gilroyBold,
                        color: BlackColor,
                      ),
                    ),
                    //SizedBox(width: 10),
                    Spacer(),
                    Text(
                      customer.orderTotal ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.gilroyBold,
                        color: gradientColor,
                      ),
                    ),
                  ],
                ),
              ),
              /*
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14),
                    SizedBox(width: 4),
                    Text(
                      customer.orderStatus ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: FontFamily.gilroyBold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            
            */
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.society ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: FontFamily.gilroyMedium,
                      color: blueColor,
                    ),
                  ),
                  // Text(
                  //   customer.zone ?? "",
                  //   style: TextStyle(
                  //     fontSize: 13,
                  //     fontFamily: FontFamily.gilroyMedium,
                  //     color: blueColor,
                  //   ),
                  // ),
                ],
              ),
              isSubscriptionOrder
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.amber),
                      ),
                      child: Text(
                        "Subscription",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.gilroyBold,
                          color: Colors.amber,
                        ),
                      ),
                    ) //Icon(Icons.star, color: Colors.amber)
                  : SizedBox(),
            ],
          ),

          Divider(),

          Text(
            'Order Details -',
            style: TextStyle(
              fontSize: 13,
              fontFamily: FontFamily.gilroyBold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrderInfo(
                title: "Order ID",
                subtitle: customer.orderDetails?[0].orderId ?? "",
              ),
              OrderInfo(
                title: "Total Delivery",
                subtitle: customer.orderDetails?[0].totalDelivery ?? "",
              ),
            ],
          ),
          SizedBox(height: 6),
          isSubscriptionOrder
              ? Row(
                  children: [
                    OrderInfo(
                      title: "Remaining Delivery",
                      subtitle:
                          customer.orderDetails?[0].remainingDelivery ?? "",
                    ),
                    // OrderInfo(
                    //   title: "Amount",
                    //   subtitle: customer.orderDetails?[0].total ?? "",
                    // ),
                  ],
                )
              : SizedBox(),

          isSubscriptionOrder ? SizedBox(height: 6) : SizedBox(),
          isSubscriptionOrder
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderInfo(
                      title: "Product Name",
                      subtitle: customer.orderDetails?[0].productsName ?? "",
                    ),

                    OrderInfo(
                      title: "Price",
                      subtitle: customer.orderDetails?[0].price ?? "",
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrderInfo(
                title: "0.5 Ltr Qty",
                subtitle: customer.orderDetails?[0].cowHalpLtrQty ?? "",
              ),
              OrderInfo(
                title: "1 Ltr Qty",
                subtitle: customer.orderDetails?[0].cowOneLtrQty ?? "",
              ),
            ],
          ),
          SizedBox(height: 6),
          OrderInfo(title: "Status", subtitle: customer.orderStatus ?? ""),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     OrderInfo(
          //       title: "Start Date",
          //       subtitle: customer['order_details'][0]['order_date'],
          //     ),
          //   ],
          // ),
          // SizedBox(height: 6),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Text(
          //       "Total Amount",
          //       style: TextStyle(
          //         fontFamily: FontFamily.gilroyBold,
          //         fontSize: 13,
          //         color: greyColor,
          //       ),
          //     ),
          //     Text(
          //       " : ",
          //       style: TextStyle(
          //         fontFamily: FontFamily.gilroyBold,
          //         fontSize: 13,
          //         color: greyColor,
          //       ),
          //     ),
          //     SizedBox(width: 6),
          //     Text(
          //       customer['order_details'][0]['total'],
          //       textAlign: TextAlign.right,
          //       maxLines: 2,
          //       style: TextStyle(
          //         fontFamily: FontFamily.gilroyBold,
          //         fontSize: 14,
          //         color: Colors.grey,
          //       ),
          //     ),
          //   ],
          // ),

          // Divider(),
          // SizedBox(height: 8),
          Divider(),
          SizedBox(height: 8),

          /// Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: RedColor, size: 18),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  customer.address ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: FontFamily.gilroyMedium,
                    color: greyColor,
                  ),
                ),
              ),
              Spacer(),

              /// Phone
              Row(
                children: [
                  Icon(Icons.phone, color: blueColor, size: 18),
                  SizedBox(width: 6),
                  Text(
                    customer.phone ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.gilroyMedium,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  // Get Status Color
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Completed':
        return gradientColor;
      case 'Processing':
        return blueColor;
      case 'Pending':
        return orangeColor;
      case 'Cancelled':
        return RedColor;
      case 'Active':
        return gradientColor;
      default:
        return greyColor;
    }
  }

  // Get Status Icon
  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle;
      case 'Processing':
        return Icons.local_shipping;
      case 'Pending':
        return Icons.pending;
      case 'Cancelled':
        return Icons.cancel;
      case 'Active':
        return Icons.check_circle_outline;
      default:
        return Icons.info;
    }
  }

  Widget OrderInfo({String? title, subtitle}) {
    bool isStatus = false;
    Color textColor = greyColor;

    if (title == "Status") {
      isStatus = true;
      if (subtitle == "Cancelled") {
        textColor = Colors.red;
      } else if (subtitle == "Completed") {
        textColor = gradientColor;
      } else if (subtitle == "Processing") {
        textColor = blueColor;
      } else if (subtitle == "Pending") {
        textColor = orangeColor;
      } else if (subtitle == "Active") {
        textColor = gradientColor;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 13,
            color: greyColor,
          ),
        ),
        Text(
          " : ",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 13,
            color: greyColor,
          ),
        ),
        SizedBox(width: 6),
        Text(
          subtitle ?? "",
          textAlign: TextAlign.right,
          maxLines: 2,
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 14,
            color: isStatus ? textColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}

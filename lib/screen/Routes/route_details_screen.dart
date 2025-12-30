import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkmandeliveryboynew/controller/priscription_controller.dart';
import 'package:milkmandeliveryboynew/helpar/fontfamily_model.dart';
import 'package:milkmandeliveryboynew/helpar/routes_helper.dart';
import 'package:milkmandeliveryboynew/model/route_model.dart';
import 'package:milkmandeliveryboynew/utils/Colors.dart';
import 'package:milkmandeliveryboynew/utils/Custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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

    int cow_halp_ltr_qty = 0;
    int cow_one_ltr_qty = 0;
    int cow_two_ltr_qty = 0;
    int cow_total_qty = 0;
    int buffalo_halp_ltr_qty = 0;
    int buffalo_one_ltr_qty = 0;
    int buffalo_two_ltr_qty = 0;
    int buffalo_total_qty = 0;
    double total = 0;

    for (var item in customer.orderDetails ?? []) {
      cow_halp_ltr_qty += int.tryParse(item.cowHalpLtrQty ?? "0") ?? 0;
      cow_one_ltr_qty += int.tryParse(item.cowOneLtrQty ?? "0") ?? 0;
      cow_two_ltr_qty += int.tryParse(item.cowTwoLtrQty ?? "0") ?? 0;
      buffalo_halp_ltr_qty += int.tryParse(item.buffaloHalpLtrQty ?? "0") ?? 0;
      buffalo_one_ltr_qty += int.tryParse(item.buffaloOneLtrQty ?? "0") ?? 0;
      buffalo_two_ltr_qty += int.tryParse(item.buffaloTwoLtrQty ?? "0") ?? 0;

      total += double.parse(item.total?.replaceAll("₹", "") ?? "0");
    }

    cow_total_qty = cow_halp_ltr_qty + cow_one_ltr_qty + cow_two_ltr_qty;
    buffalo_total_qty =
        buffalo_halp_ltr_qty + buffalo_one_ltr_qty + buffalo_two_ltr_qty;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
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
                    //status
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: statusColor),
                      ),
                      child: Text(
                        customer.orderStatus ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.gilroyBold,
                          color: statusColor,
                        ),
                      ),
                    ),

                    ////total amount
                    // Text(
                    //   customer.orderTotal ?? "",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontFamily: FontFamily.gilroyBold,
                    //     color: gradientColor,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: RedColor, size: 18),
              SizedBox(width: 6),

              Text(
                maxLines: 2,
                overflow: TextOverflow.clip,
                "${customer.flatNo}, ${customer.building}, ${customer.society}",
                // "${customer.flatNo ?? ""}, ${customer.building ?? ""}, ${customer.society ?? ""}, ${customer.zone ?? ""}",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: FontFamily.gilroyMedium,
                  color: blueColor,
                ),
              ),

              /*
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
                  */
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
                title: "Product Name",
                subtitle: customer.orderDetails?[0].productsName ?? "",
              ),
              // OrderInfo(
              //   title: "Order ID",
              //   subtitle: customer.orderDetails?[0].orderId ?? "",
              // ),
              OrderInfo(
                title: "Total Delivery",
                subtitle: customer.orderDetails?[0].totalDelivery ?? "",
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              isSubscriptionOrder
                  ? OrderInfo(
                      title: "Remaining Delivery",
                      subtitle:
                          customer.orderDetails?[0].remainingDelivery ?? "",
                    )
                  : SizedBox(),
              isSubscriptionOrder ? Spacer() : SizedBox(),
              OrderInfo(
                title: "Price",
                subtitle: customer.orderDetails?[0].price ?? "",
              ),
              // OrderInfo(
              //   title: "Amount",
              //   subtitle: customer.orderDetails?[0].total ?? "",
              // ),
            ],
          ),

          isSubscriptionOrder ? SizedBox(height: 6) : SizedBox(),

          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.inventory_2, color: Color(0xff006b8a), size: 18),
              SizedBox(width: 6),
              Text(
                "Milk Quantity (Ltr) :",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: FontFamily.gilroyMedium,
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          //table
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),

              3: FlexColumnWidth(1),
            },

            border: TableBorder.all(
              color: Color(0xff006b8a).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              width: 1,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: BoxDecoration(
                  //padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Color(0xff006b8a).withOpacity(0.2),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      "Milk Type/Liter",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      "0.5 Ltr",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      "1 Ltr",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      "Cow Milk",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      " ${cow_halp_ltr_qty}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      " ${cow_one_ltr_qty}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      " ${cow_total_qty}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              //3
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      "Buffalo Milk",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      " ${buffalo_halp_ltr_qty}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      " ${buffalo_one_ltr_qty}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Text(
                      " ${buffalo_total_qty}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: BlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Divider(),
          //  SizedBox(height: 8),
          // buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              //Phone

              // Text(
              //   customer.phone ?? "",
              //   style: TextStyle(
              //     fontSize: 14,
              //     fontFamily: FontFamily.gilroyMedium,
              //     color: greyColor,
              //   ),
              // ),
              InkWell(
                onTap: () async {
                  //launch Dialer
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: customer.phone ?? "", // phone number
                  );

                  if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                  } else {
                    showToastMessage('Something went wrong');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.phone, color: blueColor, size: 30),
                ),
              ),
              SizedBox(width: 10),
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 8),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       border: Border.all(color: Colors.grey),
              //     ),
              //     child: Text(
              //       "Edit",
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontFamily: FontFamily.gilroyMedium,
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.only(left: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: gradient.defoultColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: gradient.defoultColor),
                  ),
                  child: Text(
                    "Mark as Complete",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: FontFamily.gilroyMedium,
                      color: WhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Address
          /*
          Divider(),
          SizedBox(height: 8),

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
          */
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:milkmandeliveryboynew/controller/priscription_controller.dart';
import 'package:milkmandeliveryboynew/controller/route_controller.dart';
import 'package:milkmandeliveryboynew/helpar/fontfamily_model.dart';
import 'package:milkmandeliveryboynew/helpar/routes_helper.dart';
import 'package:milkmandeliveryboynew/model/route_model.dart';
import 'package:milkmandeliveryboynew/utils/Colors.dart';

class TotalRoutes extends StatefulWidget {
  final String isBack;
  const TotalRoutes({super.key, required this.isBack});

  @override
  State<TotalRoutes> createState() => _TotalRoutesState();
}

class _TotalRoutesState extends State<TotalRoutes> {
  bool isLoading = false;
  PreScriptionControllre preScriptionControllre = Get.find();
  //RouteController routeController = Get.put(RouteController());
  RouteController routeController = Get.find();

  /*
  /// Mock API Data - Replace with actual API call
  final List<Map<String, dynamic>> allRoutes = [
    {
      'route_name': 'Route 1',
      'route_id': 'RT001',
      'orderDate': '2025-12-02',
      'deliveryTime': '10:00 AM - 12:00 PM',
      'status': 'Active',
      'total': '₹12,450',
      'societies': 3,
      'customers': [
        {
          'name': 'Rajesh Kumar',
          'address': '123, MG Road, Bangalore',
          'phone': '+91 98765 43210',
          'orderTotal': '₹1,250',
          'society': 'Green Valley Society',
          "order_status": 'Pending',
          "order_type": "Subscription",
          "order_details": [
            {
              "productsName": "Fresh Milk",
              "order_id": "ORD123456",
              "order_date": "2025-12-02",
              "remainingDelivery": "2",
              "totalDelivery": "5",
              "halp_ltr_qty": "1",
              "one_ltr_qty": "2",
              "delivery_time": "10:00 AM - 12:00 PM",
              "total": "₹1,250",
            },
          ],
        },
        {
          'name': 'Priya Sharma',
          'address': '45, MG Road, Bangalore',
          'phone': '+91 98765 43211',
          'orderTotal': '₹2,100',
          'society': 'Green Valley Society',
          "order_status": 'Pending',
          "order_type": "Subscription",
          "order_details": [
            {
              "order_id": "ORD123457",
              "productsName": "Yogurt",
              "order_date": "2025-12-02",
              "remainingDelivery": "3",
              "totalDelivery": "5",
              "halp_ltr_qty": "1",
              "one_ltr_qty": "1",
              "delivery_time": "10:00 AM - 12:00 PM",
              "total": "₹2,100",
            },
          ],
        },
        {
          'name': 'Amit Patel',
          'address': '78, MG Road, Bangalore',
          'phone': '+91 98765 43212',
          'orderTotal': '₹1,890',
          'society': 'Lake View Apartments',
          "order_status": 'In Progress',
          "order_type": "Normal",
          "order_details": [
            {
              "order_id": "ORD123458",
              "productsName": "Butter",
              "order_date": "2025-12-02",
              "remainingDelivery": "4",
              "totalDelivery": "5",
              "halp_ltr_qty": "0",
              "one_ltr_qty": "1",
              "delivery_time": "10:00 AM - 12:00 PM",
              "total": "₹1,890",
            },
          ],
        },
      ],
    },
    {
      'route_name': 'Route 2',
      'route_id': 'RT002',
      'orderDate': '2025-12-02',
      'deliveryTime': '2:00 PM - 4:00 PM',
      'status': 'Active',
      'total': '₹8,900',
      'societies': 4,
      'customers': [
        {
          'name': 'Anita Desai',
          'address': '45, Indiranagar, Bangalore',
          'phone': '+91 98765 43215',
          'orderTotal': '₹2,100',
          'society': 'Palm Grove',
          "order_status": 'In Progress',
          "order_type": "Normal",
          "order_details": [
            {
              "order_id": "ORD123459",
              "order_date": "2025-12-02",
              "productsName": "Paneer",
              "remainingDelivery": "1",
              "totalDelivery": "5",
              "halp_ltr_qty": "0",
              "one_ltr_qty": "1",
              "delivery_time": "2:00 PM - 4:00 PM",
              "total": "₹2,100",
            },
          ],
        },
        {
          'name': 'Ramesh Nair',
          'address': '67, Indiranagar, Bangalore',
          'phone': '+91 98765 43216',
          'orderTotal': '₹1,800',
          'society': 'Palm Grove',
          "order_status": 'Pending',
          "order_type": "Subscription",
          "order_details": [
            {
              "order_id": "ORD123460",
              "order_date": "2025-12-02",
              "productsName": "Cheese Spread ",
              "remainingDelivery": "2",
              "totalDelivery": "5",
              "halp_ltr_qty": "1",
              "one_ltr_qty": "0",
              "delivery_time": "2:00 PM - 4:00 PM",
              "total": "₹1,800",
            },
          ],
        },
        {
          'name': 'Kavita Joshi',
          'address': '89, Indiranagar, Bangalore',
          'phone': '+91 98765 43217',
          'orderTotal': '₹2,500',
          'society': 'Royal Gardens',
          "order_status": 'Completed',
          "order_type": "Normal",
          "order_details": [
            {
              "order_id": "ORD123461",
              "order_date": "2025-12-02",
              "productsName": "Ghee",
              "remainingDelivery": "0",
              "totalDelivery": "5",
              "halp_ltr_qty": "2",
              "one_ltr_qty": "0",
              "delivery_time": "2:00 PM - 4:00 PM",
              "total": "₹2,500",
            },
          ],
        },
        {
          'name': 'Suresh Kumar',
          'address': '23, Indiranagar, Bangalore',
          'phone': '+91 98765 43218',
          'orderTotal': '₹2,500',
          'society': 'Silver Oak',
          "order_status": 'In Progress',
          "order_type": "Normal",
          "order_details": [
            {
              "order_id": "ORD123462",
              "order_date": "2025-12-02",
              "productsName": "Lassi",
              "remainingDelivery": "3",
              "totalDelivery": "5",
              "halp_ltr_qty": "0",
              "one_ltr_qty": "2",
              "delivery_time": "2:00 PM - 4:00 PM",
              "total": "₹2,500",
            },
          ],
        },
      ],
    },
    {
      'route_name': 'Route 3',
      'route_id': 'RT003',
      'orderDate': '2025-12-01',
      'deliveryTime': '11:00 AM - 1:00 PM',
      'status': 'Completed',
      'total': '₹5,640',
      'societies': 2,
      'customers': [
        {
          'name': 'Deepak Malhotra',
          'address': '78, Koramangala, Bangalore',
          'phone': '+91 98765 43219',
          'orderTotal': '₹890',
          'society': 'Elite Residency',
          "order_status": 'Completed',
          "order_type": "Subscription",
          "order_details": [
            {
              "order_id": "ORD123463",
              "productsName": "Buttermilk",
              "order_date": "2025-12-01",
              "remainingDelivery": "0",
              "totalDelivery": "5",
              "halp_ltr_qty": "2",
              "one_ltr_qty": "2",
              "delivery_time": "11:00 AM - 1:00 PM",
              "total": "₹890",
            },
          ],
        },
        {
          'name': 'Meera Iyer',
          'address': '90, Koramangala, Bangalore',
          'phone': '+91 98765 43220',
          'orderTotal': '₹1,450',
          'society': 'Elite Residency',
          "order_status": 'Completed',
          "order_type": "Subscription",
          "order_details": [
            {
              "order_id": "ORD123464",
              "productsName": "Curd",
              "order_date": "2025-12-01",
              "remainingDelivery": "0",
              "totalDelivery": "5",
              "halp_ltr_qty": "1",
              "one_ltr_qty": "2",
              "delivery_time": "11:00 AM - 1:00 PM",
              "total": "₹1,450",
            },
          ],
        },
        {
          'name': 'Arjun Rao',
          'address': '34, Koramangala, Bangalore',
          'phone': '+91 98765 43221',
          'orderTotal': '₹3,300',
          'society': 'Golden Heights',
          "order_status": 'Completed',
          "order_type": "Normal",
          "order_details": [
            {
              "order_id": "ORD123465",
              "productsName": "Cream",
              "order_date": "2025-12-01",
              "remainingDelivery": "0",
              "totalDelivery": "5",
              "halp_ltr_qty": "1",
              "one_ltr_qty": "2",
              "delivery_time": "11:00 AM - 1:00 PM",
              "total": "₹3,300",
            },
          ],
        },
      ],
    },
  ];
*/
  List<AssignedRoutes> allRoutes = [];
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      routeController.getRouteData();
    });

    allRoutes = routeController.routeInfo?.assignedRoutes ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: BlackColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'All Routes',
          style: TextStyle(
            color: BlackColor,
            fontFamily: FontFamily.gilroyBold,
            fontSize: 18,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add_circle_outline, color: greenColor),
        //     onPressed: () {
        //       // Navigate to create route screen
        //       // Navigator.push(context, MaterialPageRoute(builder: (_) => CreateEditRouteScreen()));
        //     },
        //   ),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add API call to refresh routes
          await Future.delayed(Duration(seconds: 1));
          routeController.getRouteData();
          Timer(Duration(seconds: 3), () {
            allRoutes = routeController.routeInfo!.assignedRoutes!;
          });
        },
        color: greenColor,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Statistics
              _buildHeaderStatistics(),

              SizedBox(height: 20),

              // Routes Section Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Routes',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: FontFamily.gilroyBold,
                        color: BlackColor,
                      ),
                    ),
                    Text(
                      '${allRoutes.length} total routes',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.gilroyMedium,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),

              // Routes List
              allRoutes.isEmpty ? _buildEmptyState() : _buildRoutesList(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderStatistics() {
    int totalRoutes = allRoutes.length;
    int activeRoutes = allRoutes.where((r) => r.status == 'Active').length;
    int completedRoutes = allRoutes
        .where((r) => r.status == 'Completed')
        .length;
    int totalCustomers = 0;
    for (var route in allRoutes) {
      totalCustomers += route.customers!.length;
    }

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 78, 210, 224),
            const Color.fromARGB(255, 78, 210, 224),
            const Color.fromARGB(255, 78, 210, 224),

            gradient.defoultColor,
            //greenColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.route, color: WhiteColor, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Routes Overview',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: FontFamily.gilroyBold,
                    color: WhiteColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.route,
                  //icon: Icons.apartment,
                  label: 'Total Routes',
                  value: '$totalRoutes',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.people,
                  label: 'Total Customers',
                  value: '$totalCustomers',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Row(
          //   children: [
          //     Expanded(
          //       child: _buildStatItem(
          //         icon: Icons.check_circle,
          //         label: 'Active Routes',
          //         value: '$activeRoutes',
          //       ),
          //     ),
          //     SizedBox(width: 16),
          //     Expanded(
          //       child: _buildStatItem(
          //         icon: Icons.task_alt,
          //         label: 'Completed',
          //         value: '$completedRoutes',
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WhiteColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WhiteColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: WhiteColor, size: 24),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: FontFamily.gilroyBold,
                    color: WhiteColor,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: FontFamily.gilroyMedium,
                    color: WhiteColor.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: allRoutes.length,
      itemBuilder: (context, i) => _buildRouteCard(allRoutes[i]),
    );
  }

  Widget _buildRouteCard(AssignedRoutes route) {
    Color statusColor = _getStatusColor(route.status ?? "Pending");
    IconData statusIcon = _getStatusIcon(route.status ?? "Pending");

    int cow_halp_ltr_qty = 0;
    int cow_one_ltr_qty = 0;
    int cow_two_ltr_qty = 0;
    int cow_total_qty = 0;
    int buffalo_halp_ltr_qty = 0;
    int buffalo_one_ltr_qty = 0;
    int buffalo_two_ltr_qty = 0;
    int buffalo_total_qty = 0;
    for (var customer in route.customers!) {
      for (var item in customer.orderDetails ?? []) {
        cow_halp_ltr_qty += int.tryParse(item.cowHalpLtrQty ?? "0") ?? 0;
        cow_one_ltr_qty += int.tryParse(item.cowOneLtrQty ?? "0") ?? 0;
        cow_two_ltr_qty += int.tryParse(item.cowTwoLtrQty ?? "0") ?? 0;
        buffalo_halp_ltr_qty +=
            int.tryParse(item.buffaloHalpLtrQty ?? "0") ?? 0;
        buffalo_one_ltr_qty += int.tryParse(item.buffaloOneLtrQty ?? "0") ?? 0;
        buffalo_two_ltr_qty += int.tryParse(item.buffaloTwoLtrQty ?? "0") ?? 0;
      }
    }
    cow_total_qty = cow_halp_ltr_qty + cow_one_ltr_qty + cow_two_ltr_qty;
    buffalo_total_qty =
        buffalo_halp_ltr_qty + buffalo_one_ltr_qty + buffalo_two_ltr_qty;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: WhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xff006b8a), width: 0.2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Get.toNamed(
          Routes.routeDetailsScreen,
          arguments: route,
        ), //_showCustomersBottomSheet(route),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xff006b8a).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.receipt_long,
                          color: Color(0xff006b8a),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            route.routeName!,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: FontFamily.gilroyBold,
                              color: BlackColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                route.routeId!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: greyColor,
                                ),
                              ),
                              /*
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: statusColor.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      statusIcon,
                                      color: statusColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      route.status ?? 'Unknown',
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
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              //SizedBox(height: 14),
              Divider(color: Color(0xff006b8a), height: 10, thickness: 0.1),
              // SizedBox(height: 14),

              /// Customers and Societies Count
              Row(
                children: [
                  Icon(Icons.people, color: blueColor, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "${route.customers!.length} Customers",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.gilroyMedium,
                      color: BlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //SizedBox(width: 20),
                  Icon(Icons.apartment, color: gradientColor, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "${route.societies} Societies",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.gilroyMedium,
                      color: BlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Quantity
              SizedBox(height: 10),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.inventory_2, color: Color(0xff006b8a), size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Quantity (Ltr) :",
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
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1.5),
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
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
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
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

                          child: Text(
                            "2 Ltr",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.gilroyMedium,
                              color: BlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                        child: TableCell(
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
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

                          child: Text(
                            " ${cow_two_ltr_qty}",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.gilroyMedium,
                              color: BlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                        child: TableCell(
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
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

                          child: Text(
                            " ${buffalo_two_ltr_qty}",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.gilroyMedium,
                              color: BlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,

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
                      ),
                    ],
                  ),
                ],
              ),
              /*
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(Icons.inventory_2, color: Color(0xff006b8a), size: 18),
                  // SizedBox(width: 6),
                  // Text(
                  //   "Quantity (Ltr) :",
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontFamily: FontFamily.gilroyMedium,
                  //     color: BlackColor,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  //SizedBox(width: 6),
                  Container(
                    height: 80,
                    width: 269,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff006b8a).withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 88,
                              alignment: Alignment.center,

                              //padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: blueColor.withOpacity(0.1),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff006b8a).withOpacity(0.5),
                                  ),
                                ),
                              ),

                              child: Text(
                                "0.5 Ltr",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: BlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xff006b8a).withOpacity(0.5),
                              height: 6,
                              thickness: 1.5,
                            ),
                            Container(
                              height: 30,
                              width: 75,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "${halp_ltr_qty}",
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
                        Container(
                          color: Color(0xff006b8a).withOpacity(0.5),
                          // margin: EdgeInsets.symmetric(horizontal: 12),
                          height: 80,
                          width: 1.5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 88,
                              alignment: Alignment.center,
                              //padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: blueColor.withOpacity(0.1),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff006b8a).withOpacity(0.5),
                                  ),
                                ),
                              ),
                              child: Text(
                                "1 Ltr",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: BlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xff006b8a).withOpacity(0.5),
                              height: 6,
                            ),
                            Container(
                              height: 30,
                              width: 75,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "${one_ltr_qty}",
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
                        Container(
                          color: Color(0xff006b8a).withOpacity(0.5),
                          // margin: EdgeInsets.symmetric(horizontal: 12),
                          height: 80,
                          width: 1.5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 88,
                              alignment: Alignment.center,
                              //padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: blueColor.withOpacity(0.1),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff006b8a).withOpacity(0.5),
                                  ),
                                ),
                              ),
                              child: Text(
                                "2 Ltr",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: BlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xff006b8a).withOpacity(0.5),
                              height: 6,
                            ),
                            Container(
                              height: 30,
                              width: 75,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "${two_ltr_qty}",
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
                  ),
                ],
              ),
*/
              /// Date and Time Row
              Divider(color: Color(0xff006b8a), height: 15, thickness: 0.1),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_today, color: greyColor, size: 16),
                  SizedBox(width: 6),
                  Text(
                    route.delivery_date ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: FontFamily.gilroyMedium,
                      color: greyColor,
                    ),
                  ),
                  //SizedBox(width: 30),
                  Spacer(),
                  Icon(Icons.access_time, color: orangeColor, size: 16),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      route.deliveryTime ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: FontFamily.gilroyMedium,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),

              Divider(color: Color(0xff006b8a), height: 10, thickness: 0.1),

              /// Total Amount Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.gilroyMedium,
                      color: greyColor,
                    ),
                  ),
                  Text(
                    route.total!,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontFamily.gilroyBold,
                      color: gradientColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(color: bgcolor, shape: BoxShape.circle),
              child: Icon(Icons.route_outlined, size: 80, color: greyColor),
            ),
            SizedBox(height: 24),
            Text(
              "No Routes Found",
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.gilroyBold,
                color: BlackColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Create a new route to get started',
              style: TextStyle(
                fontSize: 14,
                fontFamily: FontFamily.gilroyMedium,
                color: greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get Status Color
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Completed':
        return gradientColor;
      case 'In Progress':
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
      case 'In Progress':
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
}

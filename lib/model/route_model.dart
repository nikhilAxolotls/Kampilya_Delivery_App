import 'package:intl/intl.dart';

class RouteInfo {
  int? responseCode;
  String? result;
  List<AssignedRoutes>? assignedRoutes;

  RouteInfo({this.responseCode, this.result, this.assignedRoutes});

  RouteInfo.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    if (json['AssignedRoutes'] != null) {
      assignedRoutes = <AssignedRoutes>[];
      json['AssignedRoutes'].forEach((v) {
        assignedRoutes!.add(new AssignedRoutes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    if (this.assignedRoutes != null) {
      data['AssignedRoutes'] = this.assignedRoutes!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class AssignedRoutes {
  String? routeName;
  String? routeId;

  String? deliveryTime;
  String? status;
  String? total;
  String? delivery_date;

  int? societies;
  List<Customers>? customers;

  AssignedRoutes({
    this.routeName,
    this.routeId,
    this.delivery_date,

    this.deliveryTime,
    this.status,
    this.total,
    this.societies,
    this.customers,
  });

  AssignedRoutes.fromJson(Map<String, dynamic> json) {
    routeName = json['route_name'];
    routeId = json['route_id'];

    delivery_date =
        json['delivery_date'] ??
        DateFormat('dd-MM-yyyy').format(DateTime.now());

    deliveryTime = json['delivery_time'] ?? "";
    status = json['status'];
    total = json['total'];
    societies = json['societies'];
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_name'] = this.routeName;
    data['route_id'] = this.routeId;

    data['deliveryTime'] = this.deliveryTime;
    data['status'] = this.status;
    data['total'] = this.total;
    data['societies'] = this.societies;
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  String? name;
  String? address;
  String? phone;
  String? orderTotal;
  String? society;
  String? orderStatus;
  String? orderType;
  List<OrderDetails>? orderDetails;

  Customers({
    this.name,
    this.address,
    this.phone,
    this.orderTotal,
    this.society,
    this.orderStatus,
    this.orderType,
    this.orderDetails,
  });

  Customers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    orderTotal = json['orderTotal'];
    society = json['society'];
    orderStatus = json['order_status'];
    orderType = json['order_type'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['orderTotal'] = this.orderTotal;
    data['society'] = this.society;
    data['order_status'] = this.orderStatus;
    data['order_type'] = this.orderType;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class OrderDetails {
  String? productsName;
  String? price;
  String? orderId;
  String? orderDate;
  String? remainingDelivery;
  String? totalDelivery;
  String? cowHalpLtrQty;
  String? cowOneLtrQty;
  String? cowTwoLtrQty;
  String? buffaloHalpLtrQty;
  String? buffaloOneLtrQty;
  String? buffaloTwoLtrQty;
  String? deliveryTime;
  String? total;

  OrderDetails({
    this.productsName,
    this.price,
    this.orderId,
    this.orderDate,
    this.remainingDelivery,
    this.totalDelivery,
    this.cowHalpLtrQty,
    this.cowOneLtrQty,
    this.cowTwoLtrQty,
    this.buffaloHalpLtrQty,
    this.buffaloOneLtrQty,
    this.buffaloTwoLtrQty,
    this.deliveryTime,
    this.total,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productsName = json['productsName'];
    price = json['price'] ?? "0";
    orderId = json['order_id'];
    orderDate = json['order_date'];
    remainingDelivery = json['remainingDelivery'];
    totalDelivery = json['totalDelivery'];
    cowHalpLtrQty = (json['cow_halp_ltr_qty'] ?? json['halp_ltr_qty'])
        .toString();
    cowOneLtrQty = (json['cow_one_ltr_qty'] ?? json['one_ltr_qty']).toString();
    cowTwoLtrQty = (json['cow_two_ltr_qty'] ?? json['two_ltr_qty']).toString();
    buffaloHalpLtrQty = (json['buffalo_halp_ltr_qty'] ?? 0).toString();
    buffaloOneLtrQty = (json['buffalo_one_ltr_qty'] ?? 0).toString();
    buffaloTwoLtrQty = (json['buffalo_two_ltr_qty'] ?? 0).toString();
    deliveryTime = json['delivery_time'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productsName'] = this.productsName;
    data['order_id'] = this.orderId;
    data['order_date'] = this.orderDate;
    data['remainingDelivery'] = this.remainingDelivery;
    data['totalDelivery'] = this.totalDelivery;
    data['halp_ltr_qty'] = this.cowHalpLtrQty;
    data['one_ltr_qty'] = this.cowOneLtrQty;
    data['two_ltr_qty'] = this.cowTwoLtrQty;
    data['buffalo_halp_ltr_qty'] = this.buffaloHalpLtrQty;
    data['buffalo_one_ltr_qty'] = this.buffaloOneLtrQty;
    data['buffalo_two_ltr_qty'] = this.buffaloTwoLtrQty;
    data['delivery_time'] = this.deliveryTime;
    data['total'] = this.total;
    return data;
  }
}

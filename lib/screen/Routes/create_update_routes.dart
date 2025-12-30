import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:milkmandeliveryboynew/helpar/fontfamily_model.dart';
import 'package:milkmandeliveryboynew/utils/Colors.dart';

class CreateEditRouteScreen extends StatefulWidget {
  final Map<String, dynamic>? route; // if null = create route ; else edit route

  const CreateEditRouteScreen({super.key, this.route});

  @override
  State<CreateEditRouteScreen> createState() => _CreateEditRouteScreenState();
}

class _CreateEditRouteScreenState extends State<CreateEditRouteScreen> {
  final TextEditingController routeNameCtrl = TextEditingController();
  DateTime? selectedDate;
  String selectedTimeSlot = "";
  List<Map<String, dynamic>> selectedCustomers = [];

  @override
  void initState() {
    super.initState();

    /// If Edit Route → Fill existing data
    if (widget.route != null) {
      routeNameCtrl.text = widget.route!["route_name"];
      selectedDate = DateTime.parse(widget.route!["orderDate"]);
      selectedTimeSlot = widget.route!["deliveryTime"];
      selectedCustomers = List<Map<String, dynamic>>.from(
        widget.route!["customers"],
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        elevation: 0,
        title: Text(
          widget.route == null ? "Create Route" : "Edit Route",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            color: BlackColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ROUTE NAME
              Text("Route Name", style: labelStyle()),
              SizedBox(height: 6),
              inputBox(controller: routeNameCtrl, hint: "Enter Route Name"),

              SizedBox(height: 18),

              // ORDER DATE
              Text("Order Date", style: labelStyle()),
              SizedBox(height: 6),
              InkWell(
                onTap: pickDate,
                child: containerField(
                  selectedDate == null
                      ? "Select Date"
                      : DateFormat("yyyy-MM-dd").format(selectedDate!),
                ),
              ),

              SizedBox(height: 18),

              // TIME SLOT
              Text("Delivery Time Slot", style: labelStyle()),
              SizedBox(height: 6),
              InkWell(
                onTap: pickTimeSlot,
                child: containerField(
                  selectedTimeSlot.isEmpty
                      ? "Select Time Slot"
                      : selectedTimeSlot,
                ),
              ),

              SizedBox(height: 18),

              // CUSTOMERS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Assign Delivery Boy", style: labelStyle()),
                  // InkWell(
                  //   onTap: selectCustomers,
                  //   child: Text(
                  //     "+ Add",
                  //     style: TextStyle(
                  //       color: blueColor,
                  //       fontFamily: FontFamily.gilroyBold,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 6),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  filled: true,
                  fillColor: WhiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: [
                  DropdownMenuItem(value: "Rider 1", child: Text("Rider 1")),
                  DropdownMenuItem(value: "Rider 2", child: Text("Rider 2")),
                  DropdownMenuItem(value: "Rider 3", child: Text("Rider 3")),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 6),
              selectedCustomers.isEmpty
                  ? Text("No customers added", style: greyStyle())
                  : ListView.builder(
                      itemCount: selectedCustomers.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) => customerTile(i),
                    ),

              SizedBox(height: 25),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Components ----------------------------

  TextStyle labelStyle() => TextStyle(
    fontFamily: FontFamily.gilroyBold,
    fontSize: 15,
    color: BlackColor,
  );

  TextStyle greyStyle() => TextStyle(
    fontFamily: FontFamily.gilroyMedium,
    fontSize: 14,
    color: greyColor,
  );

  Widget inputBox({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: WhiteColor,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget containerField(String text) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: WhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: lightgrey),
      ),
      child: Text(text, style: TextStyle(color: BlackColor)),
    );
  }

  Widget customerTile(int i) {
    final c = selectedCustomers[i];
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WhiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: lightgrey),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c['name'],
                  style: TextStyle(fontFamily: FontFamily.gilroyBold),
                ),
                SizedBox(height: 4),
                Text(c['society'], style: TextStyle(color: blueColor)),
              ],
            ),
          ),
          InkWell(
            onTap: () => setState(() => selectedCustomers.removeAt(i)),
            child: Icon(Icons.delete, color: RedColor),
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    return InkWell(
      onTap: saveRoute,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: gradient.btnGradient,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          widget.route == null ? "Create Route" : "Save Changes",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 16,
            color: WhiteColor,
          ),
        ),
      ),
    );
  }

  /// Actions --------------------------

  pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  pickTimeSlot() async {
    List<String> slots = [
      "10:00 AM - 12:00 PM",
      "2:00 PM - 4:00 PM",
      "6:00 PM - 8:00 PM",
    ];
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: slots
            .map(
              (e) => ListTile(
                title: Text(e),
                onTap: () {
                  selectedTimeSlot = e;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  selectCustomers() async {
    /// TODO: Here we will open customer selection list
    /// For now using demo customer to show functionality
    setState(() {
      selectedCustomers.add({
        'name': "New Customer",
        'society': "New Society",
        'address': "Demo Address",
        'phone': "0000000000",
        'orderTotal': "₹0",
        "order_status": "Pending",
        "order_details": [],
      });
    });
  }

  saveRoute() {
    if (routeNameCtrl.text.isEmpty) {
      return ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter Route Name")));
    }
    if (selectedDate == null ||
        selectedTimeSlot.isEmpty ||
        selectedCustomers.isEmpty) {
      return ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Fill all fields")));
    }

    final newRoute = {
      "route_name": routeNameCtrl.text,
      "orderDate": DateFormat("yyyy-MM-dd").format(selectedDate!),
      "deliveryTime": selectedTimeSlot,
      "societies": selectedCustomers.map((e) => e['society']).toSet().length,
      "total": _calculateTotal(),
      "customers": selectedCustomers,
    };

    Navigator.pop(context, newRoute);
  }

  String _calculateTotal() {
    double sum = 0;
    for (var c in selectedCustomers) {
      String price = c['orderTotal']
          .toString()
          .replaceAll("₹", "")
          .replaceAll(",", "");
      sum += double.tryParse(price) ?? 0;
    }
    return "₹${sum.toStringAsFixed(2)}";
  }
}

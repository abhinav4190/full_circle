import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/waste_pickup_status_screen.dart';
import 'package:get/get.dart';

class AcceptedBidsHistoryScreen extends StatelessWidget {
  final List<AcceptedBid> acceptedBids = [
    AcceptedBid(
      orderId: "ORD123456",
      mrfName: "EcoRecycle Solutions",
      wasteType: "Plastic Bottles",
      quantity: "5.0",
      totalAmount: "1250",
      status: "In Transit",
      currentStep: 3,
      acceptedDate: "2024-08-20",
      pickupDate: "2024-08-21",
    ),
    AcceptedBid(
      orderId: "ORD123455",
      mrfName: "Green Planet Recyclers",
      wasteType: "Paper & Cardboard",
      quantity: "12.5",
      totalAmount: "875",
      status: "Completed",
      currentStep: 6,
      acceptedDate: "2024-08-18",
      pickupDate: "2024-08-19",
    ),
    AcceptedBid(
      orderId: "ORD123454",
      mrfName: "Waste Warriors Ltd",
      wasteType: "Metal Scraps",
      quantity: "8.2",
      totalAmount: "2100",
      status: "Pickup Scheduled",
      currentStep: 1,
      acceptedDate: "2024-08-20",
      pickupDate: "2024-08-22",
    ),
    AcceptedBid(
      orderId: "ORD123453",
      mrfName: "EcoRecycle Solutions",
      wasteType: "Glass Bottles",
      quantity: "3.5",
      totalAmount: "420",
      status: "Completed",
      currentStep: 6,
      acceptedDate: "2024-08-15",
      pickupDate: "2024-08-16",
    ),
    AcceptedBid(
      orderId: "ORD123452",
      mrfName: "CleanTech Recyclers",
      wasteType: "E-Waste",
      quantity: "2.1",
      totalAmount: "3150",
      status: "Processing",
      currentStep: 4,
      acceptedDate: "2024-08-17",
      pickupDate: "2024-08-18",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.filter_list, color: Colors.green.shade600),
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Stats
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    "Total Orders",
                    "${acceptedBids.length}",
                    Icons.shopping_bag,
                    Colors.blue.shade500,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: _buildStatItem(
                    "Completed",
                    "${acceptedBids.where((bid) => bid.status == 'Completed').length}",
                    Icons.check_circle,
                    Colors.green.shade500,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: _buildStatItem(
                    "In Progress",
                    "${acceptedBids.where((bid) => bid.status != 'Completed').length}",
                    Icons.schedule,
                    Colors.orange.shade500,
                  ),
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: acceptedBids.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(context, acceptedBids[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context, AcceptedBid bid) {
    Color statusColor = _getStatusColor(bid.status);
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Get.to(() => WastePickupStatusScreen(
              orderId: bid.orderId,
              mrfName: bid.mrfName,
              wasteType: bid.wasteType,
              quantity: bid.quantity,
              totalAmount: bid.totalAmount,
            ));
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bid.orderId,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        bid.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12),
                
                // MRF Info
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.business,
                        color: Colors.green.shade600,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bid.mrfName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            '${bid.wasteType} • ${bid.quantity} kg',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${bid.totalAmount}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
                
                // Progress Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (bid.currentStep + 1) / 7,
                          child: Container(
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${((bid.currentStep + 1) / 7 * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12),
                
                // Dates
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Accepted: ${bid.acceptedDate}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    // Spacer(),
                    // if (bid.status != 'Pickup Scheduled') ...[
                    //   Icon(
                    //     Icons.local_shipping,
                    //     size: 14,
                    //     color: Colors.grey.shade500,
                    //   ),
                    //   // SizedBox(width: 4),
                    //   // Text(
                    //   //   'Pickup: ${bid.pickupDate}',
                    //   //   style: TextStyle(
                    //   //     fontSize: 12,
                    //   //     color: Colors.grey.shade600,
                    //   //   ),
                    //   // ),
                    // ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green.shade500;
      case 'In Transit':
      case 'Processing':
        return Colors.blue.shade500;
      case 'Pickup Scheduled':
        return Colors.orange.shade500;
      default:
        return Colors.grey.shade500;
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Filter Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.all_inclusive, color: Colors.green.shade600),
                title: Text('All Orders'),
                onTap: () => Get.back(),
              ),
              ListTile(
                leading: Icon(Icons.schedule, color: Colors.orange.shade600),
                title: Text('In Progress'),
                onTap: () => Get.back(),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green.shade600),
                title: Text('Completed'),
                onTap: () => Get.back(),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class AcceptedBid {
  final String orderId;
  final String mrfName;
  final String wasteType;
  final String quantity;
  final String totalAmount;
  final String status;
  final int currentStep;
  final String acceptedDate;
  final String pickupDate;

  AcceptedBid({
    required this.orderId,
    required this.mrfName,
    required this.wasteType,
    required this.quantity,
    required this.totalAmount,
    required this.status,
    required this.currentStep,
    required this.acceptedDate,
    required this.pickupDate,
  });
}
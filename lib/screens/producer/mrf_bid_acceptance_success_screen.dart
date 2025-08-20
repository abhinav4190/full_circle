import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/waste_pickup_status_screen.dart';
import 'package:full_circle/utils/colors.dart';
import 'package:get/get.dart';

class MRFBidAcceptanceSuccessScreen extends StatelessWidget {
  final String mrfName;
  final String bidAmount;
  final String wasteType;
  final String quantity;
  final String pickupAddress;
  final String estimatedPickupTime;

  MRFBidAcceptanceSuccessScreen({
    this.mrfName = "EcoRecycle Solutions",
    this.bidAmount = "1250",
    this.wasteType = "Plastic Bottles",
    this.quantity = "5.0",
    this.pickupAddress = "123 Main Street, Green Colony, Jaipur",
    this.estimatedPickupTime = "Tomorrow, 2:00 PM - 4:00 PM",
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          'Full Circle',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 20),
            child: Column(
              children: [
                SizedBox(height: 40),

                // Success Animation/Icon
                Image.asset('assets/images/verify.png', width: width * 0.35),

                SizedBox(height: 30),

                Text(
                  'Bid Accepted Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'Great! You\'ve accepted the bid from $mrfName. Your pickup has been scheduled and you\'ll receive notifications about the status.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 40),

                // Deal Summary Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.handshake,
                            color: Colors.green.shade500,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Deal Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      _buildDetailRow('MRF Partner', mrfName, Icons.business),
                      SizedBox(height: 12),
                      _buildDetailRow('Waste Type', wasteType, Icons.category),
                      SizedBox(height: 12),
                      _buildDetailRow('Quantity', '$quantity kg', Icons.scale),
                      SizedBox(height: 12),
                      _buildDetailRow(
                        'Total Amount',
                        '₹$bidAmount',
                        Icons.currency_rupee,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Pickup Details Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary2,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: Colors.green.shade600,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Pickup Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      _buildPickupDetailRow(
                        'Pickup Address',
                        pickupAddress,
                        Icons.location_on,
                      ),
                      // SizedBox(height: 16),
                      // _buildPickupDetailRow(
                      //   'Estimated Time',
                      //   estimatedPickupTime,
                      //   Icons.access_time,
                      // ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Important Notes
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.orange.shade200, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange.shade600,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Important Notes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        '• Please ensure the waste is properly segregated and ready for pickup\n• After getting the payment, show the QR code from your track screen to complete the deal.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Navigate to order status tracking screen
                          Get.to(
                            () => WastePickupStatusScreen(
                              orderId:
                                  "ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
                              mrfName: mrfName,
                              wasteType: wasteType,
                              quantity: quantity,
                              totalAmount: bidAmount,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.green.shade500,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Track Status',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                          Get.back(); // Go back to producer home screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade500,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          elevation: 2,
                        ),
                        child: Text(
                          'Back to Home',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.green.shade600, size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPickupDetailRow(String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.green.shade600, size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

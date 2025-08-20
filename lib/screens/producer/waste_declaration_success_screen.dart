import 'package:flutter/material.dart';
import 'package:full_circle/utils/colors.dart';
import 'package:get/get.dart';

class WasteDeclarationSuccessScreen extends StatelessWidget {
  final String wasteType;
  final String quantity;
  final String price;

  WasteDeclarationSuccessScreen({
    this.wasteType = "Plastic Bottles",
    this.quantity = "5.0",
    this.price = "25",
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
            padding: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 5),
            child: Column(
              children: [
                SizedBox(height: 40),
                
                Image.asset('assets/images/verify.png', width: width * 0.35),

                SizedBox(height: 30),

                Text(
                  'Waste Declared Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'Your waste has been declared successfully. Our team will review and approve it, after which MRF facilities will be able to view and bid on it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 40),

                // Waste Details Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade200, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.recycling,
                            color: Colors.green.shade500,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Waste Details:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      _buildDetailRow('Waste Type', wasteType, Icons.category),
                      SizedBox(height: 12),
                      _buildDetailRow('Quantity', '$quantity kg', Icons.scale),
                      SizedBox(height: 12),
                      _buildDetailRow(
                        'Price per kg',
                        '₹$price',
                        Icons.currency_rupee,
                      ),
                      SizedBox(height: 12),
                      _buildDetailRow(
                        'Total Value',
                        '₹${(double.parse(quantity) * double.parse(price)).toStringAsFixed(2)}',
                        Icons.account_balance_wallet,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // What happens next section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary2,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.shade500, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.green.shade500,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'What happens next?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      _buildNextStepItem(
                        '1',
                        'MRF Bidding',
                        'Material Recovery Facilities will review and bid on your waste',
                        Colors.green.shade500,
                      ),
                      SizedBox(height: 16),
                      _buildNextStepItem(
                        '2',
                        'Best Offer Selection',
                        'You\'ll receive notifications about offers and can choose the best one',
                        Colors.green.shade500,
                      ),
                      SizedBox(height: 16),
                      _buildNextStepItem(
                        '3',
                        'Pickup Arrangement',
                        'Once accepted, pickup will be scheduled at your specified location',
                        Colors.green.shade500,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // Action Buttons
                Row(
                  children: [
                   
                   
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
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

                SizedBox(height: 20),
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

  Widget _buildNextStepItem(
    String number,
    String title,
    String description,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
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

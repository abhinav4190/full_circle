import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WastePickupStatusScreen extends StatefulWidget {
  final String orderId;
  final String mrfName;
  final String wasteType;
  final String quantity;
  final String totalAmount;

  WastePickupStatusScreen({
    required this.orderId,
    this.mrfName = "EcoRecycle Solutions",
    this.wasteType = "Plastic Bottles",
    this.quantity = "5.0",
    this.totalAmount = "1250",
  });

  @override
  _WastePickupStatusScreenState createState() =>
      _WastePickupStatusScreenState();
}

class _WastePickupStatusScreenState extends State<WastePickupStatusScreen> {
  int currentStep =
      2; // 0: Order Confirmed, 1: Pickup Assigned, 2: On the way, 3: Arrived, 4: Loaded, 5: QR Code, 6: Deal Done
  bool showQRCode = false;
  String qrCodeData = "";

  final List<StatusStep> statusSteps = [
    StatusStep(
      title: "Bid Accepted",
      subtitle: "Your bid acceptance has been confirmed",
      icon: Icons.check_circle,
      time: "2 hours ago",
    ),
    StatusStep(
      title: "Pickup Assigned",
      subtitle: "Pickup truck has been assigned to your order",
      icon: Icons.assignment,
      time: "1 hour ago",
    ),
    StatusStep(
      title: "Pickup On The Way",
      subtitle: "Pickup truck is heading to your location",
      icon: Icons.local_shipping,
      time: "30 mins ago",
    ),
    StatusStep(
      title: "Pickup Arrived",
      subtitle: "Pickup truck has arrived at your location",
      icon: Icons.location_on,
      time: "Just now",
    ),
    StatusStep(
      title: "Waste Loaded",
      subtitle: "Your waste has been loaded onto the truck",
      icon: Icons.inventory,
      time: "Pending",
    ),
    StatusStep(
      title: "Verification",
      subtitle: "QR code generated for MRF verification",
      icon: Icons.qr_code,
      time: "Pending",
    ),
    StatusStep(
      title: "Deal Completed",
      subtitle: "Payment processed successfully",
      icon: Icons.payment,
      time: "Pending",
    ),
  ];

  void _nextStep() {
    setState(() {
      if (currentStep < statusSteps.length - 1) {
        currentStep++;
        if (currentStep == 4) {
          statusSteps[4].time = "Just now";
        } else if (currentStep == 5) {
          showQRCode = true;
          qrCodeData =
              "FC${widget.orderId}_${DateTime.now().millisecondsSinceEpoch}";
          statusSteps[5].time = "Just now";
        } else if (currentStep == 6) {
          showQRCode = false;
          statusSteps[6].time = "Just now";
        }
      }
    });
  }

  void _copyQRCode() {
    Clipboard.setData(ClipboardData(text: qrCodeData));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('QR Code data copied to clipboard'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Track Your Pickup',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Order Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID: ${widget.orderId}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              currentStep == statusSteps.length - 1
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          currentStep == statusSteps.length - 1
                              ? 'Completed'
                              : 'In Progress',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color:
                                currentStep == statusSteps.length - 1
                                    ? Colors.green.shade700
                                    : Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '${widget.wasteType} • ${widget.quantity} kg • ₹${widget.totalAmount}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  Text(
                    'MRF: ${widget.mrfName}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            // QR Code Section (when active)
            if (showQRCode && currentStep == 5) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ).copyWith(bottom: 25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade50, Colors.green.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'QR Code for Verification',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code,
                              size: 120,
                              color: Colors.grey.shade800,
                            ),
                            SizedBox(height: 8),
                            Text(
                              qrCodeData,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _copyQRCode,
                          icon: Icon(Icons.copy, size: 16),
                          label: Text('Copy Code'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green.shade700,
                            side: BorderSide(color: Colors.green.shade300),
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _nextStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade500,
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Verified by MRF'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Show this QR code to the MRF representative for verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Status Timeline
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: statusSteps.length,
                itemBuilder: (context, index) {
                  return _buildStatusItem(index);
                },
              ),
            ),

            // Simulate Next Step Button (for demo)
            if (currentStep < statusSteps.length - 1 && currentStep != 5) ...[
              Padding(
                padding: EdgeInsets.all(0).copyWith(bottom: 5, top: 0),
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: Text(
                    'Simulate Next Step',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(int index) {
    bool isCompleted = index <= currentStep;
    bool isCurrent = index == currentStep;
    bool isLast = index == statusSteps.length - 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isCompleted
                        ? (index == statusSteps.length - 1
                            ? Colors.green.shade500
                            : Colors.green.shade500)
                        : Colors.grey.shade300,
                border: Border.all(
                  color:
                      isCurrent
                          ? Colors.green.shade500
                          : (isCompleted
                              ? Colors.green.shade500
                              : Colors.grey.shade400),
                  width: isCurrent ? 3 : 1,
                ),
              ),
              child:
                  isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
            ),
            if (!isLast) ...[
              Container(
                width: 2,
                height: 60,
                color:
                    isCompleted ? Colors.green.shade300 : Colors.grey.shade300,
              ),
            ],
          ],
        ),
        SizedBox(width: 16),
        // Status content
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      statusSteps[index].icon,
                      size: 20,
                      color:
                          isCompleted
                              ? Colors.green.shade600
                              : Colors.grey.shade400,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        statusSteps[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              isCompleted
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Text(
                      statusSteps[index].time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    statusSteps[index].subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.3,
                    ),
                  ),
                ),
                if (isCurrent && !showQRCode) ...[
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Current Status',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StatusStep {
  final String title;
  final String subtitle;
  final IconData icon;
  String time;

  StatusStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.time,
  });
}

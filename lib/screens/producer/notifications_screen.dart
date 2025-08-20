import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/waste_pickup_status_screen.dart';
import 'package:full_circle/utils/colors.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedFilter = 'All';
  
  final List<NotificationItem> notifications = [
    // MRF Bids
    NotificationItem(
      id: '1',
      type: NotificationType.newBid,
      title: 'New Bid Received!',
      description: 'EcoRecycle Solutions placed a bid of ₹1,250 on your Plastic Bottles (5.0 kg)',
      time: '2 mins ago',
      isRead: false,
      actionData: {
        'orderId': 'ORD123456',
        'mrfName': 'EcoRecycle Solutions',
        'bidAmount': '1250',
      },
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.bidAccepted,
      title: 'Bid Accepted Successfully',
      description: 'Your acceptance of Green Planet Recyclers bid for ₹875 has been confirmed. Pickup scheduled.',
      time: '1 hour ago',
      isRead: false,
      actionData: {
        'orderId': 'ORD123455',
        'mrfName': 'Green Planet Recyclers',
      },
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.pickupUpdate,
      title: 'Pickup truck on the way',
      description: 'Your waste pickup is on the way. Expected arrival: 2:30 PM. Driver: Rajesh Kumar',
      time: '30 mins ago',
      isRead: true,
      actionData: {
        'orderId': 'ORD123456',
        'driverName': 'Rajesh Kumar',
        'eta': '2:30 PM',
      },
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.newBid,
      title: 'Higher Bid Received!',
      description: 'Waste Warriors Ltd placed a higher bid of ₹2,100 on your Metal Scraps (8.2 kg)',
      time: '2 hours ago',
      isRead: true,
      actionData: {
        'orderId': 'ORD123454',
        'mrfName': 'Waste Warriors Ltd',
        'bidAmount': '2100',
      },
    ),
    NotificationItem(
      id: '5',
      type: NotificationType.pickupCompleted,
      title: 'Pickup Completed',
      description: 'Your waste has been successfully picked up and verified. Payment of ₹420 is being processed.',
      time: '1 day ago',
      isRead: true,
      actionData: {
        'orderId': 'ORD123453',
        'amount': '420',
      },
    ),

    // General Notifications
    
    NotificationItem(
      id: '6',
      type: NotificationType.general,
      title: 'Waste Declaration Reminder',
      description: 'You haven\'t declared any waste in the last 7 days. Declutter your space and earn money!',
      time: '5 days ago',
      isRead: true,
    ),
    NotificationItem(
      id: '7',
      type: NotificationType.system,
      title: 'App Update Available',
      description: 'New features available! Update to version 2.1.0 for improved bidding experience and bug fixes.',
      time: '1 week ago',
      isRead: true,
    ),
  ];

  List<NotificationItem> get filteredNotifications {
    if (selectedFilter == 'All') return notifications;
    if (selectedFilter == 'Unread') return notifications.where((n) => !n.isRead).toList();
    
    NotificationType? type;
    switch (selectedFilter) {
      case 'Bids':
        return notifications.where((n) => 
          n.type == NotificationType.newBid || 
          n.type == NotificationType.bidAccepted
        ).toList();
      case 'Pickup':
        return notifications.where((n) => 
          n.type == NotificationType.pickupUpdate || 
          n.type == NotificationType.pickupCompleted
        ).toList();
      case 'Payment':
        return notifications.where((n) => n.type == NotificationType.paymentReceived).toList();
      case 'General':
        return notifications.where((n) => 
          n.type == NotificationType.general || 
          n.type == NotificationType.system
        ).toList();
    }
    
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        // leading: Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: IconButton(
        //     icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        //     onPressed: () => Get.back(),
        //   ),
        // ),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: IconButton(
          //     icon: Icon(Icons.settings, color: Colors.green.shade600),
          //     onPressed: () {
          //       _showNotificationSettings(context);
          //     },
          //   ),
          // ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterTab('All'),
                _buildFilterTab('Bids'),
                _buildFilterTab('Pickup'),
                _buildFilterTab('General'),
              ],
            ),
          ),

          // Summary
      
          // Notifications List
          Expanded(
            child: filteredNotifications.isEmpty 
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(filteredNotifications[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label) {
    bool isSelected = selectedFilter == label;
    int count = 0;
    
    if (label == 'Unread') {
      count = notifications.where((n) => !n.isRead).length;
    }
    
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            if (count > 0) ...[
              SizedBox(width: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.green.shade500,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.green.shade600 : Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedFilter = label;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Colors.green.shade500,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(
          color: isSelected ? Colors.green.shade500 : Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead ? Colors.transparent : Colors.green.shade200,
          width: 1,
        ),
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
            setState(() {
              notification.isRead = true;
            });
            _handleNotificationTap(notification);
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getNotificationColor(notification.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getNotificationIcon(notification.type),
                    color: _getNotificationColor(notification.type),
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          if (!notification.isRead) ...[
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.green.shade500,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 4),
                          Text(
                            notification.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Spacer(),
                          if (notification.type == NotificationType.newBid) ...[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'View Bid',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey.shade400,
              size: 60,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'No ${selectedFilter.toLowerCase()} notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.newBid:
        return Icons.local_offer;
      case NotificationType.bidAccepted:
        return Icons.handshake;
      case NotificationType.pickupUpdate:
        return Icons.local_shipping;
      case NotificationType.pickupCompleted:
        return Icons.check_circle;
      case NotificationType.paymentReceived:
        return Icons.account_balance_wallet;
      case NotificationType.general:
        return Icons.info;
      case NotificationType.system:
        return Icons.system_update;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.newBid:
        return Colors.orange.shade500;
      case NotificationType.bidAccepted:
        return Colors.green.shade500;
      case NotificationType.pickupUpdate:
        return Colors.blue.shade500;
      case NotificationType.pickupCompleted:
        return Colors.green.shade600;
      case NotificationType.paymentReceived:
        return Colors.green.shade700;
      case NotificationType.general:
        return Colors.purple.shade500;
      case NotificationType.system:
        return Colors.grey.shade600;
    }
  }

  void _handleNotificationTap(NotificationItem notification) {
    switch (notification.type) {
      case NotificationType.newBid:
      case NotificationType.bidAccepted:
      case NotificationType.pickupUpdate:
      case NotificationType.pickupCompleted:
        if (notification.actionData != null && notification.actionData!['orderId'] != null) {
          // Navigate to order status screen
          Get.to(() => WastePickupStatusScreen(
            orderId: notification.actionData!['orderId']!,
            mrfName: notification.actionData!['mrfName'] ?? 'Unknown MRF',
            wasteType: 'Mixed Waste',
            quantity: '5.0',
            totalAmount: notification.actionData!['bidAmount'] ?? notification.actionData!['amount'] ?? '0',
          ));
        }
        break;
      case NotificationType.paymentReceived:
        // Could navigate to payment history or transaction details
        _showPaymentDialog(notification);
        break;
      case NotificationType.general:
      case NotificationType.system:
        // Show detailed information or navigate to relevant screen
        _showInfoDialog(notification);
        break;
    }
  }

  void _showPaymentDialog(NotificationItem notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Colors.green.shade500),
            SizedBox(width: 8),
            Text('Payment Details'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ₹${notification.actionData?['amount'] ?? 'N/A'}'),
            Text('Order: ${notification.actionData?['orderId'] ?? 'N/A'}'),
            if (notification.actionData?['transactionId'] != null)
              Text('Transaction ID: ${notification.actionData!['transactionId']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(NotificationItem notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title),
        content: Text(notification.description),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
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
                'Notification Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.local_offer, color: Colors.green.shade600),
                title: Text('New Bids'),
                subtitle: Text('Get notified when MRFs place bids'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.green.shade500,
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_shipping, color: Colors.green.shade600),
                title: Text('Pickup Updates'),
                subtitle: Text('Track your pickup status'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.green.shade500,
                ),
              ),
              ListTile(
                leading: Icon(Icons.payment, color: Colors.green.shade600),
                title: Text('Payment Updates'),
                subtitle: Text('Payment confirmations and receipts'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.green.shade500,
                ),
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.green.shade600),
                title: Text('General Updates'),
                subtitle: Text('App updates and announcements'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Colors.green.shade500,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

enum NotificationType {
  newBid,
  bidAccepted,
  pickupUpdate,
  pickupCompleted,
  paymentReceived,
  general,
  system,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final String time;
  bool isRead;
  final Map<String, String>? actionData;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
    this.actionData,
  });
}
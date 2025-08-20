import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/mrf_bid_acceptance_success_screen.dart';
import 'package:get/get.dart';

class MRFBidsScreen extends StatefulWidget {
  @override
  _MRFBidsScreenState createState() => _MRFBidsScreenState();
}

class _MRFBidsScreenState extends State<MRFBidsScreen> {
  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Highest Bid', 'Nearest', 'Top Rated'];

  // Mock data for MRF bids
  final List<Map<String, dynamic>> mrfBids = [
    {
      'name': 'EcoRecycle Solutions',
      'location': 'Sector 15, Jaipur',
      'distance': '2.5 km',
      'rating': 4.8,
      'reviewCount': 156,
      'bidAmount': 28.0,
      'specialization': ['Plastic', 'Paper', 'Metal'],
      'processingCapacity': '500 tons/month',
      'certifications': ['ISO 14001', 'BIS Certified'],
      'pickupTime': 'Same Day',
      'verified': true,
      'bidValidTill': '2 days left',
      'bidStatus': 'Active',
      'timeOfBid': '2 hours ago',
      'logo': '♻️',
      'color': Colors.green.shade500,
    },
    {
      'name': 'Green Valley MRF',
      'location': 'Malviya Nagar, Jaipur',
      'distance': '4.2 km',
      'rating': 4.6,
      'reviewCount': 89,
      'bidAmount': 26.5,
      'specialization': ['Plastic', 'Glass', 'E-waste'],
      'processingCapacity': '300 tons/month',
      'certifications': ['ISO 9001', 'CPCB Authorized'],
      'pickupTime': 'Within 24 hours',
      'verified': true,
      'bidValidTill': '4 days left',
      'bidStatus': 'Active',
      'timeOfBid': '5 hours ago',
      'logo': '🌱',
      'color': Colors.green.shade500,
    },
    {
      'name': 'Rajasthan Waste Management',
      'location': 'Vaishali Nagar, Jaipur',
      'distance': '6.8 km',
      'rating': 4.4,
      'reviewCount': 203,
      'bidAmount': 25.0,
      'specialization': ['All Waste Types'],
      'processingCapacity': '800 tons/month',
      'certifications': ['ISO 14001', 'PCB Consent'],
      'pickupTime': 'Next Day',
      'verified': true,
      'bidValidTill': '1 day left',
      'bidStatus': 'Urgent',
      'timeOfBid': '1 day ago',
      'logo': '🏭',
      'color': Colors.green.shade500,
    },
    {
      'name': 'Pink City Recyclers',
      'location': 'C-Scheme, Jaipur',
      'distance': '3.1 km',
      'rating': 4.7,
      'reviewCount': 127,
      'bidAmount': 27.5,
      'specialization': ['Plastic', 'Paper', 'Cardboard'],
      'processingCapacity': '400 tons/month',
      'certifications': ['BIS Certified', 'Green Certified'],
      'pickupTime': 'Same Day',
      'verified': false,
      'bidValidTill': '3 days left',
      'bidStatus': 'New',
      'timeOfBid': '30 minutes ago',
      'logo': '🏢',
      'color': Colors.green.shade500,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'MRF Bids',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: EdgeInsets.only(right: 12, top: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.green.shade500 : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color:
                              isSelected
                                  ? Colors.green.shade500
                                  : Colors.grey.shade300,
                        ),
                        boxShadow:
                            isSelected
                                ? [
                                  BoxShadow(
                                    color: Colors.green.shade500.withOpacity(
                                      0.2,
                                    ),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                                : [],
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade700,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Header Info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${mrfBids.length} active bids received',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),

          // MRF List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: mrfBids.length,
              itemBuilder: (context, index) {
                final mrf = mrfBids[index];
                return _buildMRFCard(mrf, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMRFCard(Map<String, dynamic> mrf, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Logo/Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: mrf['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          mrf['logo'],
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),

                    // MRF Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  mrf['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                              if (mrf['verified'])
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade500,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Verified',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(width: 10),
                              // Bid Status Badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getBidStatusColor(mrf['bidStatus']),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  mrf['bidStatus'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey.shade500,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  mrf['location'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Text(
                                mrf['distance'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange.shade400,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${mrf['rating']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    ' (${mrf['reviewCount']})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey.shade500,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Bid ${mrf['timeOfBid']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Price Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Offered Price',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '₹${mrf['bidAmount'].toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),

                              Text(
                                ' per kg',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Pickup Time',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              mrf['pickupTime'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Details Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        'Specialization',
                        (mrf['specialization'] as List).join(', '),
                        Icons.category,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDetailItem(
                        'Capacity',
                        mrf['processingCapacity'],
                        Icons.storage,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Certifications
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      (mrf['certifications'] as List)
                          .map(
                            (cert) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                cert,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showMRFDetails(mrf);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: mrf['color']),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: mrf['color'],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _acceptBid(mrf);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mrf['color'],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      elevation: 2,
                    ),
                    child: Text(
                      'Accept Bid',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey.shade600, size: 16),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter MRF Bids',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ...filters.map(
                  (filter) => ListTile(
                    title: Text(filter),
                    leading: Radio<String>(
                      value: filter,
                      groupValue: selectedFilter,
                      activeColor: Colors.green.shade500,
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value!;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

 void _showMRFDetails(Map<String, dynamic> mrf) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade600, Colors.green.shade500],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.recycling,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          mrf['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow.shade300, size: 18),
                      SizedBox(width: 4),
                      Text(
                        '${mrf['rating']} (${mrf['reviewCount']} reviews)',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Content Section
            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInfoCard([
                    _buildDetailRow(Icons.location_on, 'Location', mrf['location']),
                    _buildDetailRow(Icons.navigation, 'Distance', mrf['distance']),
                  ]),
                  
                  SizedBox(height: 16),
                  
                  _buildInfoCard([
                    _buildDetailRow(
                      Icons.currency_rupee,
                      'Price per kg',
                      '₹${mrf['bidAmount'].toStringAsFixed(1)}',
                      valueColor: Colors.green.shade600,
                      isHighlight: true,
                    ),
                    _buildDetailRow(
                      Icons.speed,
                      'Processing Capacity',
                      mrf['processingCapacity'],
                    ),
                    _buildDetailRow(Icons.schedule, 'Pickup Time', mrf['pickupTime']),
                  ]),
                  
                  SizedBox(height: 16),
                  
                  _buildInfoCard([
                    _buildDetailRow(
                      Icons.category,
                      'Deal In',
                      (mrf['specialization'] as List).join(', '),
                    ),
                    _buildDetailRow(
                      Icons.verified,
                      'Certification',
                      (mrf['certifications'] as List).join(', '),
                    ),
                  ]),
                ],
              ),
            ),
            
            // Action Buttons
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _acceptBid(mrf);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Accept Bid',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildInfoCard(List<Widget> children) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: children,
    ),
  );
}

Widget _buildDetailRow(
  IconData icon,
  String title,
  String value, {
  Color? valueColor,
  bool isHighlight = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
    
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isHighlight ? Colors.green.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: isHighlight ? Colors.green.shade600 : Colors.grey.shade600,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.grey.shade800,
              fontSize: 14,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

void _acceptBid(Map<String, dynamic> mrf) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 32,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Accept Bid?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Are you sure you want to accept the bid from ${mrf['name']} at ₹${mrf['bidAmount'].toStringAsFixed(1)} per kg?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Get.snackbar(
                        //   'Bid Accepted!',
                        //   'You have successfully accepted the bid from ${mrf['name']}. They will contact you shortly for pickup arrangement.',
                        //   backgroundColor: Colors.green.shade600,
                        //   colorText: Colors.white,
                        //   duration: Duration(seconds: 4),
                        //   snackPosition: SnackPosition.BOTTOM,
                        //   borderRadius: 12,
                        //   margin: EdgeInsets.all(16),
                        //   icon: Icon(Icons.check_circle, color: Colors.white),
                        // );
                       Get.to(() => MRFBidAcceptanceSuccessScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: TextStyle(fontWeight: FontWeight.bold),
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

  Color _getBidStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.green.shade500;
      case 'active':
        return Colors.blue.shade500;
      case 'urgent':
        return Colors.orange.shade500;
      default:
        return Colors.grey.shade500;
    }
  }
}

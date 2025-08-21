import 'package:flutter/material.dart';
import 'package:full_circle/controllers/auth_controller.dart';
import 'package:full_circle/routes/app_routes.dart';
import 'package:full_circle/screens/producer/accepted_bids_history.dart';
import 'package:full_circle/screens/producer/declare_waste_screen.dart';
import 'package:full_circle/screens/producer/mrf_bids_screen.dart';
import 'package:full_circle/screens/producer/notifications_screen.dart';
import 'package:full_circle/screens/producer/profile_screen.dart';
import 'package:full_circle/utils/colors.dart';
import 'package:get/get.dart';

class ProducerHomeScreen extends StatefulWidget {
  @override
  _ProducerHomeScreenState createState() => _ProducerHomeScreenState();
}

class _ProducerHomeScreenState extends State<ProducerHomeScreen> {
  final AuthController authController = Get.find();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ProducerDashboard(), // Home content
    DeclareWasteScreen(), // Your existing declare waste screen
    AcceptedBidsHistoryScreen(), // Your existing history screen
    ProfileScreen(), // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green.shade600,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.home, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.add_box_outlined, 1),
              label: 'Declare',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.history, 2),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.person_outline, 3),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.green.shade600 : Colors.grey.shade500,
      ),
    );
  }
}

// Separate the dashboard content into its own widget
class ProducerDashboard extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, Colors.green.shade500],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.recycling, color: Colors.white, size: 18),
            ),
            SizedBox(width: 12),
            Text(
              'Producer Dashboard',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications_outlined, color: Colors.black),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () => Get.to(() => NotificationsScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green.shade50, Colors.green.shade100],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.waving_hand,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Abhinav',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Ready to make a positive environmental impact today?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    'Your Upcoming\nPickups',
                    '3',
                    AppColors.primary2,
                    Colors.green.shade600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatsCard(
                    'Total Waste Declared\n(This Month)',
                    '15 Tons',
                    AppColors.primary2,
                    Colors.green.shade600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    'Completed Pickups',
                    '16',
                    AppColors.primary2,
                    Colors.green.shade600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatsCard(
                    'Earnings',
                    '₹28',
                    AppColors.primary2,
                    Colors.green.shade600,
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),

            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Declare New Waste',
                    Icons.add,
                    () => Get.toNamed(AppRoutes.DECLARE_WASTE),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'View MRF Bids',
                    Icons.search,
                    () => Get.to(() => MRFBidsScreen()),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    'Accepted Bids',
                    Icons.calendar_today,
                    () => Get.to(() => AcceptedBidsHistoryScreen()),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),

            // Waste Breakdown Section
            Text(
              'Waste Breakdown',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 16),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Waste Breakdown',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Simple Bar Chart Representation
                  Container(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBarChart('Plastic', 80, Colors.green.shade400),
                        _buildBarChart('Paper', 60, Colors.green.shade300),
                        _buildBarChart('Glass', 40, Colors.green.shade200),
                        _buildBarChart('Metal', 70, Colors.green.shade500),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Pending Approvals
            Text(
              'Pending Approvals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 16),

            _buildApprovalItem('Plastic Waste', '10 tons'),
            SizedBox(height: 12),
            _buildApprovalItem('Paper Waste', '5 tons'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(
    String title,
    String value,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.black, size: 22),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart(String label, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildApprovalItem(String title, String subtitle) {
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.recycling,
              color: Colors.green.shade600,
              size: 24,
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
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

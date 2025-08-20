import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/contact_support_screen.dart';
import 'package:full_circle/screens/producer/faq_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Help & Support',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Quick Actions
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How can we help you?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          Icons.contact_support,
                          'Contact Support',
                          Colors.blue,
                          () => Get.to(() => ContactSupportScreen()),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildQuickAction(
                          Icons.quiz,
                          'FAQ',
                          Colors.green,
                          () => Get.to(() => FAQScreen()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Popular Topics
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popular Topics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildTopicTile('How to declare waste?', Icons.help_outline),
                  _buildTopicTile('Bidding process', Icons.gavel),
                  _buildTopicTile('Payment issues', Icons.payment),
                  _buildTopicTile('Account settings', Icons.settings),
                  _buildTopicTile('App troubleshooting', Icons.bug_report),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Contact Information
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildContactInfo(Icons.email, 'support@fullcircle.com'),
                  _buildContactInfo(Icons.phone, '+91 1234567890'),
                  _buildContactInfo(Icons.schedule, 'Mon - Fri, 9 AM - 6 PM'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: color),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.green.shade600),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: () {},
      contentPadding: EdgeInsets.symmetric(vertical: 4),
    );
  }

  Widget _buildContactInfo(IconData icon, String info) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade600, size: 20),
          SizedBox(width: 12),
          Text(info, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}

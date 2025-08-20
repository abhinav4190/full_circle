import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/contact_support_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FAQScreen extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I declare waste on the platform?',
      'answer': 'To declare waste, go to the "Declare Waste" section from your dashboard. Fill in the required details including waste type, quantity, and location. Once submitted, MRF facilities will be able to bid on your waste.'
    },
    {
      'question': 'How does the bidding process work?',
      'answer': 'After you declare waste, registered MRF facilities will submit bids with their offered price per kg. You can view all bids, compare prices, and accept the best offer that suits your requirements.'
    },
    {
      'question': 'When do I get paid for my waste?',
      'answer': 'Payment is processed after the MRF facility confirms successful pickup and weighing of your waste. Typically, payments are made within 2-3 business days after pickup confirmation.'
    },
    {
      'question': 'Can I cancel a bid after accepting it?',
      'answer': 'You can cancel an accepted bid within 2 hours of acceptance without any penalty. After this period, cancellation may result in a small processing fee.'
    },
    {
      'question': 'What types of waste can I declare?',
      'answer': 'You can declare various types of recyclable waste including plastic, paper, cardboard, glass, metal, and electronic waste. Each type has specific guidelines for preparation and packaging.'
    },
    {
      'question': 'How do I track my pickup status?',
      'answer': 'Once you accept a bid, you can track the pickup status in real-time from the "History" section. You\'ll receive notifications at each stage of the process.'
    },
    {
      'question': 'What if the MRF facility doesn\'t show up for pickup?',
      'answer': 'If an MRF facility fails to show up within the agreed timeframe, you can report the issue through our support system. We\'ll help reschedule or find an alternative facility.'
    },
    {
      'question': 'How is the waste weight verified?',
      'answer': 'MRF facilities use certified weighing equipment to measure your waste. Photos and weight certificates are uploaded to the platform for transparency and verification.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'FAQ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
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
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.quiz,
                      size: 40,
                      color: Colors.green.shade600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find answers to common questions about using Full Circle',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // FAQ List
            Container(
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
                children: faqs.map((faq) => _buildFAQItem(faq['question']!, faq['answer']!)).toList(),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Still Need Help
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade600],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.support_agent, size: 40, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'Still need help?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Can\'t find what you\'re looking for? Contact our support team.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Get.to(() => ContactSupportScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Contact Support',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      iconColor: Colors.green.shade600,
      collapsedIconColor: Colors.grey.shade500,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
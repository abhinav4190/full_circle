import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/contact_support_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> with TickerProviderStateMixin {
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

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      faqs.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      ),
    );
    
    _animations = _controllers.map((controller) => 
      CurvedAnimation(parent: controller, curve: Curves.easeInOut)
    ).toList();
    
    _isExpanded = List.generate(faqs.length, (index) => false);
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleExpansion(int index) {
    setState(() {
      _isExpanded[index] = !_isExpanded[index];
      if (_isExpanded[index]) {
        _controllers[index].forward();
      } else {
        _controllers[index].reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
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
            
            // FAQ List with better spacing
            ...faqs.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> faq = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isExpanded[index] 
                      ? Colors.green.shade300.withOpacity(0.5)
                      : Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildFAQItem(faq['question']!, faq['answer']!, index),
              );
            }).toList(),
            
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          // Question Header
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _toggleExpansion(index),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        question,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    AnimatedRotation(
                      turns: _isExpanded[index] ? 0.5 : 0.0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _isExpanded[index] 
                            ? Colors.green.shade100
                            : Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: _isExpanded[index] 
                            ? Colors.green.shade600
                            : Colors.grey.shade500,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Answer Section with Animation
          SizeTransition(
            sizeFactor: _animations[index],
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FadeTransition(
                  opacity: _animations[index],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        answer,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                          height: 1.6,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
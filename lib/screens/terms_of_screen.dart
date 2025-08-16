import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Terms of Use',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Color(0xFF00B050).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  SizedBox(height: width * 0.02),
                  Text(
                    'Full Circle',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00B050),
                    ),
                  ),
                  Text(
                    'Waste Management Platform',
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: width * 0.06),

            // Last Updated
            Text(
              'Last Updated: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: TextStyle(
                fontSize: width * 0.032,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: width * 0.05),

            // Welcome Section
            _buildSection(
              width,
              'Welcome to Full Circle',
              'Full Circle is a comprehensive waste management platform that connects waste producers, Material Recovery Facilities (MRFs), and recyclers to create a sustainable circular economy. By using our platform, you agree to comply with these Terms of Use.',
            ),

            // Acceptance of Terms
            _buildSection(
              width,
              '1. Acceptance of Terms',
              'By accessing and using the Full Circle application, you acknowledge that you have read, understood, and agree to be bound by these Terms of Use and our Privacy Policy. If you do not agree to these terms, please do not use our services.',
            ),

            // User Categories
            _buildSection(
              width,
              '2. User Categories',
              'Full Circle serves three primary user categories:\n\n'
                  '• Waste Producers: Individuals, businesses, or organizations that generate waste and seek proper disposal or recycling solutions.\n\n'
                  '• Material Recovery Facilities (MRFs): Licensed facilities that process and sort recyclable materials.\n\n'
                  '• Recyclers: Companies or individuals engaged in converting waste materials into reusable products.',
            ),

            // User Responsibilities
            _buildSection(
              width,
              '3. User Responsibilities',
              'All users must:\n\n'
                  '• Provide accurate and truthful information during registration\n'
                  '• Maintain the confidentiality of their account credentials\n'
                  '• Comply with all applicable local, state, and federal waste management regulations\n'
                  '• Ensure proper classification and description of waste materials\n'
                  '• Act in good faith in all transactions and communications\n'
                  '• Report any suspicious or illegal activities to platform administrators',
            ),

            // Prohibited Activities
            _buildSection(
              width,
              '4. Prohibited Activities',
              'Users are strictly prohibited from:\n\n'
                  '• Listing or attempting to dispose of hazardous, toxic, or illegal materials\n'
                  '• Misrepresenting the nature, quantity, or quality of waste materials\n'
                  '• Using the platform for any fraudulent or deceptive purposes\n'
                  '• Interfering with the platform\'s operation or security\n'
                  '• Violating any applicable environmental or waste management laws\n'
                  '• Harassing, threatening, or discriminating against other users',
            ),

            // Platform Services
            _buildSection(
              width,
              '5. Platform Services',
              'Full Circle provides:\n\n'
                  '• A marketplace for connecting waste generators with processors\n'
                  '• Tools for waste tracking and documentation\n'
                  '• Communication facilities between users\n'
                  '• Educational resources on waste management best practices\n'
                  '• Compliance assistance and regulatory information',
            ),

            // Fees and Payments
            _buildSection(
              width,
              '6. Fees and Payments',
              'Full Circle may charge fees for certain premium services. All applicable fees will be clearly disclosed before you incur any charges. Users are responsible for all taxes associated with their use of the platform.',
            ),

            // Data and Privacy
            _buildSection(
              width,
              '7. Data and Privacy',
              'We are committed to protecting your privacy and personal information. Our collection, use, and protection of your data are governed by our Privacy Policy, which is incorporated into these Terms of Use by reference.',
            ),

            // Liability Disclaimer
            _buildSection(
              width,
              '8. Limitation of Liability',
              'Full Circle acts as an intermediary platform. We are not responsible for:\n\n'
                  '• The quality, safety, or legality of waste materials\n'
                  '• The accuracy of user-provided information\n'
                  '• Disputes between users\n'
                  '• Compliance with local regulations by individual users\n'
                  '• Any damages arising from the use of our platform',
            ),

            // Account Termination
            _buildSection(
              width,
              '9. Account Termination',
              'We reserve the right to suspend or terminate user accounts that violate these terms or engage in activities that compromise the platform\'s integrity or safety. Users may also delete their accounts at any time through the app settings.',
            ),

            // Modifications
            _buildSection(
              width,
              '10. Modifications to Terms',
              'Full Circle reserves the right to modify these Terms of Use at any time. Users will be notified of significant changes through the app or email. Continued use of the platform after modifications constitutes acceptance of the updated terms.',
            ),

            // Governing Law
            _buildSection(
              width,
              '11. Governing Law',
              'These Terms of Use are governed by the laws of India. Any disputes arising from the use of this platform shall be subject to the jurisdiction of Indian courts.',
            ),

            // Contact Information
            _buildSection(
              width,
              '12. Contact Information',
              'For questions about these Terms of Use or our services, please contact us:\n\n'
                  'Email: support@fullcircle.com\n'
                  'Phone: +91-XXXX-XXXX\n'
                  'Address: [Your Company Address]',
            ),

            SizedBox(height: width * 0.08),

            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'By continuing to use Full Circle, you acknowledge that you have read and agree to these Terms of Use. Together, let\'s build a sustainable future through responsible waste management.',
                style: TextStyle(
                  fontSize: width * 0.035,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: width * 0.06),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(double width, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: width * 0.042,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),
        SizedBox(height: width * 0.025),
        Text(
          content,
          style: TextStyle(
            fontSize: width * 0.037,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        SizedBox(height: width * 0.05),
      ],
    );
  }
}

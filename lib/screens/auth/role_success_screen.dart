import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/role_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../home_screen.dart';

class RoleSuccessScreen extends StatelessWidget {
  final RoleController roleController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Obx(() {
      final roleContent = roleController.getRoleContent(
        roleController.selectedRole.value,
      );
      final roleColor = AppColors.primary; // Use consistent theme color

      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
              onPressed: () => Get.back(),
            ),
          ),
          title: Text(
            'Full Circle',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 5),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/verify.png',
                    width: width * 0.35,
                  ),

                  // Success Animation Container
                  // Container(
                  //   width: 140,
                  //   height: 140,
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       colors: [roleColor, roleColor.withOpacity(0.8)],
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //     ),
                  //     shape: BoxShape.circle,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: roleColor.withOpacity(0.3),
                  //         blurRadius: 20,
                  //         offset: Offset(0, 10),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: [
                  //       Icon(Icons.check, color: Colors.white, size: 60),
                  //       // Animated rings
                  //       Container(
                  //         width: 120,
                  //         height: 120,
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           border: Border.all(
                  //             color: roleColor.withOpacity(0.3),
                  //             width: 2,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 30),

                  Text(
                    'Role Selected',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    roleContent['description'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 50),

                  // Features Section
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: roleColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: roleColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: roleColor,
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'What you can do:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ...((roleContent['features'] as List)
                            .asMap()
                            .entries
                            .map((entry) {
                              final index = entry.key;
                              final feature = entry.value;

                              return _buildFeatureItem(
                                feature['icon'],
                                feature['title'],
                                feature['subtitle'],
                                roleColor,
                                isLast:
                                    index ==
                                    (roleContent['features'].length - 1),
                              );
                            })).toList(),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),

                  // Enhanced Continue Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [roleColor, roleColor.withOpacity(0.8)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: roleColor.withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Get.offAll(() => HomeScreen()),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                roleContent['buttonText'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.textPrimary,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    String subtitle,
    Color roleColor, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: roleColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: roleColor, size: 26),
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
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

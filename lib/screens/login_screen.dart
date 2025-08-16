import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:full_circle/screens/terms_of_screen.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  Image.asset(
                    'assets/images/login_leaf.png',
                    width: width * 0.25,
                  ),
                  SizedBox(height: height * 0.08),
                  Text(
                    'Enter Your\nMobile Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.08, // scales with screen width
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'We will send you a verification code',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: height * 0.07),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.018,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '+91',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          // keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: width * 0.045),
                          decoration: InputDecoration(
                            hintText: '8539067894',
                            hintStyle: TextStyle(color: AppColors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.lightGrey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.lightGrey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.018,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.2),
                  CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      if (phoneController.text.isNotEmpty) {
                        authController.sendOTP('+91${phoneController.text}');
                      }
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: width * 0.035,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              'By clicking on "Continue" you are agreeing to\nour ',
                        ),
                         TextSpan(
                          text: 'terms of use',
                          style: TextStyle(
                            color: Color(0xFF00B050),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                             
                              Get.to(() => const TermsOfUseScreen());
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

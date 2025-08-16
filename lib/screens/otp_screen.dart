import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumber;
  final AuthController authController = Get.find();

  OTPScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              Image.asset('assets/images/login_leaf.png', width: width * 0.25),
              SizedBox(height: height * 0.078),
              Text(
                'Verify Your\nPhone Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              SizedBox(height: height * 0.02),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    const TextSpan(text: 'Please enter the 4 digit code sent to\n'),
                    TextSpan(
                      text: phoneNumber,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const TextSpan(text: ' through SMS'),
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),

              /// 🔥 OTP Input (Pin Code Fields)
              PinCodeTextField(
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                animationType: AnimationType.scale,
                cursorColor: AppColors.primary,
                textStyle: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: width * 0.15,
                  fieldWidth: width * 0.15,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: AppColors.primary,
                  selectedColor: AppColors.primary,
                  inactiveColor: AppColors.lightGrey,
                ),
                enableActiveFill: true,
                onChanged: (value) {},
                onCompleted: (value) {
                  authController.verifyOTP(value);
                },
              ),

              SizedBox(height: height * 0.15),
              CustomButton(
                text: 'Verify Number',
                onPressed: () {
                  // Since PinCodeTextField calls onCompleted, this is optional
                  // but we keep it for manual verify
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
                      text: 'By clicking on "Continue" you are agreeing to\nour ',
                    ),
                    TextSpan(
                      text: 'terms of use',
                      style: TextStyle(
                      color: Color(0xFF00B050),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}

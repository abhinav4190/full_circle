import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:full_circle/bindings/auth_binding.dart';
import 'package:full_circle/controllers/auth_controller.dart';
import 'package:full_circle/controllers/role_controller.dart';
import 'package:full_circle/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'screens/splash_screen.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(AuthController());
    Get.put(RoleController());

    return GetMaterialApp(
      title: 'Full Circle',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter', // Make sure to add Inter font to pubspec.yaml
      ),
      initialRoute: AppRoutes.HOME,
       getPages: AppRoutes.pages,
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
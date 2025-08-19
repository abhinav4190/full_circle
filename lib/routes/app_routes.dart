// File: lib/routes/app_routes.dart
import 'package:get/get.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/home_screen.dart';
import '../screens/producer/producer_home_screen.dart';
import '../screens/producer/declare_waste_screen.dart';
import '../bindings/auth_binding.dart';
import '../bindings/producer_binding.dart';

class AppRoutes {
  // Route names
  static const String LOGIN = '/login';
  static const String OTP = '/otp';
  static const String ROLE_SELECTION = '/role-selection';
  static const String HOME = '/home';
  
  // Producer routes
  static const String PRODUCER_HOME = '/producer-home';
  static const String DECLARE_WASTE = '/declare-waste';
  static const String VIEW_OFFERS = '/view-offers';
  static const String BOOK_PICKUP = '/book-pickup';
  static const String PRODUCER_HISTORY = '/producer-history';
  static const String PRODUCER_PROFILE = '/producer-profile';
  
  // MRF routes (for future)
  static const String MRF_HOME = '/mrf-home';
  
  // Recycler routes (for future)
  static const String RECYCLER_HOME = '/recycler-home';

  // GetX Pages configuration
  static List<GetPage> pages = [
    // Auth routes
    GetPage(
      name: LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: OTP,
      page: () {
        final phoneNumber = Get.arguments as String? ?? '';
        return OTPScreen(phoneNumber: phoneNumber);
      },
      binding: AuthBinding(),
    ),
    GetPage(
      name: ROLE_SELECTION,
      page: () => RoleSelectionScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: HOME,
      page: () => HomeScreen(),
      binding: AuthBinding(),
    ),
    
    // Producer routes
    GetPage(
      name: PRODUCER_HOME,
      page: () => ProducerHomeScreen(),
      binding: ProducerBinding(),
    ),
    GetPage(
      name: DECLARE_WASTE,
      page: () => DeclareWasteScreen(),
      binding: ProducerBinding(),
    ),
    // GetPage(
    //   name: VIEW_OFFERS,
    //   page: () => ViewOffersScreen(),
    //   binding: ProducerBinding(),
    // ),
    // GetPage(
    //   name: BOOK_PICKUP,
    //   page: () => BookPickupScreen(),
    //   binding: ProducerBinding(),
    // ),
    // GetPage(
    //   name: PRODUCER_HISTORY,
    //   page: () => ProducerHistoryScreen(),
    //   binding: ProducerBinding(),
    // ),
    // GetPage(
    //   name: PRODUCER_PROFILE,
    //   page: () => ProducerProfileScreen(),
    //   binding: ProducerBinding(),
    // ),
  ];
}

// Placeholder screens - you can implement these later

import 'package:flutter/material.dart';
import 'package:full_circle/utils/colors.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/home_screen.dart';
import '../screens/auth/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _storage = GetStorage();
  
  var verificationId = ''.obs;
  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  var userRole = ''.obs;
  var currentPhoneNumber = ''.obs;
  var currentUserId = ''.obs; // Store generated user ID

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  void checkAuthStatus() async {
    // Check if user is already logged in (stored locally)
    final savedUserId = _storage.read('userId');
    final savedRole = _storage.read('userRole');
    final savedPhone = _storage.read('phoneNumber');
    
    if (savedUserId != null && savedRole != null && savedPhone != null) {
      currentUserId.value = savedUserId;
      userRole.value = savedRole;
      currentPhoneNumber.value = savedPhone;
      isAuthenticated.value = true;
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  void sendOTP(String phoneNumber) async {
    try {
      isLoading.value = true;
      currentPhoneNumber.value = phoneNumber;
      
      // Always navigate to OTP screen (bypass actual Firebase OTP)
      Get.to(() => OTPScreen(phoneNumber: phoneNumber));
      isLoading.value = false;
      
      Get.snackbar(
        'Development Mode', 
        'Use OTP: 1234 to continue',
        backgroundColor: AppColors.primary,
        colorText: Colors.black,
        duration: Duration(seconds: 3),
      );
      
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading.value = false;
    }
  }

  void verifyOTP(String otp) async {
    try {
      isLoading.value = true;
      
      // Bypass Firebase OTP - use hardcoded OTP
      if (otp == "1234") {
        // Generate a unique user ID based on phone number
        String userId = _generateUserId(currentPhoneNumber.value);
        currentUserId.value = userId;
        
        // Store user ID locally
        _storage.write('userId', userId);
        _storage.write('phoneNumber', currentPhoneNumber.value);
        
        // Check if user exists in Firestore and has a role
        await _checkUserRoleAndNavigate();
        isLoading.value = false;
        return;
      } else {
        Get.snackbar('Error', 'Invalid OTP. Please use 1234');
        isLoading.value = false;
        return;
      }
      
    } catch (e) {
      Get.snackbar('Error', 'Authentication failed: ${e.toString()}');
      isLoading.value = false;
    }
  }

  // Generate a consistent user ID based on phone number
  String _generateUserId(String phoneNumber) {
    // Remove all non-digit characters and create a hash-like ID
    String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return 'user_${cleanPhone}_${cleanPhone.hashCode.abs()}';
  }

  Future<void> _checkUserRoleAndNavigate() async {
    try {
      // Check Firestore for existing user data
      final userDoc = await _firestore.collection('users').doc(currentUserId.value).get();
      
      if (userDoc.exists && userDoc.data()?['role'] != null) {
        // User already has a role, go to home screen
        final role = userDoc.data()!['role'];
        userRole.value = role;
        _storage.write('userRole', role);
        isAuthenticated.value = true;
        Get.offAll(() => HomeScreen());
      } else {
        // User doesn't have a role, go to role selection
        Get.offAll(() => RoleSelectionScreen());
      }
    } catch (e) {
      print('Error checking user role: $e');
      // If there's an error accessing Firestore, go to role selection
      Get.offAll(() => RoleSelectionScreen());
    }
  }

  Future<void> saveUserRole(String role) async {
    try {
      // Save user data to Firestore
      await _firestore.collection('users').doc(currentUserId.value).set({
        'userId': currentUserId.value,
        'role': role,
        'phoneNumber': currentPhoneNumber.value,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'authMethod': 'bypass', // Flag to indicate this is bypass auth
      }, SetOptions(merge: true));
      
      // Save to local storage
      userRole.value = role;
      _storage.write('userRole', role);
      isAuthenticated.value = true;
      
      // Get.snackbar(
      //   'Success', 
      //   'Role selected successfully!',
      //     backgroundColor: AppColors.primary,
      //   colorText: Colors.black,
      // );
      
      // Navigate to home screen
      Get.offAll(() => HomeScreen());
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to save role: $e');
      print('Error saving role: $e');
    }
  }

  // Method to save additional user data to Firestore
  Future<void> updateUserData(Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(currentUserId.value).update({
        ...userData,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      Get.snackbar(
        'Success', 
        'Data updated successfully!',
          backgroundColor: AppColors.primary,
        colorText: Colors.black,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update data: $e');
      print('Error updating user data: $e');
    }
  }

  // Method to get user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final userDoc = await _firestore.collection('users').doc(currentUserId.value).get();
      if (userDoc.exists) {
        return userDoc.data();
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Method to create/update any collection in Firestore
  Future<void> saveToFirestore({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    try {
      await _firestore.collection(collection).doc(docId).set({
        ...data,
        'userId': currentUserId.value, // Always include user ID for reference
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: merge));
      
      print('Data saved to $collection/$docId successfully');
    } catch (e) {
      print('Error saving to Firestore: $e');
      throw e;
    }
  }

  // Method to read from any Firestore collection
  Future<DocumentSnapshot> getFromFirestore({
    required String collection,
    required String docId,
  }) async {
    try {
      return await _firestore.collection(collection).doc(docId).get();
    } catch (e) {
      print('Error reading from Firestore: $e');
      throw e;
    }
  }

  // Method to get all documents for current user from a collection
  Future<QuerySnapshot> getUserDocuments(String collection) async {
    try {
      return await _firestore
          .collection(collection)
          .where('userId', isEqualTo: currentUserId.value)
          .orderBy('updatedAt', descending: true)
          .get();
    } catch (e) {
      print('Error getting user documents: $e');
      throw e;
    }
  }

  void signOut() async {
    try {
      // Clear local storage
      _storage.erase();
      
      // Reset all values
      isAuthenticated.value = false;
      userRole.value = '';
      currentPhoneNumber.value = '';
      currentUserId.value = '';
      
      Get.offAll(() => LoginScreen());
      
      Get.snackbar(
        'Success', 
        'Signed out successfully',
          backgroundColor: AppColors.primary,
        colorText: Colors.black,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    }
  }
}

// import 'package:full_circle/screens/login_screen.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get_storage/get_storage.dart';
// import '../screens/otp_screen.dart';
// import '../screens/role_selection_screen.dart';
// import '../screens/home_screen.dart';

// class AuthController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final GetStorage _storage = GetStorage();

//   var verificationId = ''.obs;
//   var isLoading = false.obs;
//   var isAuthenticated = false.obs;
//   var userRole = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     checkAuthStatus();
//   }

//   void checkAuthStatus() async {
//     final user = _auth.currentUser;
//     final savedRole = _storage.read('userRole');

//     if (user != null && savedRole != null) {
//       isAuthenticated.value = true;
//       userRole.value = savedRole;
//       Get.offAll(() => HomeScreen());
//     }
//   }

//   void sendOTP(String phoneNumber) async {
//     try {
//       isLoading.value = true;
//       Get.to(() => OTPScreen(phoneNumber: phoneNumber));
//       isLoading.value = false;
//       // await _auth.verifyPhoneNumber(
//       //   phoneNumber: phoneNumber,
//       //   verificationCompleted: (PhoneAuthCredential credential) async {
//       //     await _auth.signInWithCredential(credential);
//       //     await _checkUserRoleAndNavigate();
//       //   },
//       //   verificationFailed: (FirebaseAuthException e) {
//       //     Get.snackbar('Error', e.message ?? 'Verification failed');
//       //     isLoading.value = false;
//       //   },
//       //   codeSent: (String verificationId, int? resendToken) {
//       //     this.verificationId.value = verificationId;
//       //     Get.to(() => OTPScreen(phoneNumber: phoneNumber));
//       //     isLoading.value = false;
//       //   },
//       //   codeAutoRetrievalTimeout: (String verificationId) {
//       //     this.verificationId.value = verificationId;
//       //     isLoading.value = false;
//       //   },
//       // );
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//       isLoading.value = false;
//     }
//   }

//   void verifyOTP(String otp) async {
//     try {
//       isLoading.value = true;

//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId.value,
//         smsCode: otp,
//       );

//       await _auth.signInWithCredential(credential);
//       await _checkUserRoleAndNavigate();

//       isLoading.value = false;
//     } catch (e) {
//       Get.snackbar('Error', 'Invalid OTP');
//       isLoading.value = false;
//     }
//   }

//   Future<void> _checkUserRoleAndNavigate() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       final userDoc = await _firestore.collection('users').doc(user.uid).get();

//       if (userDoc.exists && userDoc.data()?['role'] != null) {
//         // User already has a role, go to home screen
//         final role = userDoc.data()!['role'];
//         userRole.value = role;
//         _storage.write('userRole', role);
//         isAuthenticated.value = true;
//         Get.offAll(() => HomeScreen());
//       } else {
//         // User doesn't have a role, go to role selection
//         Get.offAll(() => RoleSelectionScreen());
//       }
//     }
//   }

//   Future<void> saveUserRole(String role) async {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         await _firestore.collection('users').doc(user.uid).set({
//           'role': role,
//           'phoneNumber': user.phoneNumber,
//           'createdAt': FieldValue.serverTimestamp(),
//           'updatedAt': FieldValue.serverTimestamp(),
//         }, SetOptions(merge: true));

//         userRole.value = role;
//         _storage.write('userRole', role);
//         isAuthenticated.value = true;
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to save role: $e');
//     }
//   }

//   void signOut() async {
//     await _auth.signOut();
//     _storage.erase();
//     isAuthenticated.value = false;
//     userRole.value = '';
//     Get.offAll(() => LoginScreen()); // You'll need to import your login screen
//   }
// }

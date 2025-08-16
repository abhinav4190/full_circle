import 'package:full_circle/utils/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../screens/role_success_screen.dart';

class RoleController extends GetxController {
  var selectedRole = ''.obs;
  final AuthController authController = Get.find<AuthController>();

  void selectRole(String role) async {
    selectedRole.value = role;
    await authController.saveUserRole(role);
    Get.to(() => RoleSuccessScreen());
  }

  Map<String, dynamic> getRoleContent(String role) {
    switch (role.toLowerCase()) {
      case 'producer':
        return {
          'title': 'Producer Dashboard',
          'description': 'You\'ve successfully selected the Producer role.\nStart managing your waste streams efficiently!',
          'features': [
            {
              'icon': Icons.inventory_2,
              'title': 'Declare Waste Pickups',
              'subtitle': 'Easily schedule waste pickups and\nmanage your waste streams.',
            },
            {
              'icon': Icons.connect_without_contact,
              'title': 'Connect with MRFs',
              'subtitle': 'Connect with verified MRFs to\nensure responsible waste handling.',
            },
            {
              'icon': Icons.analytics,
              'title': 'Track Impact & Earnings',
              'subtitle': 'Monitor your environmental impact and\nearnings from waste management.',
            },
          ],
          'buttonText': 'Continue to Producer Dashboard',
          'color': AppColors.primary, // Use consistent theme color
        };
      
      case 'mrf':
        return {
          'title': 'MRF Dashboard',
          'description': 'You\'ve successfully selected the MRF role.\nWelcome to your Material Recovery Facility hub!',
          'features': [
            {
              'icon': Icons.local_shipping,
              'title': 'Manage Collections',
              'subtitle': 'Coordinate waste collection from\nproducers in your network.',
            },
            {
              'icon': Icons.sort,
              'title': 'Sorting & Processing',
              'subtitle': 'Track sorting operations and\nprocess different material types.',
            },
            {
              'icon': Icons.handshake,
              'title': 'Connect with Recyclers',
              'subtitle': 'Build partnerships with recyclers\nfor processed materials.',
            },
          ],
          'buttonText': 'Continue to MRF Dashboard',
          'color': AppColors.primary, // Use consistent theme color
        };
      
      case 'recycler':
        return {
          'title': 'Recycler Dashboard',
          'description': 'You\'ve successfully selected the Recycler role.\nTransform waste into valuable resources!',
          'features': [
            {
              'icon': Icons.recycling,
              'title': 'Process Materials',
              'subtitle': 'Convert waste materials into\nnew products and raw materials.',
            },
            {
              'icon': Icons.factory,
              'title': 'Production Planning',
              'subtitle': 'Plan and optimize your\nrecycling production schedules.',
            },
            {
              'icon': Icons.trending_up,
              'title': 'Market Analytics',
              'subtitle': 'Track market prices and demand\nfor recycled materials.',
            },
          ],
          'buttonText': 'Continue to Recycler Dashboard',
          'color': AppColors.primary, // Use consistent theme color
        };
      
      default:
        return {
          'title': 'Dashboard',
          'description': 'Welcome to Full Circle!',
          'features': [],
          'buttonText': 'Continue to Dashboard',
          'color': AppColors.primary, // Use consistent theme color
        };
    }
  }

  IconData getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'producer':
        return Icons.factory;
      case 'mrf':
        return Icons.recycling;
      case 'recycler':
        return Icons.autorenew;
      default:
        return Icons.eco;
    }
  }

  Color getRoleColor(String role) {
    return AppColors.primary; // Use consistent theme color for all roles
    }
  }
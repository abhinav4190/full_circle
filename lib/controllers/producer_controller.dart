import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_controller.dart';

class ProducerController extends GetxController {
  final AuthController authController = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  var isLoading = false.obs;
  var wasteDeclarations = <Map<String, dynamic>>[].obs;
  var upcomingPickups = 0.obs;
  var totalWasteDeclared = 0.0.obs;
  var completedPickups = 0.obs;
  var totalEarnings = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducerData();
  }

  void loadProducerData() async {
    try {
      isLoading.value = true;
      
      // Get waste declarations for the producer
      final QuerySnapshot declarations = await authController.getUserDocuments('waste_declarations');
      
      wasteDeclarations.value = declarations.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      
      // Calculate stats
      _calculateStats();
      
    } catch (e) {
      print('Error loading producer data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateStats() {
    int upcoming = 0;
    double totalWaste = 0.0;
    int completed = 0;
    double earnings = 0.0;
    
    for (var declaration in wasteDeclarations) {
      final status = declaration['status'] ?? '';
      final quantity = (declaration['quantity'] ?? 0).toDouble();
      final pricePerKg = (declaration['pricePerKg'] ?? 0).toDouble();
      
      if (status == 'pending' || status == 'approved') {
        upcoming++;
      }
      
      if (status == 'completed') {
        completed++;
        earnings += quantity * pricePerKg;
      }
      
      totalWaste += quantity;
    }
    
    upcomingPickups.value = upcoming;
    totalWasteDeclared.value = totalWaste;
    completedPickups.value = completed;
    totalEarnings.value = earnings;
  }

  Future<bool> declareWaste(Map<String, dynamic> wasteData) async {
    try {
      isLoading.value = true;
      
      String docId = 'waste_${DateTime.now().millisecondsSinceEpoch}';
      await authController.saveToFirestore(
        collection: 'waste_declarations',
        docId: docId,
        data: wasteData,
      );
      
      // Reload data to update stats
      loadProducerData();
      
      return true;
    } catch (e) {
      print('Error declaring waste: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
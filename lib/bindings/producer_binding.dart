import 'package:full_circle/controllers/producer_controller.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProducerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProducerController>(() => ProducerController());
  }
}

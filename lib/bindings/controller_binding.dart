import 'package:get/get.dart';
import 'package:requester/controllers/connection_manager_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
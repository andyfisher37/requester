import 'package:get/get.dart';
import '../controllers/request_controller.dart';

class RequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RequestController());
  }
}

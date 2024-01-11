import 'package:get/get.dart';

import '../controllers/details_request_controller.dart';

class DetailsRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailsRequestController());
  }
}

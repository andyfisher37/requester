import 'package:get/get.dart';

import '../controllers/archive_controller.dart';

class ArchiveBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ArchiveController());
  }
}

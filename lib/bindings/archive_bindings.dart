import 'package:get/get.dart';

import '../controllers/archive_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ArchiveController());
  }
}

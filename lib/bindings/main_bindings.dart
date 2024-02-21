//import 'package:ecommerce_app/logic/controllers/cart_controllers.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/archive_controller.dart';
import 'package:requester/controllers/chat_controller.dart';
import 'package:requester/controllers/home_controllers.dart';
import '../controllers/main_controller.dart';
import '../controllers/settings_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
    Get.put(SettingsController());
    Get.put(ArchiveController());
    Get.put(HomeController());
    Get.put(MainController());
  }
}

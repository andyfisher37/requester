// ignore: file_names
import 'package:get/get.dart';
import '../controllers/onboarding_home_controller.dart';

class OnBoardingHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(OnBoardingHomeController());
   }

}
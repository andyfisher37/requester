import 'package:get/get.dart';
import 'dart:io';

class AddRequestScreenController extends GetxController {
  var swithRequestCategoryValue = false.obs;
  var isNDSValue = false.obs;

  String categoryValue = "";

  void updateCategoryValue() {
    swithRequestCategoryValue.isTrue
        ? categoryValue = "срочная"
        : categoryValue = "обычная";
    // update db...
    update();
  }

  void updateNDSValue() {
    // update db...
    update();
  }
}

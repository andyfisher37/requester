import 'package:get/get.dart';

class AddRequestScreenController {
  var swithRequestCategoryValue = false.obs;
  var isNDSValue = false.obs;

  String categoryValue = "";

  void updateCategoryValue() {
    swithRequestCategoryValue.isTrue
        ? categoryValue = "срочная"
        : categoryValue = "обычная";
    // update db...
  }

  void updateNDSValue() {
    // update db...
  }
}

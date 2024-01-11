import 'package:get/get.dart';
import 'package:requester/controllers/request_controller.dart';
import 'package:requester/models/request.dart';

class DetailsRequestController extends GetxController {
  Rx<Request> request = Request().obs;

  var isLoading = true.obs;

  @override
  void onInit() async {
    var id = Get.arguments[0]['id'] as String;
    request.value = (await RequestController.getByID(id))!;
    //prodectData.value = data;
    isLoading.value = false;
    //counter.value = 1;
    super.onInit();
  }

  void manageExecuting(Request req,
  ) async {
    // var index = favouritesList
    //     .indexWhere((element) => element.id == homeProdectData.id);
    // if (index >= 0) {
    //   favouritesList.removeAt(index);
    //   await storge.remove(
    //     'favouritesList',
    //   );
    // } else {
    //   favouritesList.addIf(
    //       !favouritesList.contains(homeProdectData), homeProdectData);
          
    //   final String encodedData = HomeProdectData.encode(favouritesList);
    //   await storge.setString('favouritesList', encodedData);
    // }
  }
}

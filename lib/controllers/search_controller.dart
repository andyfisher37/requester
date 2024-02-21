import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../enums/loading_types.dart';
import 'package:requester/models/request.dart';
import '../enums/loading_state.dart';
import '../services/search_services.dart';

class Search_Controller extends GetxController {
  // List of search results
  var searchRequestList = <Request>[].obs;

  int _pageNo = 1;

  final scrollControllerRequest = ScrollController();

  final loadingStateRequest = LoadingState(loadingType: LoadingType.stable).obs;

  var textFormFild = ''.obs;

  @override
  void onInit() async {
    scrollControllerRequest.addListener(_scrollListenerRequest);
  }

  void _scrollListenerRequest() async {
    if (scrollControllerRequest.offset >=
            scrollControllerRequest.position.maxScrollExtent &&
        !scrollControllerRequest.position.outOfRange) {
      loadingStateRequest.value =
          LoadingState(loadingType: LoadingType.loading);
      try {
        await Future.delayed(Duration(seconds: 5));
        final listOfData = await SearchServices.viewRequestsSearch(
            _pageNo, textFormFild.value);

        if (searchRequestList.isEmpty) {
          loadingStateRequest.value = LoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          searchRequestList.addAll(listOfData);
          loadingStateRequest.value =
              LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingStateRequest.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  void viewSearchRequests(String searchVal) async {
    final listOfData =
        await SearchServices.viewRequestsSearch(_pageNo, searchVal);
    searchRequestList.assignAll(listOfData);
    // isLoadingRequests.value = false;
  }
}

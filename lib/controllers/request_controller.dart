import 'package:get/get.dart';
import 'package:requester/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestController extends GetxController {
  //final requestList = <Request>[].obs;

  List<Request> requestList = <Request>[].obs;

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Request');

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    requestList =
        data.map((e) => Request.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<void> addRequest(Request request) async {
    requestList.add(request);
    await _collectionRef.add(request);
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onInit() {
    super.onInit();
  }
}

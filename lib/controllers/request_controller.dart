import 'package:get/get.dart';
import 'package:requester/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Контроллер операций с заявками
class RequestController extends GetxController {
  
  // Список заявок
  List<Request> requestList = <Request>[].obs;

  // Получение ссылки на коллекцию целиком
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Request');
  
  // Получение данных из коллекции и преобразование в список заявок 
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    if (data.isNotEmpty) {
      requestList =
          data.map((e) => Request.fromMap(e as Map<String, dynamic>)).toList();
    }
  }

  // Добавление новой заявки
  Future<void> addRequest(Request request) async {
    requestList.add(request);
    await _collectionRef.add(request);
  }

  Future<void> updateRequest(Request newValue, String uid, String reqID ) async {
    try {
      _collectionRef.doc(reqID).update(newValue.toMap(newValue));
    } catch (e) {
      print(e);
      rethrow;
    }
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

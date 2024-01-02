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
    update();
  }

  // Выборка всей коллекции - на выходе список
  static Future<List<Request>> getAllEntries() async {
    return (await FirebaseFirestore.instance.collection('Request').get())
        .docs
        .map((item) => Request.fromMap(item.data()))
        .toList();
  }

  Future<List<Request>> getRequestData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data.map((e) => Request.fromMap(e as Map<String, dynamic>)).toList();
  }

  // Добавление новой заявки
  Future<void> addRequest(Request request) async {
    requestList.add(request);
    await _collectionRef.add(request);
    getData();
  }

  Future<void> updateRequest(Request newValue, String uid, String reqID) async {
    try {
      _collectionRef.doc(reqID).update(newValue.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Выборка с сортировкой по названию
  static Future<List<Request>> getAllEntriesSortedByTitle() async {
    return (await FirebaseFirestore.instance
            .collection('Request')
            .orderBy("title", descending: false)
            .get())
        .docs
        .map((item) => Request.fromMap(item.data()))
        .toList();
  }

  // Выборка только активных (на исполнении)
  static Future<List<Request>> getAllEntriesFilteredByPrice() async {
    return (await FirebaseFirestore.instance
            .collection('Request')
            .where("isExecute", isEqualTo: true)
            .get())
        .docs
        .map((item) => Request.fromMap(item.data()))
        .toList();
  }

  // Обновление документа по ID (missing fields won't be touched on update), document must exist
  static Future updateEntryWithId(
      String documentId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('Request')
        .doc(documentId)
        .update(data);
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}

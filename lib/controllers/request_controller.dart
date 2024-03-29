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
    requestList.clear();
    QuerySnapshot qs = await _collectionRef.get();
    final data = qs.docs.map((doc) => doc.data()).toList();
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
    await _collectionRef.add(request.toMap());
    getData();
  }

  // Удаление заявки по индексу в списке
  Future<void> deleteRequest(int index) async {
    QuerySnapshot qs = await _collectionRef.get();
    qs.docs[index].reference.delete();
    getData();
  }

  // Удаление заявки по ID
  Future<void> deleteRequestID(String id) async {
    QuerySnapshot qs = await _collectionRef.get();
    int index = 0;
    for (var element in qs.docs) {
      if (element.get('id') == id) {
        qs.docs[index].reference.delete();
      } else {
        index++;
      }
    }
    getData();
  }

// Восстановлеие удаленной заявки
  Future<void> restoreRequest(int index, Request req) async {
    //index == null ? addRequest(req) : await _collectionRef.ins
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

  // Выбор по ID
  static Future<Request?> getByID(String id) async {
    final ref = FirebaseFirestore.instance
        .collection("Request")
        .where("id", isEqualTo: id)
        .withConverter(
            fromFirestore: Request.fromFirestore,
            toFirestore: (Request req, _) => req.toFirestore());

    final docSnap = await ref.get();
    final rq = docSnap.docs[0].data();
    return rq;
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

import 'package:get/get.dart';
import 'package:requester/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArchiveController extends GetxController {
  // Список архивных заявок
  List<Request> archiveList = <Request>[].obs;

  // Получение ссылки на коллекцию целиком
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Archive');

  // Получение данных из коллекции и преобразование в список
  Future<void> getData() async {
    archiveList.clear();
    QuerySnapshot qs = await _collectionRef.get();
    final data = qs.docs.map((doc) => doc.data()).toList();
    if (data.isNotEmpty) {
      archiveList =
          data.map((e) => Request.fromMap(e as Map<String, dynamic>)).toList();
    }
    update();
  }

  // Добавление новой заявки
  Future<void> addRequest(Request request) async {
    archiveList.add(request);
    await _collectionRef.add(request.toMap());
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
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String? id; // id заявки
  late String title; // краткое название заявки
  late String category; // категория (обычная, срочная)
  late bool isExecute; // Статус исполнения заявки
  late String description; // полное описание заявки
  late String type;
  late double summa; // сумма
  late double stavka; // ставка
  late int inn; // ИНН владельца
  late bool isNDS; // с НДС или без
  late DateTime paydate; // дата платежа
  late DateTime returndate; // дата возврата

  Request({
    required this.id,
    required this.title,
    required this.category,
    required this.isExecute,
    required this.description,
    required this.type,
    required this.summa,
    required this.stavka,
    required this.inn,
    required this.isNDS,
    required this.paydate,
    required this.returndate,
  });

  /// Creates a new [Request] object from a [Map] representation.
  Request.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    category = map['category'];
    isExecute = map['isExecute'];
    description = map['description'];
    type = map['type'];
    summa = double.parse(map['summa'].toString());
    stavka = map['stavka'];
    inn = map['inn'];
    isNDS = map['isNDS'];
    paydate = map['paydate'].toDate();
    returndate = map['returndate'].toDate();
  }

  /// Creates a new [Request] object from a [DocumentSnapshot] object.
  Request.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot['id'];
    title = documentSnapshot['title'];
    category = documentSnapshot['category'];
    isExecute = documentSnapshot['isExecute'];
    description = documentSnapshot['description'];
    type = documentSnapshot['type'];
    summa = documentSnapshot['summa'].toDouble();
    stavka = documentSnapshot['stavka'].toDouble();
    inn = documentSnapshot['inn'].toInt();
    isNDS = documentSnapshot['isNDS'];
    paydate = DateTime.parse(documentSnapshot['paydate']);
    returndate = DateTime.parse(documentSnapshot['returndate']);
  }
}

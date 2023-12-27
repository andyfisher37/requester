import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String? id; // id заявки
  late String userID; // id пользователя
  late String title; // краткое название заявки
  late String category; // категория (обычная, срочная)
  late bool isExecute; // Статус исполнения заявки
  late String description; // полное описание заявки
  late double summa; // сумма
  late double stavka; // ставка
  late int inn; // ИНН владельца
  late bool isNDS; // с НДС или без
  late DateTime paydate; // дата платежа
  late DateTime returndate; // дата возврата

  Request({
    required this.id,
    required this.userID,
    required this.title,
    required this.category,
    required this.isExecute,
    required this.description,
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
    userID = map['userID'];
    title = map['title'];
    category = map['category'];
    isExecute = map['isExecute'];
    description = map['description'];
    summa = double.parse(map['summa'].toString());
    stavka = map['stavka'];
    inn = map['inn'];
    isNDS = map['isNDS'];
    paydate = map['paydate'].toDate();
    returndate = map['returndate'].toDate();
  }

  Map<String, dynamic> toMap(Request req) {
    return {
      'id': req.id,
      'userID': req.userID,
      'title': req.title,
      'category': req.category,
      'isExecute': req.isExecute,
      'description': req.description,
      'summa': req.summa,
      'stavka': req.stavka,
      'inn': req.inn,
      'isNDS': req.isNDS,
      'paydate': req.paydate,
      'returndate': req.returndate,
    };
  }

  /// Creates a new [Request] object from a [DocumentSnapshot] object.
  Request.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot['id'];
    userID = category = documentSnapshot['userID'];
    title = documentSnapshot['title'];
    category = documentSnapshot['category'];
    isExecute = documentSnapshot['isExecute'];
    description = documentSnapshot['description'];
    summa = documentSnapshot['summa'].toDouble();
    stavka = documentSnapshot['stavka'].toDouble();
    inn = documentSnapshot['inn'].toInt();
    isNDS = documentSnapshot['isNDS'];
    paydate = DateTime.parse(documentSnapshot['paydate']);
    returndate = DateTime.parse(documentSnapshot['returndate']);
  }
}

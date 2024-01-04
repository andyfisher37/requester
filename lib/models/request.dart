import 'dart:convert';
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

  factory Request.fromJson(String str) => Request.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  /// Creates a new [Request] object from a [Map] representation.
  factory Request.fromMap(Map<String, dynamic> map) => Request(
        id: map['id'],
        userID: map['userID'],
        title: map['title'],
        category: map['category'],
        isExecute: map['isExecute'],
        description: map['description'],
        summa: double.parse(map['summa'].toString()),
        stavka: map['stavka'],
        inn: map['inn'],
        isNDS: map['isNDS'],
        paydate: map['paydate'].toDate(),
        returndate: map['returndate'].toDate(),
      );

  // Преобразование в карту
  Map<String, dynamic> toMap() => {
        'id': id,
        'userID': userID,
        'title': title,
        'category': category,
        'isExecute': isExecute,
        'description': description,
        'summa': summa,
        'stavka': stavka,
        'inn': inn,
        'isNDS': isNDS,
        'paydate': paydate,
        'returndate': returndate,
      };

  /// Creates a new [Request] object from a [DocumentSnapshot] object.
  factory Request.fromDocumentSnapshot(DocumentSnapshot ds) => Request(
        id: ds['id'],
        userID: ds['userID'],
        title: ds['title'],
        category: ds['category'],
        isExecute: ds['isExecute'],
        description: ds['description'],
        summa: double.parse(ds['summa'].toString()),
        stavka: ds['stavka'],
        inn: ds['inn'],
        isNDS: ds['isNDS'],
        paydate: ds['paydate'].toDate(),
        returndate: ds['returndate'].toDate(),
      );
}

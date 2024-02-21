import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String? id; // id заявки
  final String? userID; // id пользователя
  final String? title; // краткое название заявки
  final String? category; // категория (обычная, срочная)
  bool? isExecute; // Статус исполнения заявки
  final String? description; // полное описание заявки
  final double? summa; // сумма
  final double? stavka; // ставка
  final int? inn; // ИНН владельца
  final bool? isNDS; // с НДС или без
  final DateTime? paydate; // дата платежа
  final DateTime? returndate; // дата возврата

  Request({
    this.id,
    this.userID,
    this.title,
    this.category,
    this.isExecute,
    this.description,
    this.summa,
    this.stavka,
    this.inn,
    this.isNDS,
    this.paydate,
    this.returndate,
  });

  factory Request.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Request(
      id: data?['id'],
      userID: data?['userID'],
      title: data?['title'],
      category: data?['category'],
      isExecute: data?['isExecute'],
      description: data?['description'],
      summa: double.parse(data!['summa'].toString()),
      stavka: data?['stavka'],
      inn: data?['inn'],
      isNDS: data?['isNDS'],
      paydate: data?['paydate'].toDate(),
      returndate: data?['returndate'].toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (userID != null) "userID": userID,
      if (title != null) "title": title,
      if (category != null) "category": category,
      if (isExecute != null) "isExecute": isExecute,
      if (description != null) "description": description,
      if (summa != null) "summa": summa,
      if (stavka != null) "stavka": stavka,
      if (inn != null) "inn": inn,
      if (isNDS != null) "isNDS": isNDS,
      if (paydate != null) "paydate": paydate,
      if (returndate != null) "returndate": returndate,
    };
  }

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

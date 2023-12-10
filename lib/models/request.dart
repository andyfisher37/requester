// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

class Request extends StatelessWidget {
  const Request({
    Key? key,
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
  }) : super(key: key);

  final String title; // краткое название заявки
  final String category; // категория (обычная, срочная)
  final bool isExecute; // Статус исполнения заявки
  final String description; // полное описание заявки
  final String type;
  final double summa; // сумма
  final double stavka; // ставка
  final int inn; // ИНН владельца
  final bool isNDS; // с НДС или без
  final DateTime paydate; // дата платежа
  final DateTime returndate; // дата возврата

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              primaryColor: Colors.blue,
              unselectedWidgetColor: Color(0xff5e616a),
            ),
            child: Transform.scale(
              scale: 1.3,
              child: Checkbox(
                activeColor: Color(0xff6cf8a9),
                checkColor: Color(0xff0e3e26),
                value: isExecute,
                onChanged: (_) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 27,
                      width: 27,
                      child: Icon(
                        Icons.edit_document,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      paydate.format('dd-mm-yyyy'),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/request_controller.dart';
import 'package:intl/intl.dart';
import 'package:date_time_format/date_time_format.dart';

class AddRequestPage extends StatefulWidget {
  const AddRequestPage({Key? key}) : super(key: key);
  // final RequestController controller = Get.find();
  // final int index;

  @override
  State<AddRequestPage> createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _summaController = TextEditingController();
  TextEditingController _stavkaController = TextEditingController();
  TextEditingController _returnDateController = TextEditingController();
  TextEditingController _innController = TextEditingController();
  String type = "";
  String category = "";
  bool isNDSChecked = false;

  @override
  Widget build(BuildContext context) {
    // final req = controller.requestList[index];

    return SafeArea(
        child: Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff252041),
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Добавление новой заявки:",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'Lobster',
                      ),
                    ),
                    /* const Text(
                      "Новая заявка",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ), */
                    const SizedBox(
                      height: 5,
                    ),
                    label("Название:"),
                    const SizedBox(
                      height: 5,
                    ),
                    title(),
                    const SizedBox(
                      height: 5,
                    ),
                    label("Важность:"),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        taskSelect("Срочная", 0xff2664fa),
                        const SizedBox(
                          width: 5,
                        ),
                        taskSelect("Обычная", 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    label("Краткое описание:"),
                    const SizedBox(
                      height: 5,
                    ),
                    description(),
                    const SizedBox(
                      height: 5,
                    ),
                    label("Сумма:"),
                    const SizedBox(
                      height: 5,
                    ),
                    summa(),
                    const SizedBox(
                      height: 5,
                    ),
                    label("Ставка:"),
                    const SizedBox(
                      height: 5,
                    ),
                    stavka(),
                    label("Категория заявки:"),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        categorySelect("Обмен", 0xffff6d6e),
                        const SizedBox(
                          width: 5,
                        ),
                        categorySelect("Housework", 0xfff29732),
                        const SizedBox(
                          width: 5,
                        ),
                        categorySelect("Grocery", 0xff6557ff),
                        const SizedBox(
                          width: 5,
                        ),
                        categorySelect("GYM", 0xff2bc8d9),
                        const SizedBox(
                          width: 5,
                        ),
                        categorySelect("Work", 0xff663300),
                        const SizedBox(
                          width: 5,
                        ),
                        categorySelect("School", 0xff009900),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    label("ИНН:"),
                    const SizedBox(
                      height: 5,
                    ),
                    innField(),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        label('С НДС:'),
                        Checkbox(
                          value: isNDSChecked,
                          onChanged: (newValue) {
                            setState(() {
                              isNDSChecked = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    label("Дата возврата:"),
                    const SizedBox(
                      height: 5,
                    ),
                    returnDate(),
                    const SizedBox(
                      height: 30,
                    ),
                    createButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: type == label ? Colors.white : Color(color),
        label: Text(
          label,
          style: TextStyle(
            color: type == label ? Colors.black : Colors.white,
            fontSize: 13,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 7),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: category == label ? Colors.black : Color(color),
        label: Text(
          label,
          style: TextStyle(
            color: type == label ? Colors.white : Colors.white,
            fontSize: 13,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 7),
      ),
    );
  }

// Кнопка создания заявки...
  Widget createButton() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("Request").add({
          'title': _titleController.text,
          'category': category,
          'isExecute': false,
          'description': _descriptionController.text,
          'type': type,
          'summa': double.parse(_summaController.text),
          'stavka': double.parse(_stavkaController.text),
          'inn': int.parse(_innController.text),
          'isNDS': isNDSChecked,
          'paydate': DateTime.now(),
          'returndate': DateTime.parse(_returnDateController.text),
        });
        Navigator.pop(context);
      },
      child: Container(
          height: 55,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [
              Color(0xffff9999),
              Color(0xffff5050),
              Color(0xffff4500),
            ]),
          ),
          child: const Center(
            child: Text(
              'Добавить заявку',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          )),
    );
  }

  Widget description() {
    return Container(
      height: 120,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: null,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: const InputDecoration(
            hintText: "Описание заявки...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 8)),
      ),
    );
  }

  Widget summa() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _summaController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, letterSpacing: 3),
        decoration: const InputDecoration(
            hintText: "Сумма заявки",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10)),
      ),
    );
  }

  Widget stavka() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _stavkaController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, letterSpacing: 3),
        decoration: const InputDecoration(
            hintText: "Ставка заявки",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10)),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: const InputDecoration(
            hintText: "Название заявки",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 5)),
      ),
    );
  }

  Widget innField() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLines: 1,
        controller: _innController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: const InputDecoration(
            hintText: "123456789101112",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 5)),
        validator: (inn) {
          if (inn!.length != 12 || inn!.length != 10)
            return "Неверный формат ИНН";
        },
      ),
    );
  }

  Widget returnDate() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        controller: _returnDateController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        maxLines: 1,
        decoration: const InputDecoration(
            hintText: "дд:мм:гггг",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 5)),
        onTap: () async {
          DateTime date = DateTime(1900);
          FocusScope.of(context).requestFocus(FocusNode());

          date = (await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 30)),
              firstDate: DateTime.now().add(const Duration(days: 1)),
              lastDate: DateTime(2100)))!;

          _returnDateController.text = DateTimeFormat.format(
            date,
            format: 'd.m.Y',
          );
        },
      ),
    );
  }

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.5,
        fontWeight: FontWeight.w300,
        letterSpacing: 1.5,
      ),
    );
  }
}

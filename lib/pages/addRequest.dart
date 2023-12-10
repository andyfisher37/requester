// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRequestPage extends StatefulWidget {
  const AddRequestPage({Key? key}) : super(key: key);

  @override
  State<AddRequestPage> createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _summaController = TextEditingController();
  String type = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
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
                icon: Icon(
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
                    Text(
                      "Создание",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Новая заявка",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    label("Название:"),
                    SizedBox(
                      height: 12,
                    ),
                    title(),
                    SizedBox(
                      height: 10,
                    ),
                    label("Важность:"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        taskSelect("Срочная", 0xff2664fa),
                        SizedBox(
                          width: 15,
                        ),
                        taskSelect("Обычная", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    label("Краткое описание:"),
                    SizedBox(
                      height: 10,
                    ),
                    description(),
                    SizedBox(
                      height: 10,
                    ),
                    summa(),
                    SizedBox(
                      height: 15,
                    ),
                    label("Категория:"),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        categorySelect("Обмен", 0xffff6d6e),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("Housework", 0xfff29732),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("Grocery", 0xff6557ff),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("GYM", 0xff2bc8d9),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("Work", 0xff663300),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("School", 0xff009900),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    SizedBox(
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
              fontWeight: FontWeight.bold),
        ),
        labelPadding: EdgeInsets.symmetric(vertical: 3.8, horizontal: 13),
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
              fontWeight: FontWeight.bold),
        ),
        labelPadding: EdgeInsets.symmetric(vertical: 3.8, horizontal: 13),
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
          'stavka': 1.0,
          'inn': 137000023,
          'isNDS': false,
          'paydate': DateTime.now(),
          'returndate': DateTime.now(),
        });
        Navigator.pop(context);
      },
      child: Container(
          child: Center(
            child: Text(
              'Добавить заявку',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ),
          height: 55,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xffff9999),
              Color(0xffff5050),
              Color(0xffff4500),
            ]),
          )),
    );
  }

  Widget description() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: null,
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
            hintText: "Description",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 8)),
      ),
    );
  }

  Widget summa() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _summaController,
        keyboardType: TextInputType.number,
        maxLines: null,
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
            hintText: "Сумма заявки",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 8)),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
            hintText: "Task Title",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 5)),
      ),
    );
  }

  Widget label(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: 16.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2),
    );
  }
}

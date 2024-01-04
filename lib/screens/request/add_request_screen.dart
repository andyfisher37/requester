import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:requester/controllers/add_request_screen_controller.dart';

import 'package:requester/controllers/request_controller.dart';
import 'package:intl/intl.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:requester/models/request.dart';

class AddRequestScreen extends StatelessWidget {
  final _Form = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _summaController = TextEditingController();
  TextEditingController _stavkaController = TextEditingController();
  TextEditingController _returnDateController = TextEditingController();
  TextEditingController _innController = TextEditingController();

  bool isNDSChecked = false;

  AddRequestScreen({super.key});

  final controller = Get.find<AddRequestScreenController>();
  final ctrl = Get.find<RequestController>();

  @override
  Widget build(BuildContext context) {
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
          key: _Form,
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
                    selectCategory(context),
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
                    const SizedBox(
                      height: 5,
                    ),
                    label("ИНН:"),
                    const SizedBox(
                      height: 5,
                    ),
                    innField(),
                    const SizedBox(
                      height: 5,
                    ),
                    selectNDS(context),
                    const SizedBox(
                      height: 5,
                    ),
                    label("Дата возврата:"),
                    const SizedBox(
                      height: 5,
                    ),
                    returnDate(context),
                    const SizedBox(
                      height: 30,
                    ),
                    createButton(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  // Название заявки
  Widget title() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isNotEmpty) return null;
          return 'Введите название';
        },
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

// селектор категории
  Widget selectCategory(BuildContext ctx) {
    String cat = "(обычная)";
    return Obx(
      () => ListTile(
        leading: Icon(
          Icons.speed_outlined,
          color: Theme.of(ctx).textTheme.headline1!.color,
        ),
        title: Text(
          'Категория: $cat',
          style: TextStyle(
            color: Theme.of(ctx).textTheme.labelMedium!.color,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: SizedBox(
          width: 70.w,
          child: FlutterSwitch(
            height: 22.0,
            width: 55.0,
            padding: 1.5,
            toggleSize: 20.0,
            borderRadius: 13.0,
            activeColor: Colors.red,
            inactiveColor: Colors.green,
            value: controller.swithRequestCategoryValue.value,
            onToggle: (value) {
              controller.updateCategoryValue();
              controller.swithRequestCategoryValue.value = value;
              controller.swithRequestCategoryValue.isFalse
                  ? cat = "(обычная)"
                  : cat = "(срочная)";
              // print(value);
            },
          ),
        ),
      ),
    );
  }

  // Описание заявки (может быть пустым)
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

// селектро НДС
  Widget selectNDS(BuildContext ctx) {
    String lead_text = "Без";
    return Obx(
      () => ListTile(
        leading: Icon(
          Icons.wrap_text_sharp,
          color: Theme.of(ctx).textTheme.headline1!.color,
        ),
        title: Text(
          '$lead_text НДС:',
          style: TextStyle(
            color: Theme.of(ctx).textTheme.labelMedium!.color,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: SizedBox(
          width: 70.w,
          child: FlutterSwitch(
            height: 22.0,
            width: 55.0,
            padding: 1.5,
            toggleSize: 20.0,
            borderRadius: 13.0,
            activeColor: Colors.red,
            inactiveColor: Colors.green,
            value: controller.isNDSValue.value,
            onToggle: (value) {
              controller.updateNDSValue();
              controller.isNDSValue.value = value;
              controller.isNDSValue.isFalse
                  ? lead_text = "С"
                  : lead_text = "Без";
              // print(value);
            },
          ),
        ),
      ),
    );
  }

// Сумма заявки (не может быть нулевой, только цифры)
  Widget summa() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isNotEmpty && GetUtils.isNum(value)) return null;
          return 'Введите сумму заявки';
        },
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

// Ставка заявки (число)
  Widget stavka() {
    return Container(
      height: 40,
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _stavkaController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, letterSpacing: 3),
        decoration: InputDecoration(
          hintText: "Ставка заявки",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        ),
        validator: (value) {
          if (value!.isNotEmpty && GetUtils.isNum(value)) return null;
          return 'Введите числовое значение ставки';
        },
      ),
    );
  }

// ИНН (Цифра 10 или 12 знаков)
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
        maxLength: 12,
        controller: _innController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: const InputDecoration(
            hintText: "123456789101112",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 5)),
        validator: (inn) {
          if ((inn!.length == 10 || inn.length == 12) &&
              GetUtils.isNumericOnly(inn)) return null;
          return "Неверный формат ИНН";
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget returnDate(BuildContext ctx) {
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
        validator: (value) {
          if (GetUtils.isDateTime(value!)) return null;
          return 'Введите корректную дату';
        },
        decoration: const InputDecoration(
            hintText: "дд:мм:гггг",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 5)),
        onTap: () async {
          DateTime date = DateTime(1900);
          FocusScope.of(ctx).requestFocus(FocusNode());

          date = (await showDatePicker(
              context: ctx,
              initialDate: DateTime.now().add(const Duration(days: 30)),
              firstDate: DateTime.now().add(const Duration(days: 1)),
              lastDate: DateTime(2100)))!;

          _returnDateController.text = DateTimeFormat.format(
            date,
            format: 'Y-m-d',
          );
        },
      ),
    );
  }

// Кнопка создания заявки...
  Widget createButton(BuildContext ctx) {
    return InkWell(
      onTap: () {
        if (_Form.currentState != null && _Form.currentState!.validate()) {
          var item = Request(
            title: _titleController.text,
            category: controller.categoryValue,
            isExecute: false,
            description: _descriptionController.text,
            summa: double.parse(_summaController.text),
            stavka: double.parse(_stavkaController.text),
            inn: int.parse(_innController.text),
            isNDS: controller.isNDSValue.value,
            paydate: DateTime.now(),
            returndate: DateTime.parse(_returnDateController.text),
            userID: "userID",
            id: UniqueKey().toString(),
          );
          ctrl.addRequest(item);
          Navigator.pop(ctx);
        }
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

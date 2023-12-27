import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/request_controller.dart';
import 'package:requester/models/request.dart';

class ViewReqDataPage extends StatelessWidget {
  final RequestController controller = Get.find();

  //final Map<String, dynamic> document;
  final int index;

  ViewReqDataPage({super.key, required this.index});

//   @override
//   State<ViewReqDataPage> createState() => _ViewReqDataPageState();
// }

// class _ViewReqDataPageState extends State<ViewReqDataPage> {
// late TextEditingController _titleController;
//  late TextEditingController _descriptionController;
//  late TextEditingController _summaController;

  String category = "";
  bool edit = false;

  // @override
  // void initState() {
  //   super.initState();

  //}

  @override
  Widget build(BuildContext context) {
    final req = controller.requestList[index];

    String title = req.title == null ? "Title is Empty" : req.title;
    TextEditingController _titleController =
        TextEditingController(text: req.title);

    String description =
        req.description == null ? "Description is Empty" : req.description;
    TextEditingController _descriptionController =
        TextEditingController(text: req.description);

    double summa = req.summa == null ? 0.0 : double.parse(req.summa.toString());
    TextEditingController _summaController =
        TextEditingController(text: req.summa.toString());

    category = req.category;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // setState(() {
                          //   edit = !edit;
                          // });
                        },
                        icon: Icon(
                          CupertinoIcons.pen,
                          color: edit == false ? Colors.white : Colors.red,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Request")
                              .doc(req.id)
                              .delete()
                              .then((value) => Get.back());
                        },
                        icon: const Icon(
                          CupertinoIcons.trash,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? "Editing" : "View",
                      style: const TextStyle(
                          letterSpacing: 3,
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Request",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    label("Task Title"),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 40,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff2a2e3d),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        enabled: edit ? true : false,
                        controller: _titleController,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                            hintText: "Task Title",
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            contentPadding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 5)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    label("Task Type"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        taskSelect("Important", 0xff2664fa),
                        const SizedBox(
                          width: 15,
                        ),
                        taskSelect("Planned", 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    label("Description"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 120,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff2a2e3d),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        enabled: edit ? true : false,
                        controller: _descriptionController,
                        maxLines: null,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                            hintText: "Description",
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20, top: 8)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff2a2e3d),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _summaController,
                        maxLines: null,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                            hintText: "Сумма заявки",
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20, top: 8)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    label("Category"),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        categorySelect("Errands", 0xffff6d6e),
                        const SizedBox(
                          width: 15,
                        ),
                        categorySelect("Housework", 0xfff29732),
                        const SizedBox(
                          width: 15,
                        ),
                        categorySelect("Grocery", 0xff6557ff),
                        const SizedBox(
                          width: 15,
                        ),
                        categorySelect("GYM", 0xff2bc8d9),
                        const SizedBox(
                          width: 15,
                        ),
                        categorySelect("Work", 0xff663300),
                        const SizedBox(
                          width: 15,
                        ),
                        categorySelect("School", 0xff009900),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    edit
                        ? InkWell(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("Request")
                                  .doc(controller.requestList[index].id)
                                  .update({
                                'title': _titleController.text,
                                'category': category,
                                'isExecute': false,
                                'description': _descriptionController.text,
                                'summa': double.parse(_summaController.text),
                                'stavka': 1.0,
                                'inn': 137000023,
                                'isNDS': false,
                                'paydate': DateTime.now(),
                                'returndate': DateTime.now(),
                                'userID': '',
                              });
                              Get.back();
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
                                    'Обновить заявку',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                )),
                          )
                        : Container(),
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
      onTap: edit
          ? () {
              // setState(() {
              //   type = label;
              // });
            }
          : null,
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // backgroundColor: type == label ? Colors.white : Color(color),
        label: Text(
          label,
          style: TextStyle(
              //  color: type == label ? Colors.black : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 13),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              // setState(() {
              //   category = label;
              // });
            }
          : null,
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: category == label ? Colors.black : Color(color),
        label: Text(
          label,
          style: TextStyle(
              // color: type == label ? Colors.white : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 13),
      ),
    );
  }

  /* Widget createButton() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance
            .collection("Request")
            .doc(controller.requestList[index].id)
            .update({
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
        Get.back();
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
              'Обновить заявку',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          )),
    );
  } */

/*   Widget description() {
    return Container(
      height: 120,
      width: Get.size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        enabled: edit ? true : false,
        controller: _descriptionController,
        maxLines: null,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: const InputDecoration(
            hintText: "Description",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 8)),
      ),
    );
  } */

/*   Widget summa() {
    return Container(
      height: 60,
      width: Get.size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: _summaController,
        maxLines: null,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: const InputDecoration(
            hintText: "Сумма заявки",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, top: 8)),
      ),
    );
  } */

/*   Widget title() {
    return Container(
      height: 40,
      width: Get.size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        enabled: edit ? true : false,
        controller: _titleController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: const InputDecoration(
            hintText: "Task Title",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 5)),
      ),
    );
  } */

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 16.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2),
    );
  }
}

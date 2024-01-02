// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_if_null_operators
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:requester/controllers/add_request_screen_controller.dart';
import 'package:requester/controllers/home_controllers.dart';
//import 'package:requester/custom/todoCard.dart';
import 'package:requester/models/request.dart';
import 'package:requester/screens/request/add_request_screen.dart';
import 'package:requester/pages/signin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:requester/pages/viewdata.dart';
import 'package:requester/pages/viewReqDataPage.dart';
import 'package:requester/routes/routes.dart';
import 'package:requester/service/google_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:requester/controllers/request_controller.dart';
import 'package:requester/screens/request/request_view.dart';
import 'package:requester/widgets/appbarItem.dart';
import 'package:requester/widgets/homeRequestCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthClass authClass = AuthClass();
  var ctrl = Get.find<RequestController>();

  // Обновление основного экрана на главной странице
  Future<Null> _refreshLocalGallery() async {
    ctrl.getData();
  }

  // final Stream<QuerySnapshot> _stream =
  //     FirebaseFirestore.instance.collection("Todo").snapshots();
  // final Stream<QuerySnapshot> _req_stream =
  //     FirebaseFirestore.instance.collection("Request").snapshots();

  @override
  Widget build(BuildContext context) {
    //final requestController = Get.find<RequestController>();
    Get.put(AddRequestScreenController());

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            RefreshIndicator(
              onRefresh: _refreshLocalGallery,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarItem(),
                    SizedBox(
                      height: 10.h,
                    ),
                    GetBuilder<HomeController>(builder: (_) => requestShow()),
                    SizedBox(
                      height: 10.h,
                    ),

                    // CustomRowHomePage(
                    //     firstText: 'Popular foods'.tr,
                    //     scoindText: 'SeeMore'.tr,
                    //     press: () {
                    //       Get.toNamed(Routes.allFoodScreen);
                    //     }),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: addRequestButton(),
            ),
          ],
        ),

        /* Obx(
          () => ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      Request? removed = requestController.requestList[index];
                      requestController.requestList.removeAt(index);
                      Get.snackbar(
                          'ВНИМАНИЕ', 'Заявка "${removed.title}" удалена.',
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(seconds: 8),
                          mainButton: TextButton(
                            child: Text('Undo',
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 201, 202, 202))),
                            onPressed: () {
                              if (removed.isNull) {
                                return;
                              }
                              requestController.requestList
                                  .insert(index, removed!);
                              removed = null;
                              if (Get.isSnackbarOpen) {
                                Get.back();
                              }
                            },
                          ));
                    },
                    child: ListTile(
                      title: Text(requestController.requestList[index].title,
                          style:
                              (requestController.requestList[index].isExecute)
                                  ? TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough)
                                  : TextStyle(color: Colors.white)),
                      onTap: () {
                        Get.to(() => ViewReqDataPage(index: index));
                      },
                      leading: Checkbox(
                        value: requestController.requestList[index].isExecute,
                        onChanged: (v) {
                          bool ch =
                              requestController.requestList[index].isExecute;
                          ch = v!;
                          requestController.requestList[index].isExecute = ch;
                          requestController.update();
                        },
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
              separatorBuilder: (_, __) => Divider(),
              itemCount: requestController.requestList.length),
        ), */
        backgroundColor: Colors.black87,

        /* appBar: AppBar(
          // leading: SvgPicture.asset(
          //   'assets/icons/menu.svg',
          //   color: Colors.white,
          // ),
          // leadingWidth: 30,
          centerTitle: true,
          actions: [
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.logout,
              ),
              onPressed: () async {
                Get.snackbar(
                  'ВНИМАНИЕ',
                  'Выход из профиля',
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                );
                authClass.logOut(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignInPage()),
                    (route) => false);
              },
            ),
          ],
          backgroundColor: Colors.black87,
          title: Text(
            "Заявки и исполнение",
            style: TextStyle(
                fontFamily: 'Lobster',
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Center(
                  child: Text(
                    DateTimeFormat.format(
                      DateTime.now(),
                      format: 'D d.m.Y',
                    ),
                    style: TextStyle(color: Colors.white, fontFamily: 'Anton'),
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35),
          ),
        ), */
        /* bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Icon(
                    size: 32,
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                label: '',
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Get.to(() => AddRequestPage());
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (builder) => AddRequestPage()));
                    //MaterialPageRoute(
                    //builder: (builder) => AddTodoPage()));
                  },
                  child: Container(
                    height: 50,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffff9999),
                          Color(0xffff5050),
                          Color(0xffff4500),
                        ],
                      ),
                    ),
                    child: Icon(
                      size: 32,
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                label: '',
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Icon(
                    size: 32,
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
                label: '',
                backgroundColor: Colors.red),
          ],
        ), */

        /* GetX<RequestController>(
          //init: Get.put<RequestController>(RequestController()),
          builder: (RequestController controller) {
            return ListView.builder(
              itemCount: controller.requestList.length,
              itemBuilder: ((_, index) {
                // IconData iconData = Icons.question_mark;
                // Color iconColor = Colors.black;
                // switch (item.category) {
                //   case "Work":
                //     iconData = Icons.work;
                //     break;
                //   case "Errands":
                //     iconData = Icons.directions_walk_outlined;
                //     break;
                //   case "Housework":
                //     iconData = Icons.house;
                //     break;
                //   case "Grocery":
                //     iconData = Icons.local_grocery_store;
                //     break;
                //   case "GYM":
                //     iconData = Icons.fitness_center;
                //     break;
                //   case "School":
                //     iconData = Icons.school;
                //     break;
                //   default:
                //     iconData = Icons.question_mark;
                //     iconColor = Colors.white;
                // }

                // switch (item.type) {
                //   case "Срочная":
                //     iconColor = Colors.red;
                //     break;
                //   case "Обычная":
                //     iconColor = Colors.black;
                //     break;

                //   default:
                //     iconColor = Colors.white;
                // }

                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (builder) => ViewReqDataPage(
                    //       document: document,
                    //       id: controller.requests[index].toString(),
                    //     ),
                    //   ),
                    // );
                  },
                  child: RequestView(request: controller.requestList[index]),
                );
              }),
            );
          },
        ), */
      ),
    );
  }

// Кнопка добавления заявки
  Widget addRequestButton() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.addRequestScreen);
      },
      child: Container(
        height: 50.h,
        width: 52.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xffff9999),
              Color(0xffff5050),
              Color(0xffff4500),
            ],
          ),
        ),
        child: Icon(
          size: 32,
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

// Функция отображения сведений о заявке в списке домашней страницы
  SizedBox requestShow() {
    return SizedBox(
      //height: 100,
      child: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ctrl.requestList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (_) {
                Request? removed = ctrl.requestList[index];
                ctrl.requestList.removeAt(index);
                Get.snackbar('ВНИМАНИЕ', 'Заявка "${removed.title}" удалена.',
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 8),
                    mainButton: TextButton(
                      child: Text('Восстановить',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 201, 202, 202))),
                      onPressed: () {
                        if (removed.isNull) {
                          return;
                        }
                        ctrl.requestList.insert(index, removed!);
                        removed = null;
                        if (Get.isSnackbarOpen) {
                          Get.back();
                        }
                      },
                    ));
              },
              child: GestureDetector(
                onTap: () {
                  // Get.toNamed(Routes.requestScreen, arguments: [
                  //   {
                  //     "id": homeController.requestList[index].id.toString(),
                  //   }
                  //]
                  //);
                },
                child: HomeRequestCard(
                  requestItem: ctrl.requestList[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


/*TodoCard(
                title: "Wake Up",
                check: true,
                time: "11 PM",
                iconBgColor: Colors.white,
                iconColor: Colors.black,
                iconData: Icons.alarm,
              );*/

/*IconButton(
          icon: Icon(
            Icons.logout,
          ),
          onPressed: () async {
            authClass.logOut(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => SignInPage()),
                (route) => false);
          },
        ),*/

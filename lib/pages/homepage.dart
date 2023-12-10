// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
//import 'package:requester/custom/todoCard.dart';
import 'package:requester/models/request.dart';
import 'package:requester/pages/addRequest.dart';
import 'package:requester/pages/signin.dart';
//import 'package:requester/pages/viewdata.dart';
import 'package:requester/pages/viewReqDataPage.dart';
import 'package:requester/service/google_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  // final Stream<QuerySnapshot> _stream =
  //     FirebaseFirestore.instance.collection("Todo").snapshots();
  final Stream<QuerySnapshot> _req_stream =
      FirebaseFirestore.instance.collection("Request").snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
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
                    DateTime.now().format('D d-m-Y'),
                    style: TextStyle(color: Colors.white, fontFamily: 'Anton'),
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AddRequestPage()));
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
        ),
        body: StreamBuilder<dynamic>(
          stream: _req_stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: ((context, index) {
                IconData iconData = Icons.question_mark;
                Color iconColor = Colors.black;
                Map<String, dynamic> document =
                    snapshot.data.docs[index].data() as Map<String, dynamic>;
                switch (document["category"]) {
                  case "Work":
                    iconData = Icons.work;

                    break;
                  case "Errands":
                    iconData = Icons.directions_walk_outlined;

                    break;
                  case "Housework":
                    iconData = Icons.house;

                    break;
                  case "Grocery":
                    iconData = Icons.local_grocery_store;

                    break;
                  case "GYM":
                    iconData = Icons.fitness_center;

                    break;
                  case "School":
                    iconData = Icons.school;

                    break;
                  default:
                    iconData = Icons.question_mark;
                    iconColor = Colors.white;
                }
                switch (document["type"]) {
                  case "Important":
                    iconColor = Colors.red;
                    break;
                  case "Planned":
                    iconColor = Colors.black;
                    break;

                  default:
                    iconColor = Colors.white;
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //builder: (builder) => ViewDataPage(
                        builder: (builder) => ViewReqDataPage(
                          document: document,
                          id: snapshot.data.docs[index].id,
                        ),
                      ),
                    );
                  },
                  child: Request(
                    title: document["title"] == null
                        ? "Title is Empty"
                        : document["title"],
                    isExecute: document["isExecute"],
                    category: document["category"],
                    description: document["description"],
                    type: document["type"],
                    summa: document["summa"].toDouble(),
                    stavka: document["stavka"],
                    inn: document["inn"].toInt(),
                    isNDS: document["isNDS"],
                    paydate: document["paydate"].toDate(),
                    returndate: document["returndate"].toDate(),
                  ),
                );
              }),
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

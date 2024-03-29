//import 'package:ecommerce_app/view/widgets/home/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:requester/widgets/textField.dart';

import '../../../routes/routes.dart';

class AppBarItem extends StatelessWidget {
  const AppBarItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (() {
              //Get.toNamed(Routes.searchScreen);
            }),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: HomeTextField(),
            ),
          ),
        ),
        GestureDetector(
          onTap: (() {
            //Get.toNamed(Routes.notificatonScreen);
          }),
          child: Padding(
            padding: Get.locale?.languageCode == 'ru'
                ? EdgeInsets.only(right: 10.w, left: 0)
                : EdgeInsets.only(right: 0, left: 10.w),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 30,
              // color: Get.isDarkMode?Colors.white:Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

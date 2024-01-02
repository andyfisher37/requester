// ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'package:ecommerce_app/routes/routes.dart';
// import 'package:ecommerce_app/view/widgets/settings/rowWithSwitchTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/settings_controller.dart';

// import '../../../logic/controllers/auth_controllers.dart';
import 'package:requester/utils/theme.dart';
// import '../../widgets/settings/csutomCard.dart';
// import '../../widgets/settings/dropdownMenuItemLanguage.dart';
// import '../../widgets/settings/rowWithSwitchNotification.dart';
// import '../../widgets/settings/rowWithoutSwitchPassword.dart';
// import '../../widgets/settings/rowWithoutSwitchProfile.dart';
// import '../../widgets/settings/userDetails.dart';
// import '../../widgets/textWithFont.dart';
import 'dart:math' as math;

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final settingController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Настройки',
            style: TextStyle(fontFamily: 'Lobster'),
          ),
          centerTitle: true,
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        SizedBox(width: 10),
                        Text('Выход')
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(
                          Icons.cleaning_services_outlined,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        SizedBox(width: 10),
                        Text('Сбросить...')
                      ],
                    ),
                  )
                ],
                onChanged: (value) {
                  // ClearSettings();
                },
              ),
            ),
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Placeholder(),
              Placeholder(),
              Placeholder(),
            ],
          ),
        ),
      ),
    );

    /* Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            UserDetails(
              settingsController: settingController,
            ),
            SizedBox(
              height: 15.h,
            ),
            CsutomCard(),
            SizedBox(
              height: 15.h,
            ),
            Card(
              color: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
                child: Column(
                  children: [
                    RowWithoutSwitchProfile(
                      text: 'Manage Profile'.tr,
                      icon: Icons.person_outline,
                      paddingSize: 0,
                      sizedBoxWidth: 120.w,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowWithoutSwitchPassword(
                      text: 'Change Password'.tr,
                      icon: Icons.lock_outline,
                      paddingSize: 0,
                      sizedBoxWidth:
                          Get.locale!.languageCode == 'en' ? 100.w : 124.w,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowWithSwitchNotification(
                      text: 'Notification'.tr,
                      icon: Icons.notifications_none_outlined,
                      paddingSize: 110.w,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    DropdownMenuItemLanguage(),
                    SizedBox(
                      height: 5.h,
                    ),
                    RowWithSwitchTheme(
                      text: 'Theme Mode'.tr,
                      icon: Icons.color_lens_outlined,
                      paddingSize: 100.w,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('logout');
                        settingController.logout();
                      },
                      child: ListTile(
                        leading: Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child: Icon(
                              Icons.logout_outlined,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            )),
                        title: TextWithFont().textWithRobotoFont(
                          text: 'Logout'.tr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ); */
  }
}

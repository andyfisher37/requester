//import 'package:ecommerce_app/logic/controllers/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:requester/controllers/connection_manager_controller.dart';
//import '../../locale/locale.dart';
//import 'package:requester/controllers/category_controller.dart';
import 'package:requester/controllers/main_controller.dart';
import 'package:requester/utils/theme.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  //final controller = Get.find<MyLocaleController>();

  final mainController = Get.find<MainController>();
  // final categoryController = Get.find<CategoryController>();
  // final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // HomeServices.viewHomeRestaurants;
    // context.theme.appBarTheme

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          systemNavigationBarColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
          statusBarColor: Theme.of(context).textTheme.headline2!.color),
    );
    return SafeArea(
      child: Obx(
        () {
          return _controller.connectionType.value == 1
              ? Scaffold(
                  body: PersistentTabView(
                    context,
                    controller: mainController.controller.value,
                    screens: mainController.tabs,
                    backgroundColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor!,
                    items: mainController.navBarsItems(),
                    confineInSafeArea: true,
                    handleAndroidBackButtonPress: true,
                    resizeToAvoidBottomInset: true,
                    stateManagement: true,
                    hideNavigationBarWhenKeyboardShows: true,
                    decoration: NavBarDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      colorBehindNavBar: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                    ),
                    popAllScreensOnTapOfSelectedTab: true,
                    popActionScreens: PopActionScreensType.all,
                    itemAnimationProperties: const ItemAnimationProperties(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease,
                    ),
                    screenTransitionAnimation: const ScreenTransitionAnimation(
                      animateTabTransition: true,
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 200),
                    ),
                    navBarStyle: NavBarStyle.style3,
                    padding: NavBarPadding.only(top: 5),
                  ),
                )
              : const Scaffold(
                  body: Center(
                    child: Text('Нет соединения с Интернетом...'),
                  ),
                );
        },
      ),
    );
  }
}

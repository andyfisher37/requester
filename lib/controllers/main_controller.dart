import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:requester/screens/archive_screen.dart';
import 'package:requester/screens/chat_screen.dart';
import 'package:requester/screens/home_screen.dart';
import 'package:requester/screens/settings_screen.dart';
import '../../utils/theme.dart';
// import '../../view/screens/cart/cart_screen.dart';
// import '../../view/screens/favorites_screen.dart';

class MainController extends GetxController {
  // ignore: prefer_final_fields
  Rx<PersistentTabController> controller =
      PersistentTabController(initialIndex: 0).obs;
      
  var tabs = [
    HomeScreen(),
    ChatScreen(), // CartScreen(),
    ArchiveScreen(), // FavoritesScreen(),
    SettingsScreen(),
  ].obs;

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: 'Домой',
        activeColorPrimary: mainColor,
        inactiveColorPrimary: Get.isDarkMode ? Colors.white : Colors.black,
        inactiveColorSecondary: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.chat,
        ),
        title: 'Чат',
        activeColorPrimary: mainColor,
        inactiveColorPrimary: Get.isDarkMode ? Colors.white : Colors.black,
        inactiveColorSecondary: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.archive,
        ),
        title: 'Архив',
        activeColorPrimary: mainColor,
        inactiveColorPrimary: Get.isDarkMode ? Colors.white : Colors.black,
        inactiveColorSecondary: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.settings_outlined,
        ),
        title: 'Настройки',
        activeColorPrimary: mainColor,
        inactiveColorPrimary: Get.isDarkMode ? Colors.white : Colors.black,
        inactiveColorSecondary: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    ];
  }
}

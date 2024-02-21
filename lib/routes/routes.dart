import 'package:get/get.dart';
import 'package:requester/bindings/archive_bindings.dart';
import 'package:requester/bindings/chat_bindings.dart';
import 'package:requester/bindings/details_request_bindings.dart';
import 'package:requester/bindings/home_bindings.dart';
import 'package:requester/bindings/main_bindings.dart';
import 'package:requester/bindings/onBoarding_home_bindings.dart';
import 'package:requester/bindings/search_bindings.dart';
import 'package:requester/bindings/settings_bindings.dart';
import 'package:requester/screens/auth/login_screen.dart';
import 'package:requester/screens/auth/register_screen.dart';
import 'package:requester/screens/chat/chat_screen.dart';
import 'package:requester/screens/request/add_request_screen.dart';
import 'package:requester/screens/home/home_screen.dart';
import 'package:requester/screens/main_screen.dart';
import 'package:requester/screens/request/details_request_screen.dart';
import 'package:requester/screens/search/search_screen.dart';
import 'package:requester/screens/settings/settings_screen.dart';

import '../screens/splash_screen.dart';

class AppRoutes {
  static const splashScreen = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.chatScreen,
      page: () => ChatScreen(),
      binding: ChatBindings(),
    ),
    GetPage(
      name: Routes.registerScreen,
      page: () => RegisterScreen(),
    ),
    GetPage(
        name: Routes.loginScreen,
        page: () => LoginScreen(),
        ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [
        MainBindings(),
        ChatBindings(),
        OnBoardingHomeBinding(),
        SettingsBindings(),
        HomeBindings(),
        ArchiveBindings(),
      ],
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: OnBoardingHomeBinding(),
    ),
    GetPage(
        name: Routes.settingsScreen,
        page: () => SettingsScreen(),
        binding: SettingsBindings()),
    GetPage(
        name: Routes.detailsRequestScreen,
        page: () => DetailsRequestScreen(),
        bindings: [
          DetailsRequestBindings(),
        ]),
        GetPage(
        name: Routes.searchScreen,
        page: () => SearchScreen(),
        bindings: [
          SearchBindings(),
        ]),
    GetPage(
      name: Routes.addRequestScreen,
      page: () => AddRequestScreen(),
    ),
    GetPage(
      name: Routes.notificatonScreen,
      page: () => AddRequestScreen(),
    ),
  ];
}

class Routes {
  static const onBoardingScreen = '/onBoardingScreen';
  static const loginScreen = '/loginScreen';
  static const registerScreen = '/registerScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const sendOTPScreen = '/sendOTPScreen';
  static const newPwScreen = '/newPwScreen';
  static const mainScreen = '/mainScreen';
  static const chatScreen = '/chatScreen';
  static const splashScreen = '/splashScreen';
  static const homeScreen = '/homeScreen';
  static const searchScreen = '/searchScreen';
  static const filterScreen = '/filterScreen';
  static const detailsRequestScreen = '/detailRequestScreen';
  static const settingsScreen = '/settingsScreen';
  static const profileSetting = '/profileSetting';
  static const restPasswordScreen = '/restPasswordScreen';
  static const notificatonScreen = '/notificatonScreen';
  static const categoryScreen = '/categoryScreen';
  static const checkoutScreen = '/checkoutScreen';
  static const addRequestScreen = '/addRequestScreen';
  static const updatePassword = '/changePassword';
}

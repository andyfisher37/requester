import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:requester/bindings/controller_binding.dart';
import 'package:requester/controllers/archive_controller.dart';
import 'package:requester/controllers/auth_controller.dart';
import 'package:requester/controllers/chat_controller.dart';
import 'package:requester/controllers/connection_manager_controller.dart';
import 'package:requester/controllers/home_controllers.dart';
import 'package:requester/controllers/main_controller.dart';
import 'package:requester/controllers/request_controller.dart';
import 'package:requester/controllers/settings_controller.dart';
import 'package:requester/controllers/theme_controller.dart';
import 'package:requester/routes/routes.dart';
//import 'package:requester/pages/signup.dart';
//import 'package:requester/service/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:requester/utils/shared_prefs.dart';
import 'package:requester/utils/theme.dart';
import 'package:requester/utils/firebase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) => Get.put(AuthController()));
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    Get.put(ConnectionManagerController());
    Get.put(ChatController());
    Get.put(SettingsController());
    Get.put(ArchiveController());
    Get.put(MainController());
    Get.put(RequestController());
    Get.put(HomeController());

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          //home: SplashScreen(),
          initialBinding: ControllerBinding(),
          locale: SharedPrefs.instance.getString("curruntLang") == null
              ? Get.deviceLocale
              : Locale(SharedPrefs.instance.getString("curruntLang")!),
          initialRoute: SharedPrefs.instance.getString('token') != null
              ? Routes.mainScreen
              : AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          theme: ThemesApp.dark,
          darkTheme: ThemesApp.light,
          themeMode: ThemeController().themeDataGet,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

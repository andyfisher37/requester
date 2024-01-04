import 'package:get/get.dart';
import 'package:requester/bindings/request_bindings.dart';
import 'package:requester/bindings/main_bindings.dart';
import 'package:requester/bindings/onBoarding_home_bindings.dart';
import 'package:requester/bindings/settings_bindings.dart';
import 'package:requester/screens/request/add_request_screen.dart';
import 'package:requester/screens/home/home_screen.dart';
import 'package:requester/screens/main_screen.dart';
import 'package:requester/screens/settings/settings_screen.dart';

import '../screens/splash_screen.dart';

class AppRoutes {
  
  static const splashScreen = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    /* GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
        name: Routes.onBoardingScreen,
        page: () => OnBoardingScreen(),
        bindings: [
          OnBoardingBinding(),
        ]),
    GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      binding: AuthBindings(),
    ), */
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [
        // AuthBindings(),
        // MyLocaleBindings(),
        MainBindings(),
        // FavoritesBindings(),
        OnBoardingHomeBinding(),
        SettingsBindings(),
        // CategotyBindings(),
        HomeBindings(),
      ],
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: OnBoardingHomeBinding(),
    ),
    // GetPage(
    //   name: Routes.sendOTPScreen,
    //   page: () => SendOTPScreen(),
    //   binding: AuthBindings(),
    // ),
    // GetPage(
    //   name: Routes.newPwScreen,
    //   page: () => NewPwScreen(),
    // ),
    // GetPage(
    //   name: Routes.cartScreen,
    //   page: () => CartScreen(),
    //   // binding:  CartBindings(),
    // ),
    // GetPage(
    //     name: Routes.searchScreen,
    //     page: () => SearchScreen(),
    //     binding: SearchBindings()),
    // GetPage(
    //   name: Routes.filterScreen,
    //   page: () => FilterScreen(),
    // ),
    GetPage(
        name: Routes.settingsScreen,
        page: () => SettingsScreen(),
        binding: SettingsBindings()),
    // GetPage(
    //     name: Routes.profileSetting,
    //     page: () => ProfileSetting(),
    //     binding: ProfileSettingBinding()),
    // GetPage(
    //   name: Routes.restPasswordScreen,
    //   page: () => RestPasswordScreen(),
    // ),
    // GetPage(
    //   name: Routes.notificatonScreen,
    //   page: () => NotificatonScreen(),
    // ),
    // GetPage(
    //     name: Routes.categoryScreen,
    //     page: () => CategoryScreen(),
    //     binding: ResturantBinding()),
    // GetPage(
    //     name: Routes.resturantScreen,
    //     page: () => ResturantScreen(),
    //     binding: ResturantBageBinding()),
    // GetPage(
    //   name: Routes.myOrdersScreen,
    //   page: () => MyOrdersScreen(),
    // ),
    // GetPage(
    //   name: Routes.foodScreen,
    //   page: () => FoodScreen(),
    // ),

    // GetPage(
    //     name: Routes.productDetailsScreen,
    //     page: () => ProductDetailsScreen(),
    //     bindings: [
    //       ProductDetailsBindings(),
    //       FavoritesBindings(),
    //     ]),
    // GetPage(
    //   name: Routes.checkoutScreen,
    //   page: () => CheckoutScreen(),
    //   binding: CheckoutBindings()
    // ),
    // GetPage(
    //     name: Routes.changeAddressScreen,
    //     page: () => ChangeAddressScreen(),
    //     binding: AddressBindings()),
    // GetPage(
    //     name: Routes.allReviewScreen,
    //     page: () => AllReviewScreen(),
    //     binding: RreviewProductBinding()),

    // GetPage(
    //   name: Routes.writeReviewScreen,
    //   page: () => WriteReviewScreen(),
    // ),
    // GetPage(
    //     name: Routes.allFoodScreen,
    //     page: () => AllFoodScreen(),
    //     binding: FodeBindings()),
    GetPage(
      name: Routes.addRequestScreen,
      page: () => AddRequestScreen(),
    ),
    // GetPage(
    //   name: Routes.updatePassword,
    //   page: () => UpdatePassword(),
    // ),
  ];
}

class Routes {
  static const onBoardingScreen = '/onBoardingScreen';

  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const sendOTPScreen = '/sendOTPScreen';
  static const newPwScreen = '/newPwScreen';

  static const mainScreen = '/mainScreen';
  static const cartScreen = '/cartScreen';
  static const splashScreen = '/splashScreen';
  static const homeScreen = '/homeScreen';
  static const searchScreen = '/searchScreen';
  static const filterScreen = '/filterScreen';
  static const favoritesScreen = '/favoritesScreen';
  static const settingsScreen = '/settingsScreen';
  static const profileSetting = '/profileSetting';
  static const restPasswordScreen = '/restPasswordScreen';
  static const notificatonScreen = '/notificatonScreen';
  static const categoryScreen = '/categoryScreen';
  static const resturantScreen = '/resturantScreen';
  static const myOrdersScreen = '/myOrdersScreen';
  static const foodScreen = '/foodScreen';
  static const productDetailsScreen = '/productDetailsScreen';

  static const checkoutScreen = '/checkoutScreen';

  static const changeAddressScreen = '/changeAddressScreen';

  static const allReviewScreen = '/allReviewScreen';
  static const writeReviewScreen = '/writeReviewScreen';
  static const allFoodScreen = '/allFoodScreen';

  static const addRequestScreen = '/addRequestScreen';

  static const updatePassword = '/changePassword';

  // ForgotPasswordCodeScreen

  // OnBoarding
}
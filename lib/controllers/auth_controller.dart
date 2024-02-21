import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:requester/screens/auth/login_screen.dart';
import 'package:requester/screens/auth/register_screen.dart';
import 'package:requester/screens/main_screen.dart';
import 'package:requester/utils/firebase_constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // Если пользователь НЕ залогинился
      Get.offAll(() => const LoginScreen());
    } else {
      // Если пользователь залогинился
      Get.offAll(() => MainScreen());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // Если пользователь НЕ залогинился
      Get.offAll(() => const LoginScreen());
    } else {
      // Если пользователь залогинился
      Get.offAll(() => MainScreen());
    }
  }

 // Атворизация по учетке Google
  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Ошибка авторизации",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  // Регистрация нового пользователя по (почте/паролю)
  Future<UserCredential?> register(String email, password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {
      print(firebaseAuthException.toString());
    }
    return null;
  }

  // Вход по email и паролю
  Future<UserCredential?> login(String email, password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {
      print(firebaseAuthException.toString());
    }
    return null;
  }

  // Выход из профиля
  void signOut() async {
    await auth.signOut();
  }
}

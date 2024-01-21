// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last, avoid_unnecessary_containers, prefer_final_fields, unused_field, avoid_print

import 'package:requester/screens/home/home_screen.dart';
import 'package:requester/screens/auth/phone_auth_screen.dart';
import 'package:requester/screens/auth/login_screen.dart';
import 'package:requester/services/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:requester/utils/firebase_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Регистрация\nнового пользователя',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Lobster',
                      fontWeight: FontWeight.w500),
                ),
                Divider(
                  color: Colors.grey.shade800,
                  thickness: 2,
                  endIndent: 35,
                  indent: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                textField("Почта (e-mail)", _emailController, false),
                SizedBox(
                  height: 20,
                ),
                textField("Пароль", _passwordController, true),
                SizedBox(
                  height: 20,
                ),
                textFieldRepeat("Повторите пароль", true),
                SizedBox(
                  height: 20,
                ),
                signUpButton(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'или',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                googleContainer(() async {
                  await authClass.googleSignIn(context);
                }),
                phoneContainer(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => PhoneAuthScreen()));
                }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Если у Вас уже есть регистрация,',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => LoginScreen()),
                            (route) => false);
                      },
                      child: Text(
                        'Войти,',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

  Widget textField(
      String text, TextEditingController controller, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        style:
            TextStyle(color: Colors.white, backgroundColor: Colors.transparent),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(
            text,
            style: TextStyle(
                color: Colors.white, backgroundColor: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }

  Widget textFieldRepeat(String text, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        style:
            TextStyle(color: Colors.white, backgroundColor: Colors.transparent),
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(
            text,
            style: TextStyle(
                color: Colors.white, backgroundColor: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }

  Widget googleContainer(Function()? onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/google.svg",
                height: 30,
                width: 25,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Войти с учетной записью Google',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneContainer(Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/phone.svg",
                height: 30,
                width: 25,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Войти по номеру телефона',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential? userCredential =
              await authController.register(_emailController.text.trim(),
                  _passwordController.text.trim());
          print(userCredential!.user!.email);
          setState(() {
            circular = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomeScreen()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 60,
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                  "Регистрация",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Color(0xffff9999),
              Color(0xffff5050),
              Color(0xffff4500),
            ],
          ),
        ),
      ),
    );
  }
}

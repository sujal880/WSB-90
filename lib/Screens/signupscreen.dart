import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wsb_90_firebase/Widgets/uihelper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Enter Email", Icons.mail),
          UiHelper.CustomTextField(
              passwordController, "Enter Password", Icons.password),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {
            signUp(emailController.text.toString(), passwordController.text.toString());
          }, child: Text("Sign Up"))
        ],
      ),
    );
  }

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      return UiHelper.CustomAlertBox("Enter Required Field's", context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          return UiHelper.CustomAlertBox("User Created", context);
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomAlertBox(ex.code.toString(), context);
      }
    }
  }
}

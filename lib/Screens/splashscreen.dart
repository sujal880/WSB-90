import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wsb_90_firebase/Screens/homescreen.dart';
import 'package:wsb_90_firebase/Screens/signinscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      checkuser();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.chat,size: 100,),),
    );
  }
  checkuser(){
    if(FirebaseAuth.instance.currentUser!=null){
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else{
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));

    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wsb_90_firebase/Screens/homescreen.dart';
import 'package:wsb_90_firebase/Widgets/uihelper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextField(emailController,"Enter Email", Icons.mail),
        UiHelper.CustomTextField(passwordController,"Enter Password", Icons.password),
        SizedBox(height: 20),
        ElevatedButton(onPressed: (){
          signIn(emailController.text.toString(), passwordController.text.toString());
        }, child: Text("Sign In"))
      ],),
    );
  }
  signIn(String email,String password)async{
    if(email=="" && password==""){
      return UiHelper.CustomAlertBox("Enter Required Fields", context);
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        });
      }
      on FirebaseAuthException catch(ex){
        return UiHelper.CustomAlertBox(ex.code.toString(), context);
      }

    }
  }
}

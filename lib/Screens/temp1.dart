import 'package:flutter/material.dart';
import 'package:wsb_90_firebase/Screens/temp2.dart';
class Temp1 extends StatelessWidget {
  const Temp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Temp2()));
      }, child: Text("Move")),)
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{
  static CustomTextField(TextEditingController controller,String text,IconData iconData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2)
          )
        ),
      ),
    );
  }
  static CustomAlertBox(String text,BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Ok"))
        ],
      );
    });
  }
}
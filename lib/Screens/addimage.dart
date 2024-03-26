import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wsb_90_firebase/Widgets/uihelper.dart';

class AddImages extends StatefulWidget {
  const AddImages({super.key});

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  File? pickedImage;
  TextEditingController usernameController=TextEditingController();

  upload(String name){
    if(name=="" && pickedImage==null){
      return UiHelper.CustomAlertBox("Enter Required Field's", context);
    }
    else{
      UploadImage();
    }
  }

  UploadImage()async{
    UploadTask uploadTask=FirebaseStorage.instance.ref("Profile Pictures").child(usernameController.text.toString()).putFile(pickedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String imageurl=await taskSnapshot.ref.getDownloadURL();
    String name=usernameController.text.toString();

    FirebaseFirestore.instance.collection("Photos").doc(FirebaseAuth.instance.currentUser.toString()).set({
      "Image":imageurl,
      "Name":FirebaseAuth.instance.currentUser.toString()
    }).then((value){
      return UiHelper.CustomAlertBox("Image Uploaded", context);
    });
  }

  _showDilaog(){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Pick Image From"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          ListTile(
            onTap: (){
              _pickImage(ImageSource.camera);
            },
            leading: Icon(Icons.camera_alt),
            title: Text("Camera"),
          ),
          ListTile(
            onTap: (){
              _pickImage(ImageSource.gallery);
            },
            leading: Icon(Icons.image),
            title: Text("Gallery"),
          )
        ],),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Images"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              _showDilaog();
            },
            child:pickedImage!=null? CircleAvatar(
              radius: 60,
              backgroundImage: FileImage(pickedImage!),
            ):CircleAvatar(
              radius: 60,
              child: Icon(Icons.person,size: 60,),
            ),
          ),
          SizedBox(height: 20),
          UiHelper.CustomTextField(usernameController,"Enter Username", Icons.person),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            upload(usernameController.text.toString());
          }, child: Text("Upload"))
        ],
      ),
    );
  }
  _pickImage(ImageSource imageSource)async{
    try{
      final photo=await ImagePicker().pickImage(source: imageSource);
      if(photo==null)return;
      final tempImage=File(photo.path);
      setState(() {
        pickedImage=tempImage;
      });
    }
    catch(ex){
      return UiHelper.CustomAlertBox(ex.toString(), context);
    }
  }
}

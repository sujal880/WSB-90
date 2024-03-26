import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wsb_90_firebase/Screens/fetchdata.dart';
import 'package:wsb_90_firebase/Widgets/uihelper.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  addData(String title, String desc) async {
    if (title == "" && desc == "") {
      return UiHelper.CustomAlertBox("Enter Required Field's", context);
    } else {
      FirebaseFirestore.instance
          .collection("Notes")
          .doc(title)
          .set({"Title": title, "Description": desc}).then((value) {
        return Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(titleController, "Enter Title", Icons.title),
          UiHelper.CustomTextField(
              descController, "Enter Description", Icons.description),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                addData(titleController.text.toString(),
                    descController.text.toString());
              },
              child: Text("Add Data"))
        ],
      ),
    );
  }
}

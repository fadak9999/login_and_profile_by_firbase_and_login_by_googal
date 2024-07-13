// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginandprofilinfirbase/Firestore/EditFirebase.dart';
import 'package:loginandprofilinfirbase/sub/home_sub.dart';

// ignore: camel_case_types
class gridview_in_home_nav extends StatefulWidget {
  const gridview_in_home_nav({super.key});

  @override
  State<gridview_in_home_nav> createState() => _gridview_in_home_navState();
}

// ignore: camel_case_types
class _gridview_in_home_navState extends State<gridview_in_home_nav> {
//////////////////////////

  late List<Map<String, dynamic>> data = [];
  //////////////////////////////

  @override
  void initState() {
    getData();
    super.initState();
  }

//////////////////////___________     getData     ______________/////////////////////////////////////////////////

  Future<void> getData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        data = querySnapshot.docs.map((doc) {
          var docData = doc.data() as Map<String, dynamic>;
          docData['id'] = doc.id;
          return docData;
        }).toList();
      });
    } catch (e) {
      print("Error getting data: $e");
    }
  }

////////////////////////_______deleteInFirebase_________//////////////////////////////////////////
  Future<void> deleteInFirebase(int i) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(data[i]['id'])
          .delete();
      setState(() {
        data.removeAt(i);
      });
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

/////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 113, 186, 210),
                Color.fromARGB(255, 161, 54, 232)
              ])),
          child: GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => home_sub(
                              docid: data[i]['id'],
                              name_appbar: data[i]["name"],
                            )));
                  },
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.bottomSlide,
                      title: "What do you want to choose?",
                      btnOkText: "Edit",
                      btnCancelText: "Delete",
                      btnOkOnPress: () {
                        /////
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditFirebase(
                                docid: data[i]['id'],
                                Oldname: data[i]["name"])));
                        ////
                      },
                      btnCancelOnPress: () {
                        deleteInFirebase(i);
                      },
                    ).show();
                    ////
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color.fromARGB(255, 161, 54, 232),
                            Color.fromARGB(255, 211, 217, 219),
                          ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Center(child: Text("${data[i]['name']}"))],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

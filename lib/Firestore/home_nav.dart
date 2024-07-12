// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loginandprofilinfirbase/class_nav/gridview_in_home_nav.dart';
import 'package:loginandprofilinfirbase/Firestore/AddFirebase.dart';

// ignore: camel_case_types
class Home_nav extends StatefulWidget {
  const Home_nav({super.key});

  @override
  State<Home_nav> createState() => _HomeState();
}

class _HomeState extends State<Home_nav> {
  ///////////////

  late List<Map<String, dynamic>> data = [];
  /////////////////
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

///////////////////////_________task_____//////////////////////////////////////////

  Widget task() {
    if (data.isEmpty) {
      return const Center(
        child: Text(
          "it's empty",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else {
      return const gridview_in_home_nav();
    }
  }

////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Get.to(const AddFirebase());
        },
        child: const Icon(
          Icons.add,
          color: Colors.purple,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 113, 186, 210),
              Color.fromARGB(255, 161, 54, 232)
            ])),
        child: task(),
      ),
    );
  }
}

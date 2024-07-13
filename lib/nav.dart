import 'package:flutter/material.dart';
import 'package:loginandprofilinfirbase/Firestore/AddFirebase.dart';
import 'package:loginandprofilinfirbase/Firestore/home_nav.dart';
import 'package:loginandprofilinfirbase/Firestore/profil_nav.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  //

  int currentIndexH = 0;
  List<Widget> bodyteyAPP = [
    const Home_nav(),
    const profile_nave(),

    const AddFirebase(),
    //const EditFirebase(),
  ];

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        drawer: const Drawer(),

        body: Center(
          child: bodyteyAPP[(currentIndexH)],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndexH,
            onTap: (int newindex) {
              setState(() {
                currentIndexH = newindex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  label: "HOME",
                  icon: Icon(Icons.home),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),
              ///////////////////////////
              BottomNavigationBarItem(
                  label: "person",
                  icon: Icon(Icons.person),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),

              /*  BottomNavigationBarItem(
                  label: "pets",
                  icon: Icon(Icons.pets),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),
                  */
              BottomNavigationBarItem(
                  label: "Add",
                  icon: Icon(Icons.add),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),
            ]),

        ///
      ),
    );
  }
}

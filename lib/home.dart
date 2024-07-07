import 'package:flutter/material.dart';
import 'package:loginandprofilinfirbase/pagesnav/add_nav.dart';
import 'package:loginandprofilinfirbase/pagesnav/home_nav.dart';
import 'package:loginandprofilinfirbase/pagesnav/profil_nav.dart';
import 'package:loginandprofilinfirbase/pagesnav/search_nav.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //

  int currentIndexH = 0;
  List<Widget> bodyteyAPP = [
    profile_nave(),
    home_nav(),
    add_nav(),
    search_nav(),
  ];

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(),

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
                  label: "person",
                  icon: Icon(Icons.person),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),
              BottomNavigationBarItem(
                  label: "HOME",
                  icon: Icon(Icons.home),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),
              ///////////////////////////

              /*  BottomNavigationBarItem(
                  label: "pets",
                  icon: Icon(Icons.pets),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),
                  */
              BottomNavigationBarItem(
                  label: "Add",
                  icon: Icon(Icons.add),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0)),
              BottomNavigationBarItem(
                  label: "Search",
                  icon: Icon(Icons.search),
                  backgroundColor: Colors.black),
            ]),

        ///
      ),
    );
  }
}

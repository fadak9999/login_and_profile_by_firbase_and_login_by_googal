import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginandprofilinfirbase/edeit_class/edit2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class profile_nave extends StatefulWidget {
  const profile_nave({super.key});

  @override
  State<profile_nave> createState() => _home_naveState();
}

// ignore: camel_case_types
class _home_naveState extends State<profile_nave> {
  /////

  final myAcount = FirebaseAuth.instance.currentUser!;
  File? _selectimage;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    get_data_in_device();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 5, 49),
        title: const Center(
          child: Text(
            "~ edit profile ~            ",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 248, 246, 248),
                  Color.fromARGB(255, 91, 7, 193)
                ]),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(right: 200),
                child: TextButton(
                    onPressed: () {
                      //g
              
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.disconnect();
              
                      ///
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text("sign Out")),
              )
            ],
          ),
        ),
      ),
      //

      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///////
                const SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  //1
                  Container(
                    margin: const EdgeInsets.only(left: 150),
                    height: 200,
                    width: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            tileMode: TileMode.clamp,
                            begin: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(255, 151, 2, 210),
                              Color.fromARGB(255, 17, 0, 21)
                            ]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100))),
                  ),

                  ///2
                  Container(
                    margin: const EdgeInsets.only(left: 170, top: 20),
                    child: Stack(children: [
                      Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.black)),
                          child: _selectimage != null // الشرط
                              ? CircleAvatar(
                                  radius: 100,
                                  backgroundImage: FileImage(
                                      _selectimage!), // الشرط الي يتحقق
                                )
                              : const Center(child: Text("add imag"))
                          /*    CircleAvatar(
                                radius: 80,
                                child: Image.asset(
                                  // اذا ما تحقق الشرط
                                  "assets/two.png",
                                  height: 200,
                                ),
                              ),
                              */
                          ),

                      //علامة الزائد قرب الصورة

                      Positioned(
                        //علامة الزائد قرب الصورة
                        bottom: 0,
                      
                        right: 10,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 7, 12),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor:
                                      const Color.fromARGB(255, 221, 214, 214),
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 300,
                                      width: double.infinity,
                                      child: Expanded(
                                          child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Center(
                                              child: Text(
                                            "Please choose from gallery or camera",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 58, 137, 183),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                getimage_in_gallery();
                                              },
                                              child: const Text(
                                                  "Add image in gallery",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.black))),
                                          const Divider(
                                            height: 20,
                                            color: Color.fromARGB(
                                                255, 147, 152, 154),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                getimage_in_camera();
                                              },
                                              child: const Text(
                                                  "Add image in camera",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))),
                                          const Divider(
                                            height: 20,
                                            color: Color.fromARGB(
                                                255, 147, 152, 154),
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                  border: Border.all(
                                                      color: const Color.fromARGB(
                                                          255, 97, 0, 172))),
                                              child: TextButton(
                                                onPressed: () {
                                                  Delete_data_in_device();
                                                },
                                                child: const Text(
                                                  "Remove image",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 181, 0, 241),
                                                      fontSize: 20),
                                                ),
                                              )),
                                        ],
                                      )),
                                    );
                                  });
                            },
                            icon: const Center(
                              child: Center(
                                child: Icon(Icons.add,
                                    size: 25,
                                    color:
                                        Color.fromARGB(255, 235, 234, 238)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ]),

                ////////////////////
                const SizedBox(height: 50),
                //

                Text(
                  myAcount.email!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 240, 231, 231),
                      fontSize: 15),
                ),

                //////////////////
                const edet2(),

                //////////////////

                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //_______________________________________________________________

  // ignore: non_constant_identifier_names
  Future getimage_in_gallery() async {
    final retunImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (retunImage == null) {
      return;
    }
    setState(() {
      _selectimage = File(retunImage.path);
    });
    save_data_in_device(_selectimage!.path);
  }

  // ignore: non_constant_identifier_names
  Future getimage_in_camera() async {
    final retunImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (retunImage == null) return;
    setState(() {
      _selectimage = File(retunImage.path);
    });
    save_data_in_device(_selectimage!.path);
  }

  // ignore: non_constant_identifier_names
  void save_data_in_device(String svimg) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("save_image", svimg);
    get_data_in_device();
  }

  // ignore: non_constant_identifier_names
  void get_data_in_device() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      imagePath = pref.getString("save_image");
      if (imagePath != null) {
        _selectimage = File(imagePath!);
      }
    });
  }

  // ignore: non_constant_identifier_names
  void Delete_data_in_device() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("save_image");
    setState(() {
      _selectimage = null;
      imagePath = null;
    });
  }
}

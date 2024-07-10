import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class edet2 extends StatefulWidget {
  const edet2({super.key});

  @override
  State<edet2> createState() => _edet2State();
}

// ignore: camel_case_types
class _edet2State extends State<edet2> {
  //

  //final _formKey = GlobalKey<FormState>(); //متغير لدالة التنبيه في النص
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cvController.dispose();
    super.dispose();
  }

//SharedPreferences
  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _cvController.text = prefs.getString('cv') ?? '';
    });
  }

  _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('phone', _phoneController.text);
    prefs.setString('cv', _cvController.text);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data saved successfully')));
  }

  ///
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 30,
    );
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 83, 1, 124),
                      Color.fromARGB(255, 223, 218, 223)
                    ]),
              ),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            //0780
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 83, 1, 124),
                      Color.fromARGB(255, 216, 206, 216)
                    ]),
              ),
              child: TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                //خط احمر في حال الخطا في الحقل
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
            ),
            //cv
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 83, 1, 124),
                      Color.fromARGB(255, 244, 244, 244)
                    ]),
              ),
              child: TextFormField(
                controller: _cvController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Bio';
                  }
                  return null;
                },
              ),
            ),
////////////
            sizedBox,
            Container(
              margin: const EdgeInsets.only(left: 200),
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                    tileMode: TileMode.clamp,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 133, 6, 197),
                      Color.fromARGB(255, 64, 0, 88)
                    ]),
              ),
              child: TextButton(
                  onPressed: () {
                    //  if (_formKey.currentState!.validate()) {
                    _saveData();
                    // }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  )),
            ),

            ///
          ],
        ));
  }
}

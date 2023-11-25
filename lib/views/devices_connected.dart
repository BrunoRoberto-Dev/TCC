import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foco_alternativo/services/authentication.dart';
import 'package:foco_alternativo/views/external_focus.dart';
import 'package:foco_alternativo/views/history.dart';
import 'package:foco_alternativo/views/home_page.dart';
import 'package:foco_alternativo/views/internal_focus.dart';
import 'package:foco_alternativo/views/redefine_password.dart';
import 'package:foco_alternativo/views/timescreen.dart';
import 'package:foco_alternativo/widgets/utils.dart';
import 'package:image_picker/image_picker.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  Uint8List? _image;
  bool quantityHistory = true;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String? email = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Devices Connected",
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('ID: ' + uid!),
                accountEmail: Text('Email: ' + email!),
                currentAccountPicture: _image != null
                    ? CircleAvatar(
                        child: ClipOval(
                          child: Image.memory(
                            _image!,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/anonymous-person.jpg',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile-bg.jpg')),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage())),
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.timer),
                title: Text('Pomodoro'),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimerScreenPomodoro())),
                },
              ),
              ListTile(
                leading: Icon(Icons.center_focus_strong),
                title: Text('External focus'),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimerScreenExternal())),
                },
              ),
              ListTile(
                leading: Icon(Icons.face),
                title: Text('Internal focus'),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimerScreenInternal())),
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.devices),
                title: Text('Connected devices'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Devices())),
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: const Text('Requests'),
                onTap: () => {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Personal History'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History())),
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Redefine password'),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RedefinePassword())),
                },
              ),
              ListTile(
                leading: Icon(Icons.add_a_photo),
                title: Text('Change Picture'),
                onTap: () => {
                  selectImage(),
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Politicies'),
                onTap: () => null,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  AuthService().logoff();
                },
              ),
            ],
          ),
        ),
        body: Column(children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue.shade500,
                    Colors.blue.shade600,
                    Colors.blue.shade900
                  ],
                ),
              ),
              child: Form(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 12, color: Colors.black12),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('DEVICE: (MODEL)',
                                          style: TextStyle(fontSize: 20)),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.exit_to_app,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text('STATUS: (CONNECTED)',
                                      style: TextStyle(fontSize: 20))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 12, color: Colors.black12),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('DEVICE: (MODEL)',
                                          style: TextStyle(fontSize: 20)),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.exit_to_app,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('STATUS: (DISCONNECTED)',
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}

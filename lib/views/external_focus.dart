import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foco_alternativo/services/authentication.dart';
import 'package:foco_alternativo/views/devices_connected.dart';
import 'package:foco_alternativo/views/history.dart';
import 'package:foco_alternativo/views/home_page.dart';
import 'package:foco_alternativo/views/internal_focus.dart';
import 'package:foco_alternativo/views/redefine_password.dart';
import 'package:foco_alternativo/views/timescreen.dart';
import 'package:foco_alternativo/widgets/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:foco_alternativo/timeservice.dart';
import 'package:foco_alternativo/utils.dart';
import 'package:foco_alternativo/widgets/progresswidget.dart';
import 'package:foco_alternativo/widgets/timecontroller.dart';
import 'package:foco_alternativo/widgets/timeoptions.dart';
import 'package:foco_alternativo/widgets/timercard.dart';

class TimerScreenExternal extends StatefulWidget {
  const TimerScreenExternal({super.key});

  @override
  State<TimerScreenExternal> createState() => _TimerScreenExternalState();
}

class _TimerScreenExternalState extends State<TimerScreenExternal> {
  Uint8List? _image;

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
    final provider = Provider.of<TimeService>(context);
    return Scaffold(
      backgroundColor: renderColor(provider.currentState),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: renderColor(provider.currentState),
        title: Text(
          "Meu Foco Total",
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Provider.of<TimeService>(context, listen: false).reset(),
            icon: Icon(Icons.refresh, color: Colors.white),
            iconSize: 40,
          )
        ],
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
            Divider(),
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
            Divider(),
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
            Divider(),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Personal History'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => History())),
              },
            ),
            Divider(),
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
            Divider(),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: const [
              SizedBox(
                height: 65,
              ),
              TimerCard(),
              SizedBox(
                height: 40,
              ),
              TimeOptions(),
              SizedBox(
                height: 30,
              ),
              TimeController(),
              SizedBox(
                height: 30,
              ),
              ProgressWidget()
            ],
          ),
        ),
      ),
    );
  }
}

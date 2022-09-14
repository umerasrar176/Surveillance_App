//import 'dart:html';

import 'dart:convert';

import 'package:surveillance_app/screens/live_preview.dart';
import 'package:surveillance_app/screens/settings.dart';
import 'package:surveillance_app/services/auth.dart';
import 'package:surveillance_app/wrapper.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:surveillance_app/Authenticate/login_screen.dart';
import 'package:surveillance_app/screens/dashboard.dart';
import 'package:surveillance_app/screens/profile.dart';
import 'package:surveillance_app/screens/notifications.dart';
import 'package:surveillance_app/screens/modes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:surveillance_app/screens/settings.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

//flutter run --no-sound-null-safety
//flutter build apk --release --no-sound-null-safety
//adb connect 192.168.0.101

var myname1 ='';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var auth_token = prefs.getString('auth_token');
  var name = prefs.getString('name');
  myname1 = name!;
  print(auth_token);
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth_token == null ? const LoginScreen() : const MyHomePage()));
}

/*class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      initialData: null,
      value: AuthService().user,
      builder: (context, snapshot) {
        return const MaterialApp(
          home: Wrapper(),
      );
    }
    );
    /*return MaterialApp(
      routes: {
        '/': (context) => const LoginScreen(),
        '/Dashboard': (context) => const MyHomePage(),
      },
    );*/
  }
}*/

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  String myName = '';

  //  nameGet() async {
  //   print("making connection .....");
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //    String? name = prefs.getString('name');
  //   print(name);
  //   setState(() {
  //     myName = name!;
  //   });
  // }

  final List<Widget> pages = [
    const Notifications(),
    const Modes(),
    const Dashboard(),
    const Livepreview(),
    const ProfileApp(),
  ];
  int selectedPageIndex = 2;
  int _selectedDestination = -1;
  bool _isSelected = false;

  final AuthService _auth = AuthService();

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  String? pageName() {
    if (selectedPageIndex == 2) {
      return "Home";
    } else if (selectedPageIndex == 0) {
      return "Notifications";
    } else if (selectedPageIndex == 1) {
      return "Modes";
    } else if (selectedPageIndex == 3) {
      return "Live preview";
    } else {
      return "Profile";
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> logoutUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageName()!,
          style: const TextStyle(
              fontWeight: FontWeight.w900, fontSize: 30.0, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Settings()));
                }),
          ),
        ],
      ),
      body: pages[selectedPageIndex],
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/pic.png'),
                          radius: 30.0,
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          //myName,
                          myname1,
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                         const Text(
                          "Manager",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        /*Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(

                                      children: const <Widget>[
                                        Text(
                                          "Posts",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "5200",
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.pinkAccent,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(

                                      children: const <Widget>[
                                        Text(
                                          "Followers",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "28.5K",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.pinkAccent,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(

                                      children: const <Widget>[
                                        Text(
                                          "Follow",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "1300",
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.pinkAccent,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )*/
                      ],
                    ),
                  ),
                )),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Switch(
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected = newValue;
                    });
                  },
                  value: _isSelected,
                ),
              ),
              title: const Text('Dark Theme'),
              selected: _selectedDestination == 0,
              onTap: () {
                selectDestination(0);
                Navigator.pop(context);
              },
            ),
            /*ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  selectedPageIndex = 4;
                  Navigator.pop(context);
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileApp()));*/
                },
              ),
              ListTile(
                leading: const Icon(Icons.doorbell),
                title: const Text('Notifications'),
                selected: _selectedDestination == 2,
                onTap: () {
                  selectDestination(2);
                  selectedPageIndex = 0;
                  Navigator.pop(context);
                },
              ),*/
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: _selectedDestination == 3,
              onTap: () {
                selectDestination(3);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
            /*ListTile(
                leading: const Icon(Icons.shield),
                title: const Text('Modes'),
                selected: _selectedDestination == 4,
                onTap: () {
                  selectDestination(4);
                  selectedPageIndex = 1;
                  Navigator.pop(context);
                } ,
              ),*/
            const Divider(
              height: 1,
              thickness: 1,
            ),
            /*const Padding(
                padding: EdgeInsets.all(16.0),
                */ /*child: Text(
                  'Label',
                ),*/ /*
              ),*/
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              selected: _selectedDestination == 5,
              onTap: () {
                selectDestination(5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('Contact Us'),
              selected: _selectedDestination == 6,
              onTap: () {
                selectDestination(6);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              selected: _selectedDestination == 7,
              onTap: () async {
                selectDestination(7);
                //await _auth.signOut();
                logoutUser();
                Navigator.pop(context);
                //Navigator.pushNamed(context, '/');
              },
            ),
            /*ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),*/
          ],
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.doorbell, title: "Notifications"),
          TabData(iconData: Icons.shield, title: "Modes"),
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.play_arrow, title: "Live Preview"),
          TabData(iconData: Icons.person, title: "Profile")
        ],
        onTabChangedListener: (position) {
          setState(() {
            selectedPageIndex = position;
          });
        },
      ),
    );
  }
}

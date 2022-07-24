import 'package:app_making/screens/notifications.dart';
import 'package:app_making/screens/settings.dart';
import 'package:app_making/services/auth.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
   drawer({Key? key}) : super(key: key);


  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {

  int selectedPageIndex = 2;
  int _selectedDestination = -1;
  bool _isSelected = false;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      radius: 20.0,
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    const Text(
                      "Umer Hayat",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Card(
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
                    )
                  ],
                ),
              ),
            )
        ),
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
          } ,
        ),
        ListTile(
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
            //selectedPageIndex = 0;
            //Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifications()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          selected: _selectedDestination == 3,
          onTap: () {
            selectDestination(3);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.shield),
          title: const Text('Modes'),
          selected: _selectedDestination == 4,
          onTap: () {
            selectDestination(4);
            selectedPageIndex = 1;
            Navigator.pop(context);
          } ,
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        /*const Padding(
                padding: EdgeInsets.all(16.0),
                *//*child: Text(
                  'Label',
                ),*//*
              ),*/
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help'),
          selected: _selectedDestination == 5,
          onTap: () {
            selectDestination(5);
            Navigator.pop(context);
          } ,
        ),
        ListTile(
          leading: const Icon(Icons.contact_page),
          title: const Text('Contact Us'),
          selected: _selectedDestination == 6,
          onTap: () {
            selectDestination(6);
            Navigator.pop(context);
          } ,
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          selected: _selectedDestination == 7,
          onTap: () async {
            selectDestination(7);
            await _auth.signOut();
            Navigator.pop(context);
            //Navigator.pushNamed(context, '/');
          } ,
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
    );
  }
}

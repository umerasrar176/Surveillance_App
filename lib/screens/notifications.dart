import 'dart:convert';

import 'package:surveillance_app/screens/drawer.dart';
import 'package:surveillance_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:surveillance_app/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  _Notifications createState() => _Notifications();
}

class _Notifications extends State<Notifications> {
  List mylist = [];
  bool _isSelected = false;
  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete = 'https://expressapiapp.azurewebsites.net/api/alert/GetAlert/' + id!;
    var url = Uri.parse(urlComplete);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    //print(response.body);
    var data = jsonDecode(response.body);
    //var data = Data.fromJson(response.body);
    print(data);
    print(data?.length);
    setState(() {
      mylist = data;
    });

    print(mylist[0]);
    /* if (data.length > 0) {
        for (int i = 0; i < data.length; i++) {
          if (data[i] != null) {
            Map<String, dynamic> map = data[i];
            cameras?.add(Data.fromJson(map));
          }
        }
      }
      mylist= cameras ;*/
  }
  /*String messageTitle = "Empty";
  String notificationAlert = "alert";

  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
    //LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.data['title']);
        print(message.data['body']);

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(message.data['title']),
            content: Text(message.data['title']),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.data['title']);
        print(message.data['body']);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data['title']);
      print(message.data['body']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: const Text("Notifications" ,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
                color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
          actions:  [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Settings()));
                  }
              ),
            ),
          ],
        ),*/
      //drawer: drawer(),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: mylist.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildTile(Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                            child: Text(mylist[index]["description"],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.0))),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 290,
                          child: Text(
                            mylist[index]["camera"],
                            style: const TextStyle(
                              fontSize: 13,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 25,
                            ),
                            PopupMenuButton<String>(
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: "Remove",
                                  child: Text("Remove"),
                                  //onTap: ,
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ]),
            ));
          }),

      /*StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
          children: <Widget>[
            getSearchBarUI(),
            */ /*_buildTile(
              Padding
                (
                padding: const EdgeInsets.all(14.0),
                child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      Column
                        (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>
                        [
                          Text('Notifications', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                        ],
                      ),
                      Material
                        (
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24.0),
                          child: const Center
                            (
                              child: Padding
                                (
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.search, color: Colors.white, size: 30.0),
                              )
                          )
                      )
                    ]
                ),
              ),
            ),*/ /*
            _buildTile(
              Padding
                (
                padding: const EdgeInsets.all(15.0),
                child: Row
                  (
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      Column
                        (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>
                        [
                          Material
                            (
                              child: Text('Do not Disturb', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 27.0))
                          ),
                          */ /*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*/ /*
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 260,
                            child: Text("This setting will suppress all notifications in "
                                "all modes regardless of their individual modes of configuration",maxLines: 5,style: TextStyle(
                              fontSize: 13,
                              //fontWeight: FontWeight.bold
                            ),
                            ),
                          ),

                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>
                              [
                                const SizedBox(
                                  height: 25,
                                ),
                                Material
                                  (
                                  child: Switch(
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        _isSelected = newValue;
                                      });
                                    },
                                    value: _isSelected,
                                  ),
                                )
                              ]
                          ),
                      )
                    ]
                ),
              ),
            ),
          ],
          staggeredTiles: const [
            StaggeredTile.extent(2, 70.0),
            StaggeredTile.extent(2, 180.0),
            */ /*StaggeredTile.extent(1, 155.0),
            StaggeredTile.extent(1, 155.0),
            StaggeredTile.extent(2, 200.0),
            StaggeredTile.extent(2, 200.0),
            StaggeredTile.extent(2, 200.0),*/ /*
          ],
        )*/
    );
  }

  Widget _buildTile(Widget child) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            /*onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },*/
            child: child));
  }
}

Widget getSearchBarUI() {
  return Padding(
    padding: const EdgeInsets.only(left: 6, right: 5, top: 2, bottom: 1),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 4, bottom: 4),
                child: TextField(
                  onChanged: (String txt) {},
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  cursorColor: const Color(0xFF54D3C2),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Devices...',
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 2),
                  blurRadius: 8.0),
            ],
          ),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  //FocusScope.of(context).requestFocus(FocusNode());
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

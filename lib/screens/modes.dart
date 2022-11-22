import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Modes extends StatefulWidget {
  const Modes({Key? key}) : super(key: key);
  @override
  _Modes createState() => _Modes();
}



class _Modes extends State<Modes> {

  modeActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/camera/updateCamera/'+id!;
    var url = Uri.parse(urlComplete);
    final response = await http.put(
      url,
      body: {
        "mode": 'active',
      },
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print(id);
      addToast("Mode Changed successful");
    }
    else {
      addToast("Failed");
    }
  }

  modeSilent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/camera/updateCamera/'+id!;
    var url = Uri.parse(urlComplete);
    final response = await http.put(
      url,
      body: {
        "mode": 'silent',
      },
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print(id);
      addToast("Mode Changed successful");
    }
    else {
      addToast("Failed");
    }
  }

  addToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toast == "Mode Changed successful" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 450,
                  child: FittedBox(
                      child: Image.asset("assets/images/object detection.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              const SizedBox(width: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                      type: MaterialType
                          .transparency, //Makes it usable on any background color, thanks @IanSmith
                      child: Ink(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.indigoAccent, width: 5.0),
                          color: Colors.lightBlue,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          //This keeps the splash effect within the circle
                          borderRadius: BorderRadius.circular(
                              1000.0), //Something large to ensure a circle
                          onTap: modeActive,
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.wb_sunny_sharp,
                              size: 45.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  const Text('Active',
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
                  /*IconButton(
                    icon: const Icon(Icons.highlight_sharp),
                    iconSize: 90,
                    tooltip: 'Active Mode',
                    onPressed: () {
                      setState(() {

                      });
                    },
                  ),
                  const Text('Active'),*/
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                      type: MaterialType
                          .transparency, //Makes it usable on any background color, thanks @IanSmith
                      child: Ink(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.indigoAccent, width: 4.0),
                          color: Colors.lightBlue,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          //This keeps the splash effect within the circle
                          borderRadius: BorderRadius.circular(
                              1000.0), //Something large to ensure a circle
                          onTap: modeSilent,
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.nightlight_round,
                              size: 45.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  const Text('Silent',
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
                  /*IconButton(
                    icon: const Icon(Icons.nightlight_round),
                    iconSize: 80,
                    tooltip: 'Silent Mode',
                    onPressed: () {
                      setState(() {

                      });
                    },
                  ),
                  const Text('Silent'),*/
                ],
              ),
            ],
          )
        ],
      ),
      ),

      /*Image(
        image: AssetImage("assets/images/object detection.jpg"),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),*/

      /*appBar: AppBar(
          title: const Text("Modes" ,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
                color: Colors.white),),
          backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
        )*/
    );
  }
}

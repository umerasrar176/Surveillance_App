import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PairedDevices extends StatefulWidget {
  const PairedDevices({Key? key}) : super(key: key);

  @override
  _PairedDevicesState createState() => _PairedDevicesState();
}

class Data {
  final String cameraId;
  final String name;
  final String mode;
  final String status;
  final String videoLink;

  Data({required this.cameraId, required this.name, required this.mode, required this.status, required this.videoLink});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      cameraId: json['cameraId'],
      name: json['name'],
      mode: json['mode'],
      status: json['status'],
      videoLink: json['videoLink'],
    );
  }
}

  //print(data.runtimeType);
  //var d1 = await data.map((data) async => Data.fromJson(data)).toList() as Future<List<Data>>;
  //print(d1.runtimeType);
  //List<dynamic> list =  data.map((data) => Data.fromJson(data)).toList();
  //List<Data> list=new List<Data>.fromJson(data);
  //cameras= list;

  //return list;
  //int id = data['id'];

  /*if (response.statusCode == 200) {
    print("in response state");
    setState(() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Camera IP'),
          content: const Text('Camera IP registered successful'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {clearTextInput(),Navigator.pop(context, 'OK')},
              child: const Text('OK'),
            ),
          ],
        ))
    );
    print(id);
    addToast("Register successful");
  } else if (response.statusCode == 422){
    addToast("A Same IP already exists");
  }
  else {
    addToast("Register fail");
  }*/
class _PairedDevicesState extends State<PairedDevices> {

   List mylist =[];
  @override
  void initState() {
    super.initState();
    add();
    //print(add());
  }

    //List cameras =[];
    add() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('id');
      var token = prefs.getString('auth_token');
      print("making connection...");
      String urlComplete = 'https://expressapiapp.azurewebsites.net/api/camera/ViewAllCameras/' + id!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('All Devices'),
        ),
        /*body: ListView(
          children: [
            for (Data camera in mylist)
              ListTile(
                title: Text(camera.name),
                leading: const Icon(Icons.linked_camera),
                trailing: PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "Remove",
                      child: Text("Remove"),
                    ),
                  ],
                )
            ),
          ],
        ),*/
      body: ListView.builder(
          itemCount: mylist?.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(mylist[index]["name"]),
              leading: const Icon(Icons.linked_camera),
              trailing: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "Remove",
                    child: Text("Remove"),
                    //onTap: ,
                  ),
                ],
              ),
            );
          }
      )
      /*FutureBuilder (
          future: add() ,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Data>? data = snapshot.data ;
                ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(data![index].name),
                          leading: const Icon(Icons.linked_camera),
                          trailing: PopupMenuButton<String>(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "Remove",
                                child: Text("Remove"),
                                //onTap: ,
                              ),
                            ],
                          ),
                      );
                    }
                );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            print("Line153${mylist}");
            // By default show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),*/
    );

    }
}

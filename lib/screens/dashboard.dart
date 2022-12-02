import 'dart:convert';

import 'package:surveillance_app/screens/drawer.dart';
import 'package:surveillance_app/screens/paired_devices.dart';
import 'package:surveillance_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'add_device.dart';

class Dashboard extends StatefulWidget {

    const Dashboard( {Key? key} ) : super(key: key);


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    total();
    unpairedC();
    Active();
    Silent();
  }

  //const [totalCamera, setTotalcamera] = useState('0');
  late var totalCamera = '0';
  late var unpaired = '0';
  late var paired = '0';
  late var activeCount = '0';
  late var  silentCount= '0';



    pairedC() async {
    //print(int.parse(totalCamera));
    //print(int.parse(unpaired));
    setState(()  {
       paired = (int.parse(totalCamera) - int.parse(unpaired)).toString();
    });
    print("paired"+paired);
  }

  total() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/camera/ViewAllCameras/'+id!;
    var url = Uri.parse(urlComplete);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);
    var data = jsonDecode(response.body);
    print(data.length+1);
    setState(() {
      totalCamera  = (data.length +1).toString();
    });
  }

  unpairedC() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/camera/CountUnpairedCamera/'+id!;
    var url = Uri.parse(urlComplete);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);
    setState(() {
      unpaired = response.body;
    });

  }

  Active() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/camera/CountActive/'+id!;
    var url = Uri.parse(urlComplete);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);
    setState(() {
      activeCount = response.body;
    });

  }

  Silent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/camera/CountSlient/'+id!;
    var url = Uri.parse(urlComplete);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);
    setState(() {
      silentCount = response.body;
    });

  }
 //var a = int.parse(totalCamera);


  /*int _currentIndex = 0;
  final List _children = [];

  final List<List<double>> charts =
  [
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4,],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4]
  ];

  static final List<String> chartDropdownItems = [ 'Last 7 days', 'Last month', 'Last year' ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;*/


  @override
  Widget build(BuildContext context) {
    pairedC();
    return Scaffold(
        /*appBar: AppBar(
          title: const Text("Home" ,
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
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
          staggeredTiles: const [
            StaggeredTile.extent(2, 70.0),
            StaggeredTile.extent(2, 80.0),
            StaggeredTile.extent(1, 155.0),
            StaggeredTile.extent(1, 155.0),
            StaggeredTile.extent(1, 155.0),
            StaggeredTile.extent(1, 155.0),
            StaggeredTile.extent(2, 50.0),
            StaggeredTile.extent(2, 80.0),
            StaggeredTile.extent(2, 10.0),
            StaggeredTile.extent(2, 80.0),
          ],
          children: <Widget>[
                getSearchBarUI(),
                /*Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(38.0),
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
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'London...',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(38.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: const Offset(0, 2),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.search,
                                  size: 20,
                                  color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),*/
            _buildTile(
              Padding
                (
                padding: const EdgeInsets.all(15.0),
                child: Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>
                        [
                          Material
                            (
                              child: Icon(Icons.camera_alt, color: Colors.blue, size: 40.0),
                          ),
                          /*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*/
                          Text('Total Devices', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 27.0))
                        ],
                      ),
                       Material
                        (
                        child: Text(totalCamera, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 34.0)),
                      )
                    ]
                ),
              ),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  <Widget>
                        [
                          const Material
                            (
                            child: Icon(Icons.connected_tv, color: Colors.blue, size: 45.0),
                          ),
                          /*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*/
                          const Padding(padding: EdgeInsets.only(right: 40.0)),
                          Text(paired, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 37.0))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      const Text('Paired Devices', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0)),
                      /*Text('Images, Videos', style: TextStyle(color: Colors.black45)),*/
                    ]
                ),
              ),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  <Widget>
                        [
                          const Material
                            (
                            child: Icon(Icons.not_interested_outlined, color: Colors.blue, size: 45.0),
                          ),
                          /*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*/
                          const Padding(padding: EdgeInsets.only(right: 40.0)),
                          Text(unpaired,  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 37.0))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      const Text('UnPaired Devices', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0)),
                      /*Text('Images, Videos', style: TextStyle(color: Colors.black45)),*/
                    ]
                ),
              ),
            ),
            /*_buildTile(
              Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    onPressed: () {
                      print('Pressed');
                    },
                    child: Text('View all Cameras'),
                  )

                  *//*Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                    Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>
                            [
                              const Material
                                (
                                child: Icon(Icons.camera_alt, color: Colors.blue, size: 40.0),
                              ),
                              const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*//**//*
                              const Text('Camera 1', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 27.0)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>
                                  [
                                    Material(
                                      child: Text('Paired', style: TextStyle(color: Colors.blueAccent, fontSize: 15.0)),
                                    ),
                                    Icon(Icons.connected_tv, color: Colors.blue, size: 15.0),
                                  ],
                                 ),
                            ],
                          ),
                          const Text('Active', style: TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      const Divider(
                          color: Colors.black
                      ),
                  Row
                    (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>
                    [
                      Material
                        (
                        child: Icon(Icons.warning_amber_outlined, color: Colors.blue, size: 25.0),
                      ),
                      Material
                        (
                        child: Icon(Icons.notifications_none, color: Colors.blue, size: 25.0),
                      ),
                      Material(
                        child: Icon(Icons.connected_tv, color: Colors.blue, size: 25.0),
                      ),
                      Material(
                        child: Icon(Icons.slow_motion_video_outlined, color: Colors.blue, size: 25.0),
                      ),
                      Material(
                        child: Icon(Icons.settings, color: Colors.blue, size: 25.0),
                      )
                    ],
                  ),
                      *//**//*const Padding(padding: EdgeInsets.only(bottom: 4.0)),*//**//*
                      *//**//*Sparkline
                        (
                        data: charts[actualChart],
                        lineWidth: 5.0,
                        lineColor: Colors.greenAccent,
                      )*//**//*
                    ],
                  )*//*
              ),
            ),
            _buildTile(
              Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>
                            [
                              const Material
                                (
                                child: Icon(Icons.camera_alt, color: Colors.blue, size: 40.0),
                              ),
                              *//*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*//*
                              const Text('Camera 2', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 27.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>
                                [
                                  Material(
                                    child: Text('Paired', style: TextStyle(color: Colors.blueAccent, fontSize: 15.0)),
                                  ),
                                  Icon(Icons.connected_tv, color: Colors.blue, size: 15.0),
                                ],
                              ),
                            ],
                          ),
                          const Text('Silent', style: TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      const Divider(
                          color: Colors.black
                      ),
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>
                        [
                          *//*Material
                            (
                            child: Icon(Icons.warning_amber_outlined, color: Colors.blue, size: 25.0),
                          ),
                          Material
                            (
                            child: Icon(Icons.notifications_none, color: Colors.blue, size: 25.0),
                          ),*//*
                          Material(
                            child: Icon(Icons.connected_tv, color: Colors.blue, size: 25.0),
                          ),
                          Material(
                            child: Icon(Icons.slow_motion_video_outlined, color: Colors.blue, size: 25.0),
                          ),
                          Material(
                            child: Icon(Icons.settings, color: Colors.blue, size: 25.0),
                          )
                        ],
                      ),
                      *//*const Padding(padding: EdgeInsets.only(bottom: 4.0)),*//*
                      *//*Sparkline
                        (
                        data: charts[actualChart],
                        lineWidth: 5.0,
                        lineColor: Colors.greenAccent,
                      )*//*
                    ],
                  )
              ),
            ),
            _buildTile(
              Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>
                            [
                              const Material
                                (
                                child: Icon(Icons.camera_alt, color: Colors.blue, size: 40.0),
                              ),
                              *//*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*//*
                              const Text('Camera 3', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 27.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>
                                [
                                  Material(
                                    child: Text('Paired', style: TextStyle(color: Colors.blueAccent, fontSize: 15.0)),
                                  ),
                                  Icon(Icons.connected_tv, color: Colors.blue, size: 15.0),
                                ],
                              ),
                            ],
                          ),
                          const Text('Active', style: TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      const Divider(
                          color: Colors.black
                      ),
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>
                        [
                          Material
                            (
                            child: Icon(Icons.warning_amber_outlined, color: Colors.blue, size: 25.0),
                          ),
                          Material
                            (
                            child: Icon(Icons.notifications_none, color: Colors.blue, size: 25.0),
                          ),
                          Material(
                            child: Icon(Icons.connected_tv, color: Colors.blue, size: 25.0),
                          ),
                          Material(
                            child: Icon(Icons.slow_motion_video_outlined, color: Colors.blue, size: 25.0),
                          ),
                          Material(
                            child: Icon(Icons.settings, color: Colors.blue, size: 25.0),
                          )
                        ],
                      ),
                      *//*const Padding(padding: EdgeInsets.only(bottom: 4.0)),*//*
                      *//*Sparkline
                        (
                        data: charts[actualChart],
                        lineWidth: 5.0,
                        lineColor: Colors.greenAccent,
                      )*//*
                    ],
                  )
              ),
            ),*/
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  <Widget>
                        [
                          const Material
                            (
                            child: Icon(Icons.ac_unit, color: Colors.blue, size: 45.0),
                          ),
                          /*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*/
                          const Padding(padding: EdgeInsets.only(right: 40.0)),
                          Text(activeCount, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 37.0))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25.0)),
                      const Text('Active Devices', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0)),
                      /*Text('Images, Videos', style: TextStyle(color: Colors.black45)),*/
                    ]
                ),
              ),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  <Widget>
                        [
                          const Material
                            (
                            child: Icon(Icons.unpublished, color: Colors.blue, size: 45.0),
                          ),
                          /*const Text('Total Views', style: TextStyle(color: Colors.blueAccent)),*/
                          const Padding(padding: EdgeInsets.only(right: 40.0)),
                          Text(silentCount,  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 37.0))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      const Text('Silent Devices', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18.0)),
                      /*Text('Images, Videos', style: TextStyle(color: Colors.black45)),*/
                    ]
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontStyle: FontStyle.italic
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddDevice()));
                },
                child: Text('Add a Camera'),
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontStyle: FontStyle.italic
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PairedDevices()));
                },
                child: Text('View all Cameras'),
              ),
            )

          ],
        )
      /*appBar: AppBar(
        title: const Text("Live Preview",
            style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30.0,
            color: Colors.white),),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
      ),*/
      /*body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem("Manual", Icons.book),
            makeDashboardItem("Mode", Icons.mode),
            makeDashboardItem("Alphabet", Icons.alarm),
            makeDashboardItem("Alphabet", Icons.alarm),
            makeDashboardItem("Alphabet", Icons.alarm),
            makeDashboardItem("Alphabet", Icons.alarm)
          ],
        ),
      ),*/
    );
  }

  Widget _buildTile(Widget child) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),

        shadowColor: const Color(0x802196F3),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            /*onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },*/
            child: child
        )
    );
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
                  child: Icon(Icons.search,
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

  /*Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                const SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )),
                const SizedBox(height: 20.0),
                Center(
                  child: Text(title,
                      style:
                      const TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }*/

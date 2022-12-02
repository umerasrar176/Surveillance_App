import 'package:surveillance_app/screens/paired_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'add_device.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {

  bool _isSelected= false;
  int _selectedDestination = -1;

  @override
  void initState() {
    super.initState();

    /*var s = "6:30";
    TimeOfDay _startTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
    //List1();
    print(_startTime);*/
    getPref();

  }
  List mylist = List.filled(4, null);

  TimeOfDay _ActiveS = TimeOfDay(hour: 8, minute: 30);
  TimeOfDay _ActiveE = TimeOfDay(hour: 8, minute: 30);
  TimeOfDay _SilentS = TimeOfDay(hour: 8, minute: 30);
  TimeOfDay _SilentE = TimeOfDay(hour: 8, minute: 30);

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getString("ActiveS");
      print("my time"+value);
      TimeOfDay AS = TimeOfDay(hour:int.parse(value.split(":")[0]),minute: int.parse(value.split(":")[1]));
      setState((){
      _ActiveS = AS;
      });
      value = preferences.getString("ActiveE");
      TimeOfDay AE = TimeOfDay(hour:int.parse(value.split(":")[0]),minute: int.parse(value.split(":")[1]));
      setState((){
        _ActiveE = AE;
      });
      value = preferences.getString("SilentS");
      TimeOfDay SS = TimeOfDay(hour:int.parse(value.split(":")[0]),minute: int.parse(value.split(":")[1]));
      setState((){
        _SilentS = SS;
      });
      value = preferences.getString("SilentE");
      TimeOfDay SE = TimeOfDay(hour:int.parse(value.split(":")[0]),minute: int.parse(value.split(":")[1]));
      setState((){
        _SilentE = SE;
      });
    });
  }



  ActiveS(String actives) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("ActiveS", actives);
      preferences.commit();
    });
  }

  ActiveE(String activee) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("ActiveE", activee);
      preferences.commit();
    });
  }

  SilentS(String silents) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("SilentS", silents);
      preferences.commit();
    });
  }

  SilentE(String silente) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("SilentE", silente);
      preferences.commit();
    });
  }




  /*void List1(){
    mylist[0] = _ActiveS;
    mylist[1] = _ActiveE;
    mylist[2] = _SilentS;
    mylist[3] = _SilentE;

    print(mylist);\


  }*/
  // show time picker method
  void _ActiveStart() {
    showTimePicker(
      context: context,
      initialTime: _ActiveS,
    ).then((value) {
      setState(() {
        _ActiveS = value!;
        int hour = value.hour;
        int min = value.minute;
        String date = (hour.toString()+":"+min.toString());
        ActiveS(date);
      });
    });
  }
  void _ActiveEnd() {
    showTimePicker(
      context: context,
      initialTime: _ActiveE,
    ).then((value) {
      setState(() {
        _ActiveE = value!;
        int hour = value.hour;
        int min = value.minute;
        String date = (hour.toString()+":"+min.toString());
        ActiveE(date);
      });
    });
  }
  void _SilentStart() {
    showTimePicker(
      context: context,
      initialTime: _SilentS,
    ).then((value) {
      setState(() {
        _SilentS = value!;
        int hour = value.hour;
        int min = value.minute;
        String date = (hour.toString()+":"+min.toString());
        SilentS(date);
      });
    });
  }
  void _SilentEnd() {
    showTimePicker(
      context: context,
      initialTime: _SilentE,
    ).then((value) {
      setState(() {
        _SilentE = value!;
        int hour = value.hour;
        int min = value.minute;
        String date = (hour.toString()+":"+min.toString());
        SilentE(date);
      });
    });
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Settings" ,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30.0,
              color: Colors.white),),
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
      ),
        body: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
            staggeredTiles: const [
              StaggeredTile.extent(2, 70.0),
              StaggeredTile.extent(2, 75.0),
              StaggeredTile.extent(1, 155.0),
              StaggeredTile.extent(1, 155.0),
              StaggeredTile.extent(2, 75.0),
              StaggeredTile.extent(2, 60.0),
              StaggeredTile.extent(2, 60.0),
              //StaggeredTile.extent(2, 110.0),
            ],
            children: <Widget>[
              getSearchBarUI(),
              /*_buildTile(
                Padding
                  (
                  padding: const EdgeInsets.all(10.0),
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
                            Text('Settings', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                          ],
                        ),
                        Material
                          (
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center
                              (
                                child: Padding
                                  (
                                  padding: const EdgeInsets.all(6.0),
                                  child:  IconButton(
                                    icon: const Icon(Icons.search),
                                    iconSize: 30,
                                    color: Colors.white,
                                    //tooltip: 'Increase volume by 5',
                                    onPressed: () {

                                    },
                                  ),
                                )
                            )
                        )
                      ]
                  ),
                ),
                elevation: 14.0,
                Radius: 12.0,
              ),*/
              _buildTile( //Devices
                Padding
                  (
                  padding: const EdgeInsets.all(4.0),
                  child: Row
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>
                      [
                        Text('Devices', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26.0)),
                        /*Material
                          (
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center
                              (
                              child: Padding
                                (
                                padding: const EdgeInsets.all(0.0),
                                child:  IconButton(
                                  icon: const Icon(Icons.add),
                                  iconSize: 40,
                                  color: Colors.black,
                                  //tooltip: 'Increase volume by 5',
                                  onPressed: () {

                                  },
                                ),
                              ),
                            )
                        )*/
                      ]
                  ),
                ),
                color: Colors.blueAccent,
                elevation: 14.0,
                Radius: 12.0,
              ),
              _buildTile( //View all devices
                Padding
                  (
                  padding: const EdgeInsets.all(4.0),
                  child: Column
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>
                      [
                        Row
                          (
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>
                          [
                            Material
                              (
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center
                                  (
                                  child: Padding
                                    (
                                    padding: const EdgeInsets.all(0.0),
                                    child:  IconButton(
                                      icon: const Icon(Icons.connected_tv),
                                      iconSize: 90,

                                      color: Colors.white,
                                      //tooltip: 'Increase volume by 5',
                                      onPressed: () {
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(builder: (context) => const PairedDevices()));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const PairedDevices()));
                                      },
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                        const Text('All Devices', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26.0)),
                      ]
                  ),
                ),
                elevation: 14.0,
                color: Colors.lightBlue,
                Radius: 12.0,
              ),

              _buildTile( //Add device
                Padding
                  (
                  padding: const EdgeInsets.all(4.0),
                  child: Column
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>
                      [
                        Row
                          (
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>
                          [
                            Material
                              (
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center
                                  (
                                  child: Padding
                                    (
                                    padding: const EdgeInsets.all(0.0),
                                    child:  IconButton(
                                      icon: const Icon(Icons.add),
                                      iconSize: 90,

                                      color: Colors.white,
                                      //tooltip: 'Increase volume by 5',
                                      onPressed: () {
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(builder: (context) => const AddDevice()));

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const AddDevice()));
                                      },
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                        const Text('Add Devices', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26.0)),
                      ]
                  ),
                ),
                elevation: 14.0,
                color: Colors.lightBlue,
                Radius: 12.0,

              ),

              _buildTile( //Mode Automation
                Padding
                  (
                  padding: const EdgeInsets.all(4.0),
                  child: Row
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>
                      [
                        Text('Mode Automation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26.0)),
                        /*Material
                          (
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center
                              (
                              child: Padding
                                (
                                padding: const EdgeInsets.all(0.0),
                                child:  IconButton(
                                  icon: const Icon(Icons.add),
                                  iconSize: 40,
                                  color: Colors.black,
                                  //tooltip: 'Increase volume by 5',
                                  onPressed: () {

                                  },
                                ),
                              ),
                            )
                        )*/
                      ]
                  ),
                ),
                color: Colors.blueAccent,
                elevation: 14.0,
                Radius: 12.0,
              ),

              _buildTile( //Active mode
                Padding
                  (
                  padding: const EdgeInsets.all(4.0),
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
                            Text('Active Mode', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 26.0)),
                          ],
                        ),
                        Row(
                          children: [
                            Material
                              (
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center
                                  (
                                  child: Padding
                                    (
                                    padding: const EdgeInsets.all(0.0),
                                    child:  IconButton(
                                      icon: const Text("Start", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0)),
                                      iconSize: 60,
                                      color: Colors.black,
                                      //tooltip: 'Increase volume by 5',
                                      onPressed: _ActiveStart,

                                      /*() => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Active Mode'),
                                          content: const Text('Active Mode started..'),
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
                                      ),*/
                                    ),
                                  ),
                                )
                            ),
                            Material
                              (
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center
                                  (
                                  child: Padding
                                    (
                                    padding: const EdgeInsets.all(0.0),
                                    child:  IconButton(
                                      icon: const Text("End", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0)),
                                      iconSize: 60,
                                      color: Colors.black,
                                      //tooltip: 'Increase volume by 5',
                                      onPressed: _ActiveEnd,

                                      /*() => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Active Mode'),
                                          content: const Text('Active Mode Ended!!'),
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
                                      ),*/
                                    ),
                                  ),
                                )
                            )
                          ],

                        )

                      ]
                  ),
                ),
                color: Colors.white,
                elevation: 4.0,
                Radius: 0.0,
              ),


              _buildTile( //Silent mode
                Padding
                  (
                  padding: const EdgeInsets.all(4.0),
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
                            Text('Silent Mode', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 26.0)),
                          ],
                        ),
                        Row(
                          children: [
                            Material
                              (
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center
                                  (
                                  child: Padding
                                    (
                                    padding: const EdgeInsets.all(0.0),
                                    child:  IconButton(
                                      icon: const Text("Start", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0)),
                                      iconSize: 60,
                                      color: Colors.black,
                                      //tooltip: 'Increase volume by 5',
                                      onPressed: _SilentStart,

                                      /*() => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Silent Mode'),
                                          content: const Text('Silent Mode started..'),
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
                                      ),*/
                                    ),
                                  ),
                                )
                            ),
                            Material
                              (
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center
                                  (
                                  child: Padding
                                    (
                                    padding: const EdgeInsets.all(0.0),
                                    child:  IconButton(
                                      icon: const Text("End", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0)),
                                      iconSize: 60,
                                      color: Colors.black,
                                      //tooltip: 'Increase volume by 5',
                                      onPressed: _SilentEnd,

                                      /*() => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Silent Mode'),
                                          content: const Text('Silent mode Ended!!'),
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
                                      ),*/
                                    ),
                                  ),
                                )
                            )
                          ],
                        )

                      ]
                  ),
                ),
                color: Colors.white,
                elevation: 4.0,
                Radius: 0.0,
              ),

              _buildTile( //Silent mode
                Padding
                  (
                  padding: const EdgeInsets.only(left:1.0,top: 10.0,right: 1.0,bottom: 10.0),
                  child: Table(
                      border: TableBorder.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2
                      ), // Allows to add a border decoration around your table
                      children:  [
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: const [Text('Active Start', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0))]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: const [Text('Active End', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0))]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: const [Text('Silent start', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0))]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: const [Text('Silent End', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0))]),
                          ),
                        ]),
                        TableRow(children :[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [Text( _ActiveS.format(context).toString(),)]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [Text( _ActiveE.format(context).toString(),)]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [Text( _SilentS.format(context).toString(),)]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [Text( _SilentE.format(context).toString(),)]),
                          ),
                        ]),
                        /*TableRow(children :[
                          Text('1996'),
                          Text('Java'),
                          Text('James Gosling'),
                        ]),*/
                      ]
                  ),
                  ),
                color: Colors.white,
                elevation: 4.0,
                Radius: 0.0,
              ),
            ],
          ),
        );
  }
  Widget _buildTile(Widget child, {Color? color, double? elevation, double? Radius}) {
    return Material(
        elevation: elevation!,
        borderRadius: BorderRadius.circular(Radius!),

        color: color,
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
                    hintText: 'Search Setting...',
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

import 'package:flutter/material.dart';


class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  AboutState createState() => AboutState();
}


class AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
          elevation: 0, brightness: Brightness.dark,
          title: const Text("About", style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 30.0, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {Navigator.pop(context);},
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            )
          ]
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text("Surveillance App", style: TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.w900, fontSize: 30.0)),
            Container(height: 5),
            Container(width: 150, height: 3, color: Colors.blueAccent),
            Container(height: 15),
            const Text("Version", style: TextStyle(color: Color(0xFF999999))),
            const Text("22.09.1", style: TextStyle(color: Color(0xFF263238))),
            Container(height: 15),
            const Text("Last Update", style: TextStyle(color: Color(0xFF999999))),
            const Text("September 2022", style: TextStyle(color: Color(0xFF263238))),
            Container(height: 25),
            const Text("This is a Surveillance app Developed by Eagle Eye Surveillance Systems", style: TextStyle(color: Color(0xFF263238))),
            Container(height: 25),
             const Text("Term of services", style: TextStyle(color: Color(0xFF263238) )),
          ],
        ),
      ),
    );
  }
}


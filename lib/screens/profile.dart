import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveillance_app/screens/contactUs.dart';


class ProfileApp extends StatefulWidget {
  const ProfileApp({Key? key}) : super(key: key);

  @override
  _ProfileAppState createState() => _ProfileAppState();
  }

class _ProfileAppState extends State<ProfileApp> {
  @override
  void initState() {
    super.initState();
    user();
  }

  var name = '';
  var email = '';
  var companyName = '';


  user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/user/GetUser/'+id!;
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

    setState(() {
      name = data['name'];
      email = data['email'];
      companyName = data['companyName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text("Profile" ,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30.0,
              color: Colors.white),),
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
      ),*/
      /*body: Column(
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueAccent, Colors.white]
                  )
              ),
              child: SizedBox(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/pic.png'),
                        radius: 50.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Umer Hayat",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(

                                  children: const <Widget>[
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "5200",
                                      style: TextStyle(
                                        fontSize: 20.0,
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
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "28.5K",
                                      style: TextStyle(
                                        fontSize: 20.0,
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
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "1300",
                                      style: TextStyle(
                                        fontSize: 20.0,
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
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Bio:",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontStyle: FontStyle.normal,
                              fontSize: 28.0
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('My name is Umer and I am  a freelance mobile app developper.\n'
                            'if you need any mobile app for your company then contact me for more informations',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 200.00,

            child: MaterialButton(
              /*onPressed: () => print("Successul Login."),*/
              onPressed: () {},
              color: Colors.blue,
              child: const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),*/


      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 35),
            Text(name, style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold
            )),
            Container(height: 5),
            Text("Manager", textAlign : TextAlign.center, style: TextStyle(
                color: Colors.grey[600]
            )),
            Container(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*InkWell(
                  child: SizedBox(
                    width: 60, height: 60,
                    child: Icon(Icons.chat, color: Colors.lightGreen[600]),
                  ),
                  onTap: (){},
                ),*/
                Container(width: 10),
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.blueAccent[600],
                  child: const CircleAvatar(
                    radius: 49,
                    backgroundImage: AssetImage('assets/images/pic.png'),
                  ),
                ),
                Container(width: 10),
                /*InkWell(
                  child: SizedBox(
                    width: 60, height: 60,
                    child: Icon(Icons.call, color: Colors.lightGreen[600]),
                  ),
                  onTap: (){},
                ),*/
              ],
            ),
            //const Divider(height: 50),
            /*Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      const Text("1.5 K", style: TextStyle(
                          color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("Posts", style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      const Text("17.8 K", style: TextStyle(
                          color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("Followers", style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      const Text("1.3 K", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("Following", style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),
              ],
            ),*/
            const Divider(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text('My name is $name and I am  a manager of company $companyName.'
                  'if you need any service for your company then contact me for more information', textAlign : TextAlign.center, style: TextStyle(
                  color: Colors.grey[900]
              )),
            ),
            const Divider(height: 50),
            Row(
              children: <Widget>[
                Container(width: 40),
                /*Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Website", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("visual-photo.me", style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),*/
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Email", style: TextStyle(
                          color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text(email, style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),
                Container(width: 40)
              ],
            ),
            Container(height: 30),
            Row(
              children: <Widget>[
                Container(width: 40),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Company Name", style: TextStyle(
                          color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text(companyName, style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),
                /*Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Location", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("United State", style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),*/
                Container(width: 40)
              ],
            ),
            Container(height: 30),
            Row(
              children: <Widget>[
                Container(width: 40),
                /*Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Zip Code", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("6525", style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),*/
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Address", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("Comsats University, Park Road Islamabad", style: TextStyle(color: Colors.grey[500]))
                    ],
                  ),
                ),
                Container(width: 40)
              ],
            ),
            Container(height: 20),
            MaterialButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const contactUs())),

              /*showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Contact Us'),
                content: const Text('Thank you for contacting us'),
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
              color: Colors.blue,
              child: const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[600],
        child: Icon(Icons.person_add),
        onPressed: (){},
      ),*/
    );
  }
}
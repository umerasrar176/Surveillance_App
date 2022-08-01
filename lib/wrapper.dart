import 'package:surveillance_app/Authenticate/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'models/user.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    print(user);

    if (user == null) {
      return const LoginScreen();
    } else {
      //print(user.uid);
      return const MyHomePage();
    }
  }
}
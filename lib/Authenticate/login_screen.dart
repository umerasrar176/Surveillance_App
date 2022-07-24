
import 'package:app_making/main.dart';
import 'package:app_making/Authenticate/register.dart';
import 'package:app_making/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app_making/screens/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
enum LoginStatus { notSignIn, signIn }

class _LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email = '';
  String password = '';
  //String error = '';
  //final databaseRef = FirebaseDatabase.instance.reference();
  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  /*void addData(String username, String password) {
    databaseRef.push().set({'username': username, 'password': password});
  }*/
  bool _obscureText = true;
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
      _obscureText = !_obscureText;
    });
  }

  /*check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }*/

  login() async {
    print("making connection...");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('https://expressapiapp.azurewebsites.net/api/auth/login'), body: {
      "email": email,
      "password": password,
    });
    print(response.statusCode);
    final data = jsonDecode(response.body);
    String auth_token = data['accessToken'];
    String ID= data['_id'].toString();
    print("auth token"+auth_token);
    if (response.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage()),
        );
        savePref(auth_token, ID);
      });
      loginToast("Login Successful");
    } else if (response.statusCode == 400){
      loginToast("Email or password is not correct");
    }
    else {
      loginToast("Login Failed");
    }
  }


  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: toast == "Login Successful" ? Colors.green : Colors.red ,
        textColor: Colors.white);
  }

  savePref(String auth_token, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("auth_token", auth_token);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Login" ,
            style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30.0,
            color: Colors.white),),
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
              children: [
                const Text(
                  'Manager Login',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40.0,
                      fontFamily: "times",
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  //controller: username,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  //controller: password,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  obscureText: _obscureText,
                  validator: (val) => val!.length < 8 ? 'Enter a password 8 character long' : null,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Forgotted Password!');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    /*onPressed: () => print("Successul Login."),*/
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        //addData(email, password);
                        //dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        login();

                        /*if (result != null){
                          Navigator.pushNamed(context, '/Dashboard');
                        }
                        if(result == null) {
                          setState(() {
                            error = 'Could not sign in with those credentials';
                          });
                        }
                        else {
                          print("User Added Successfully");
                        }*/
                        /*Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MyHomePage()));*/
                      }
                    },
                    color: Colors.blue,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                /*const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),*/
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: Colors.black,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Don't have an account? ''',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Register()));
                      },
                      child: const Text('Register Now'),
                    )
                  ],
                ),
              ],
            ), )
          ),
        ),
      ),

    );
  }
}
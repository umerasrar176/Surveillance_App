import 'package:surveillance_app/Authenticate/login_screen.dart';
import 'package:surveillance_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String email = '';
  String name = '';
  String organization= '';
  String password = '';
  //String success = '';

  final emailHolder = TextEditingController();
  final nameHolder = TextEditingController();
  final organizationHolder = TextEditingController();
  final passwordHolder = TextEditingController();

  clearTextInput(){
    emailHolder.clear();
    nameHolder.clear();
    organizationHolder.clear();
    passwordHolder.clear();
  }
  final _formKey = GlobalKey<FormState>();
  // RestAPI Register
  bool _secureText = true;
  bool _obscureText = true;

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
      save();
    }
  }*/

  save() async {
    print("making connection...");
    var url = Uri.parse('https://expressapiapp.azurewebsites.net/api/auth/register');
    final response = await http.post(url, body: {
      "name": name,
      "email" : email,
      "password": password,
      "companyName" : organization,
    });
    print(response.statusCode);
    print(response.body);
    final data = jsonDecode(response.body);
    int id = data['id'];

    if (response.statusCode == 201) {
      print("in response state");
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginScreen()),
        );
      });
      print(id);
      clearTextInput();
      registerToast("Register successful");
    } else if (response.statusCode == 422){
      registerToast("A user with that username already exists");
    }
    else {
      registerToast("Register fail");
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toast == "Register successful" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }

  //final databaseRef = FirebaseDatabase.instance.reference();
  //final _formKey = GlobalKey<FormState>();
  //String error = '';

  /*void addData(String email, String phone, String organization, String password) {
    databaseRef.push().set({'username': email,'Phone No' : phone,'Organization' : organization,'password': password});
  }*/

  //final AuthService _auth = AuthService();
  /*void addData(String username, String password) {
    databaseRef.push().set({'username': username, 'password': password});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Register" ,
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
                  'Manager Register',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 35.0,
                      fontFamily: "times",
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 25,
                ),

                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nameHolder,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  //controller: phoneNumber,
                  validator: (val) => val!.isEmpty ? 'Enter an Name' : null,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailHolder,
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
                  keyboardType: TextInputType.text,
                  controller: organizationHolder,
                  onChanged: (val) {
                    setState(() => organization = val);
                  },
                  validator: (val) => val!.isEmpty ? 'Enter an organization name' : null,
                  decoration: const InputDecoration(
                    labelText: 'Organization Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.work),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),


                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordHolder,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  obscureText: _obscureText,
                  validator: (val) => val!.length < 8 ? 'Enter a password 8 character long' : null,
                  decoration:  InputDecoration(
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

                /*Row(
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
                ),*/
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
                    onPressed: ()  {
                      //addData(username.text, password.text);
                      //print("User Registered Successfully");

                      if(_formKey.currentState!.validate()){
                       // error= '';
                       // success= '';
                        //addData(email, phoneNumber, organization, password);
                        //dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        save();

                        /*if (result != null){
                          Navigator.pushNamed(context, '/Dashboard');
                        }*/

                        /*if(result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                          });
                        }
                        else{
                          clearTextInput();
                          //print("User Registered :))");
                          setState(() {
                            success = "User Registered";
                          });
                        }*/
                      }

                      /*Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyHomePage()));*/
                    },
                    color: Colors.blue,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ),
                const SizedBox(height: 12.0),
               /* Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 20.0),
                ),
                const SizedBox(height: 1.0),
                Text(
                  success,
                  style: const TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 30,
                ),*/
                const Divider(
                  color: Colors.black,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Already have an account? ''',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                      child: const Text('Sign In'),
                    )
                  ],
                ),
              ],
            ),),
          ),
        ),
      ),

    );
  }
}

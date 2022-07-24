import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddDevice extends StatefulWidget {
  const AddDevice({Key? key}) : super(key: key);

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {

  Barcode? result;
  QRViewController? controller;
  final iPHolder = TextEditingController();
  final nameHolder = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String cameraId = '';
  String name = '';

  clearTextInput(){
    iPHolder.clear();
    nameHolder.clear();
  }
  //final _formKey = GlobalKey<FormState>();

  //ADD Device IP API
  add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('auth_token');
    print("making connection...");
    String urlComplete= 'https://expressapiapp.azurewebsites.net/api/camera/addcamera/'+id!;
    var url = Uri.parse(urlComplete);
    final response = await http.post(
      url,
      body: {
      "name": name,
      "ip_address" : cameraId,
    },
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);
    final data = jsonDecode(response.body);
    //int id = data['id'];

    if (response.statusCode == 200) {
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
    }
  }
  addToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toast == "Register successful" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }


  @override
    Widget build(BuildContext context) {
      return Scaffold(
          //backgroundColor: MyColors.grey_95,
          appBar: AppBar(
          //backgroundColor: MyColors.grey_100_, brightness: Brightness.dark,
            title: const Text("Add Camera"),
          ),

          body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: nameHolder,
                //validator: (val) => val!.isEmpty ? 'Enter an Name' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
                decoration: const InputDecoration(
                  labelText: 'Camera Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: iPHolder,
                //validator: (val) => val!.isEmpty ? 'Enter an ID' : null,
                onChanged: (val) {
                  setState(() => cameraId = val);
                },
                decoration: const InputDecoration(
                  labelText: 'Camera IP',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flip_camera_ios_rounded),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity, height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent, elevation: 0),
                  child: const Text("ADD CAMERA"),
                  onPressed: (){
                    //if(_formKey.currentState!.validate()) {
                      add();
                    //}
                  },
                ),
              ),
              
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                //height: 20,
                child: Text("OR", style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ), ),
              ),
              /*const SizedBox(
                height: 30,
              ),*/

              Container(
                padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 40.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 170,
                  width: 200,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'Welcome to QR-Scanner',
                  style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Color(0xFF1E1E1E)),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 20.0),
                child: const Text(
                  'Please give access to your Camera so that\n we can scan and provide you what is\n inside the code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    height: 1.4,
                    color: Color(0xFFA0A0A0),
                  ),
                ),
              ),
               SizedBox(
                width: double.infinity, height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent, elevation: 0),
                  child: const Text("Scan QR Code"),
                  onPressed: (){
                    print("scanning button pressed");
                    _buildQrView(context);
                  },
                ),
              ),
            ],
          ),
          ),
          ));

    }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

/// Ensure you use the below two packages in the file which you are working on
import 'package:flutter/material.dart';
import 'package:mb_contact_form/mb_contact_form.dart';


class contactUs extends StatefulWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  _contactUsState createState() => _contactUsState();
}


class _contactUsState extends State<contactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 255, 1.0),
        title: const Text("Contact Us", style: TextStyle(
            fontWeight: FontWeight.w900, fontSize: 30.0, color: Colors.white),
        ),
        elevation: 0,
        ),
      body: const MBContactForm(
        hasHeading: true,
        withIcons: true,
        destinationEmail: "umer.hayat17k@gmail.com",
      ),
    );
  }
}
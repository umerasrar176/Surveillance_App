import 'package:flutter/material.dart';

class PairedDevices extends StatefulWidget {
  const PairedDevices({Key? key}) : super(key: key);

  @override
  _PairedDevicesState createState() => _PairedDevicesState();
}

class _PairedDevicesState extends State<PairedDevices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('All Devices'),
        ),
        body: ListView(
          children: [
            for (int count in List.generate(9, (index) => index + 1))
              ListTile(
                title: Text('Camera $count'),
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
        ),
    );
    }
}

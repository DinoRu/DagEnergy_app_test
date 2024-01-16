import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/meter_page.dart';

class MyTask extends StatelessWidget {

  final String id;
  final String address;

  const MyTask({
    Key ? key,
    required this.id,
    required this.address,

  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingPage()));
          print(id);
          print(address);
        },
        child: Container(
          width: double.infinity,
          color: Colors.grey.shade500,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Id: "),
                    Text(id, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), 
                    SizedBox(height: 4,),
                    Text("Address: "),
                    Container(
                      width: 300,
                      child: Text(address))
                  ],
                ), 
                Icon(Icons.arrow_forward_ios_outlined)
              ]
              ),
          ),
        ),
      ),
    );



























  }
}
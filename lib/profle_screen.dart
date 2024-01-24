import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/meter_page.dart';
import 'package:flutter_app_test/utils/taks.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<Map<String, dynamic>> taskList = [
    {
      'id': 'DS0301OR0000001',
      'address': 'г. Дагестанские Огни, ул. Михаила Ивановича Калинина, 1А'
    },

    {
      'id': 'DS0301OR0000002',
      'address': 'г. Дагестанские Огни, ул. Революции, 28'
    },

    {
      'id': 'DS0301OR0000003',
      'address': 'г. Дагестанские Огни, ул. Александра Сергеевича Пушкина, 32'
    },

    {
      'id': 'DS0301OR0000004',
      'address': '"г. Дагестанские Огни, ул. Революции, 52'
    },

    {
      'id': 'DS0301OR0000005',
      'address': 'г. Дагестанские Огни, ул. Валерия Павловича Чкалова, 7'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text("Task page", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),), backgroundColor: Colors.transparent,),
      
     body: Stack(
      children: [ 
        Image.asset('assets/bg.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
        
        ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingPage()));
            },
            child: Container(
              color: Colors.black45,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(taskList[index]['id'], style: TextStyle(color: Colors.white),),
                subtitle: Text(taskList[index]['address'], style: TextStyle(color: Colors.white),),
              ),
            ),
          );
        })
      ],
     ),
    );
  }
}
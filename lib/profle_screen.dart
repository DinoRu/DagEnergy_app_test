import 'package:flutter/material.dart';
import 'package:flutter_app_test/utils/taks.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task page")),
      bottomNavigationBar: BottomAppBar(),
     body: Container(
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // ignore: prefer_const_constructors
          MyTask(
            id: "DS0301OR0000001",
            address: "г. Дагестанские Огни, ул. Михаила Ивановича Калинина, 1А",
          ),
          MyTask(
            id: "DS0301OR0000002",
            address: "г. Дагестанские Огни, ул. Революции, 28",
          ),
          
          MyTask(
            id: "DS0301OR0000003",
            address: "г. Дагестанские Огни, ул. Александра Сергеевича Пушкина, 32",
          ),
          MyTask(
            id: "DS0301OR0000004",
            address: "г. Дагестанские Огни, ул. Революции, 52",
          ),
          MyTask(
            id: "DS0301OR0000004",
            address: "г. Дагестанские Огни, ул. Революции, 52",
          ),
          MyTask(
            id: "DS0301OR0000005",
            address: "г. Дагестанские Огни, ул. Валерия Павловича Чкалова, 7",
          ),
          MyTask(
            id: "DS0301OR0000006",
            address: "г. Дагестанские Огни, ул. Александра Сергеевича Пушкина, 2",
          ),
          MyTask(
            id: "DS0301OR0000007",
            address: "г. Дагестанские Огни, ул. пер Ильича, 4",
          ),
          MyTask(
            id: "DS0301OR0000008",
            address: "г. Дагестанские Огни, ул. Ивана Владимировича Мичурина, 9",
          ),
          MyTask(
            id: "DS0301OR0000009",
            address: "г. Дагестанские Огни, пр-кт. Дагестанский",
          ),
          MyTask(
            id: "DS0301OR00000010",
            address: "г. Дагестанские Огни, ул. Анатолия Васильевича Луначарского, 1",
          ),
          
        ],
      ),
     )
    );
  }
}
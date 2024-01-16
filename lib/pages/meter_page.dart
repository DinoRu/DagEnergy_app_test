// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {

  final  now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd').format(DateTime.now());
  File ? _image;
  TextEditingController _meterReadingController = TextEditingController();
  late Database _database;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'images.db');

    _database = await openDatabase(path, version: 1, 
        onCreate: (Database db, version) async {
          await db.execute(
            'CREATE TABLE Images (id INTEGER PRIMARY KEY, path TEXT, meterReading INTEGER)'
          );
        }
      );
  }
  
  Future<void> _takePicture() async {
    
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null){
        _image = File(pickedFile.path);
      }
    });
  }

  

 
  @override
  Widget build(BuildContext context) {

    Future<void> _saveToDatabase() async {
    

      if ( _image != null && _meterReadingController.text.isNotEmpty){
        int id = await _database.insert('Images',
          {
            'path': _image!.path,
            'meterReading': int.parse(_meterReadingController.text),
          }
          
          );
          if (id != -1) {
            print("Donnee sauvegarder avec success avec l'ID: $id");
             //Clear fields after save
            _image = null;
            _meterReadingController.clear();
            setState(() {});
            Navigator.pop(context);
          } else {
            print("Erreur de sauvegarde!");
          }

         
      } else {
        // Display error message 
       final snackBar = SnackBar(
        content: Text('Please enter the number of meter and an image!'),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
  }


  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Tracking", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Icon(Icons.list)
        ],
      ),
    ),
    body: Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Text("Id: "),
                Text("DS0301OR0000001")
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Last Month tracking: "),
                Text("18398")
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Current month tracking:"),
                Container(
                  height: 50,
                  width: 100,
                  child: TextFormField(
                    controller: _meterReadingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Type number of meter",
                      border: InputBorder.none
                    ),
                ))
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date :"),
                Text('$formatter'),
              ],
            ),
            Divider(),
              _image != null ? Image.file(_image!, height: 100): Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                _takePicture();
              }, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Take image "),
                  Icon(Icons.photo_camera)
                ])),
            SizedBox(height: 24),

            Container(
              width: double.infinity,
              child: RawMaterialButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: () => _saveToDatabase(), 
                fillColor: Colors.blue[200],
                child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_test/pages/login.dart';
import 'package:flutter_app_test/pages/meter_page.dart';
import 'package:flutter_app_test/profle_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'firebase_options.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
 _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // Initialize firebase app
 
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,);
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              return LoginScreen();
            }
            return const Center(
              child: CircularProgressIndicator()
            );
        },),
       );
  }
}


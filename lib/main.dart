import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_test/pages/meter_page.dart';
import 'package:flutter_app_test/profle_screen.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Login function
  static Future<User?> loginWhitEmailPassword(String email, String password, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email");
      }
    }
    return user;
  }


  @override
  Widget build(BuildContext context) {
    
    // Create the textfield controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();


    return Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Text("Login", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(
              height: 44.0,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "User email",
                prefixIcon: Icon(Icons.mail, color: Colors.black,)
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password..",
                prefixIcon: Icon(Icons.lock, color: Colors.black,)
              ),
            ),
             const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Don't remember your password ?", 
              style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
            ),
             const SizedBox(
              height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                elevation: 0.0,
                fillColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              onPressed: () async {
                //Let's test the app
                User? user = await loginWhitEmailPassword(_emailController.text, _passwordController.text, context);
                print(user);
                if (user != null){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen()));
                }
              },
              child: Text("Login", style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      );
  }
}

   
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_test/pages/meter_page.dart';
import 'package:flutter_app_test/profle_screen.dart';



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


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
         Image.asset('assets/bg.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Container( 
              padding: EdgeInsets.fromLTRB(25, 50, 25, 20),
              child: SingleChildScrollView( 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text("Sign in", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 40.0,),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration( 
                        label: Text('Username/Email', style: TextStyle(color: Colors.white),),
                        suffixIcon: Icon(Icons.mail, color: Colors.white,),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        fillColor: Colors.white
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration( 
                        label: Text('Password', style: TextStyle(color: Colors.white),),
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.white,),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        )
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Don't remember your password ?", 
                      style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 88.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: RawMaterialButton(
                        elevation: 0.0,
                        fillColor: Colors.black54,
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
                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    )
                  ],
                ),
              ),
            )
          ],
         )
        
        ],
      ),
    );
  }
}




    
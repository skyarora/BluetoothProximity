import 'package:bluetoothprox/rounded_password_field.dart';
import 'package:bluetoothprox/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'hello.dart';
import 'constants.dart';
import 'login_background.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'rounded_button.dart';
import 'rounded_input_field.dart';
import 'already_have_an_account_acheck.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showProgress,
      child: BackgroundLogin(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login Page",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(
                    height: 20.0,
                  ),

                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),








                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value; // get value from TextField
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                        border:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                      icon: Icon(
                      Icons.attach_email,
                      color: kPrimaryColor,
                    ),
                    ),
            ),
                    /*decoration: InputDecoration(
                        hintText: "Enter your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),*/








                  /*RoundedInputField(
                    //keyboardType: TextInputType.emailAddress,
                    *//*textAlign: TextAlign.center,
*//*                  onChanged: (value) {
                      email = value; // get value from TextField
                    },
                    *//*decoration: InputDecoration(
                        hintText: "Enter your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),*//*
                  ),*/
                  SizedBox(
                    height: 20.0,
                  ),
                  /*RoundedPasswordField(
                    *//*obscureText: true,
                    textAlign: TextAlign.center,*//*
                    onChanged: (value) {
                      password = value; //get value from textField
                    },*/





              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value; //get value from textField
                },
                decoration: InputDecoration(
                    hintText: "Enter your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),











                   /* decoration: InputDecoration(
                        hintText: "Enter your Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)))),*/

                  SizedBox(
                    height: 20.0,
                  ),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      showProgress = true;
                    }
                    );
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      print(newUser.toString());
                      if (newUser != null)
                      {
                        Fluttertoast.showToast(
                            msg: "Login Successfull",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FindDevicesScreen()));

                        setState(() {
                          showProgress = false;
                        });
                      }
                      else
                      {
                        Fluttertoast.showToast(
                            msg: "Enter Valid email..",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FindDevicesScreen()));

                        setState(() {
                          showProgress = false;
                        });
                        //AlertDialog(title: Text("Enter Email and Password..."));
                      }
                    } catch (e) {}
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Login",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),

                  ),

                ),
              ),
                SizedBox(height: size.height * 0.03),
/*    AlreadyHaveAnAccountCheck(
      press: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) {
      return MyHomePage();
      },),
      );
      },
      ),*/
                ],
              ),
            ),
          ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/starting_screens/login/register_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_auth/email_auth.dart';

import 'package:salon_app/Home_page/HomePage.dart';

import 'package:http/http.dart' as http;
import '../../constants.dart';

late String _userUid;
late var _OTP;

var number = 10;
bool result = false;
EmailAuth emailAuth = new EmailAuth(sessionName: "Check session");

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  // final _auth = FirebaseAuth.instance;
  //  late User logInUser;
  //late String Username;

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        ?.showSnackBar(new SnackBar(content: new Text(value)));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey.shade200,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('images/verify.png'),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Text("Email Verification",
                        style: GoogleFonts.lato(
                            fontSize: 38.0, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 26.0,
                    ),
                    Text(
                      'Enter the code sent to you email\n$email_register',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 00.0),
                      child: TextField(
                        onChanged: (value) {
                          _OTP = value;
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Code',
                            hintText: 'Enter the code here '),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatButton(
                        onPressed: () => sendOtp(context),
                        child: const Text(
                          'Resend Code',
                          style:
                              TextStyle(color: Colors.orange, fontSize: 18.0),
                        )),
                    const SizedBox(
                      height: 32.0,
                    ),
                    FlatButton(
                      height: 50.0,
                      color: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: const Text(
                        "VERIFY & PROCEED",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                      onPressed: () async {
                        bool result = emailAuth.validateOtp(
                            recipientMail: email_register, userOtp: _OTP);
                        if (result) {
                          if (kDebugMode) {
                            print("Code verified");
                          }
                          try {
                            Register(email_register, name_register,
                                number_register, password_register, context);
                          } catch (e) {
                            print(e);
                            showInSnackBar('Account Already Exist');
                          }
                        } else {
                          showInSnackBar('Wrong Code');
                        }

                        // if(number == 100)
                        //   {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => Home_page()),
                        //     );
                        //   }
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

void sendOtp(BuildContext context) async {
  bool result =
      await emailAuth.sendOtp(recipientMail: email_register, otpLength: 5);

  if (result) {
    if (kDebugMode) {
      print("Email Sent");
    }
  } else {
    _onAlertButtonPressed1(context);
  
  }
}

_onAlertButtonPressed1(context) {
  AlertDialog alert = AlertDialog(
    title: Text('Sorry Server down'),
    content: Text('Try after some delay'),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> Register(String emailtxt, String name, String number,
    String password, BuildContext context) async {
  var response = await http.post(Uri.parse(url_register), body: {
    'email': emailtxt,
    'name': name,
    'number': number,
    'password': password
  });
  var register_response = await jsonDecode(response.body);
  if (kDebugMode) {
    print(response.body);
  }

  final prefs = await SharedPreferences.getInstance();

  if (register_response == "Success") {
    prefs.setString('register', emailtxt);
    prefs.setString('customer', name);
    customer_name = prefs.getString('customer');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home_Page_Screen()),
    );
  }
}

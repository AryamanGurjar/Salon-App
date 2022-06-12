import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salon_app/starting_screens/components/rounded_button.dart';
import 'package:salon_app/starting_screens/components/rounded_input.dart';
import 'package:salon_app/starting_screens/components/rounded_password_input.dart';
import 'package:salon_app/starting_screens/login/forgetPassword.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Home_page/HomePage.dart';
import '../../constants.dart';

var email_login;
var password_login;
var name_login = '123';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 79,
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: 40),
                RoundedInput(
                  icon: Icons.mail,
                  hint: 'email',
                  value: (String value_input) {
                    email_login = value_input;
                  },
                ),
               
                RoundedPasswordInput(
                  hint: 'Password',
                  value: (String value_input) {
                    password_login = value_input;
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forgetpassword()));
                    },
                    child: const Text(
                      'Forget Password ?',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )),
                SizedBox(height: 10),
                RoundedButton(
                  title: 'LOGIN',
                  ontap: () {
                    if (email_login != null && password_login != null) {
                      Login(email_login, password_login, context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> Login(
    String emailtxt, String password, BuildContext context) async {
  var response = await http.post(Uri.parse(url_login),
      body: {'email': emailtxt, 'password': password});
  var login_data = await jsonDecode(response.body);
  if (emailtxt != Null && password != Null) {
    final prefs = await SharedPreferences.getInstance();

    //   Navigator.push(
    //     //todo
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const Home_Page_Screen()),
    //   );

    if (login_data.toString() == "Success") {
      prefs.setString('customer', name_login);
      customer_name = prefs.getString('customer');
      prefs.setString('Login', emailtxt);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home_Page_Screen()),
      );
    } else {
      print('not exist enter');
      _onAlertButtonPressed1(context);
    }
  }
}

_onAlertButtonPressed1(context) {
  AlertDialog alert = AlertDialog(
    title: Text('Account Not Exists'),
    content: Text("Please Sign up first"),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

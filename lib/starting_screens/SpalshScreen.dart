import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_app/Home_page/HomePage.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salon_app/starting_screens/Login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:salon_app/constants.dart';
import 'dart:io';

import '../intro.dart';
import '../shopowner/customerpage.dart';

class Splash_Screen_Screen extends StatefulWidget {
  @override
  _Splash_Screen_ScreenState createState() => _Splash_Screen_ScreenState();
}

class _Splash_Screen_ScreenState extends State<Splash_Screen_Screen> {
  @override
  Future<void> checkconnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getString('register') != null ||
            prefs.getString('Login') != null) {
          try {
            var response = await http.get(Uri.parse(url_getdata));
            var data = await jsonDecode(response.body);
            setState(() {
              Salon_image = data;
            });
          } catch (e) {
            print(e);
          }

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home_Page_Screen()));
        } else if (prefs.getString('id') != null &&
            prefs.getString('email_owner') != null &&
            prefs.getString('num') != null) {
          try {
            final prefs = await SharedPreferences.getInstance();
            var res = await http.post(Uri.parse(url_ownerdetail), body: {
              'id': prefs.getString('id'),
              'email': prefs.getString('email_owner'),
              'number': prefs.getString('num')
            });
            var data = await jsonDecode(res.body);

            setState(() {
              OwnerDetail = data;
            });

            var res_2 = await http.post(Uri.parse(url_todaysbooking),
                body: {'id': prefs.getString('id')});
            var data_2 = await jsonDecode(res_2.body);
            setState(() {
              TodayBooking = data_2;
            });

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => customer()));
          } catch (e) {
            print(e);
          }
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => App()));
        }
      }
    } on SocketException catch (_) {
      print('socket');
      _showAlertDialog(
          context, 'Connection Failed', 'Turn on your internet connection');
    }
  }

  @override
  void initState() {
    super.initState();

    checkconnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("images/splash.png"), fit: BoxFit.cover)),
    );
    //  child: Image.asset('images/splash.png'));
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}

_showAlertDialog(BuildContext context, first, second) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      SystemNavigator.pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(first),
    content: Text(second),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

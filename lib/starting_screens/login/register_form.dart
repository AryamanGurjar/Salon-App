import 'package:flutter/material.dart';

import 'package:salon_app/starting_screens/components/rounded_button.dart';
import 'package:salon_app/starting_screens/components/rounded_input.dart';
import 'package:salon_app/starting_screens/components/rounded_password_input.dart';
import 'package:salon_app/starting_screens/emailverify.dart';



var email_register;
var password_register;
var name_register;
var number_register;

class RegisterForm extends StatelessWidget {
  const RegisterForm({
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
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),

                  Text(
                    'Welcome',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),

                  SizedBox(height: 40),

                  SizedBox(height: 40),

                  RoundedInput(
                    icon: Icons.mail,
                    hint: 'email',
                    value: (String value_input) {
                      email_register = value_input;
                    },
                  ),
                    RoundedInput(
                    icon: Icons.phone,
                    hint: 'Number without +91',
                    value: (String value_input) {
                      number_register = value_input;
                    },
                  ),

                  RoundedInput(
                    icon: Icons.face,
                    hint: 'Name',
                    value: (String value_input) {
                      name_register = value_input;
                    },
                  ),

                  RoundedPasswordInput(
                    hint: 'Password',
                    value: (String value_input) {
                      password_register = value_input;
                    },
                  ),

                  SizedBox(height: 10),

                  RoundedButton(
                    title: 'SIGN UP',
                    ontap: () {
                         if (email_register!=null &&number_register!=null && name_register!= null&& password_register!= null) {
               sendOtp(context);  

                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Verification()));          
                        }
                     

                   
                    },
                  ), //ass register

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:salon_app/constants.dart';
import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({Key? key, required this.icon, required this.hint,required this.value})
      : super(key: key);

  final IconData icon;
  final String hint;
  final  Function(String value_input) value;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
            onChanged: value,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none),
    ));
  }
}

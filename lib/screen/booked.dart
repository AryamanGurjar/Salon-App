import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';




next(BuildContext context) {
  Future.delayed(Duration(seconds: 3), () {
   
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 4;
    });
  });
}

class Booked extends StatefulWidget {
  const Booked({Key? key}) : super(key: key);

  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 220, 249, 250),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 200),
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 194, 253, 255),
                            borderRadius: BorderRadius.circular(40.0)),
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Expanded(
                                child: RiveAnimation.asset(
                                    'rive/_check_icon.riv')),
                            Text(
                              "Booked",
                              style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Color(0xFF40bbc0)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

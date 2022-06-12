import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salon_app/screen/booked.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/constants.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Time_Slot extends StatefulWidget {
  const Time_Slot({Key? key}) : super(key: key);

  @override
  State<Time_Slot> createState() => _Time_SlotState();
}

class _Time_SlotState extends State<Time_Slot> {
  bool gettime(String time) {
    String changetimeformate = time[time.length - 2] + time[time.length - 1];
    int hr, min, sec;

    if (changetimeformate == 'PM' &&
        int.parse(time[0]) * 10 + int.parse(time[1]) != 12) {
      hr = 12 + int.parse(time[1]);
    } else {
      hr = int.parse(time[0]) * 10 + int.parse(time[1]);
    }
    min = int.parse(time[3]) * 10 + int.parse(time[4]);
    sec = int.parse(time[6]) * 10 + int.parse(time[7]);

    if (hr < int.parse(tdata[0]) * 10 + int.parse(tdata[1]) &&
        int.parse(tdata[0]) * 10 + int.parse(tdata[1]) <= 17 &&
        int.parse(tdata[0]) * 10 + int.parse(tdata[1]) >= 7) {
      return false;
    } else if (hr == int.parse(tdata[0]) * 10 + int.parse(tdata[1]) &&
        int.parse(tdata[0]) * 10 + int.parse(tdata[1]) <= 17 &&
        int.parse(tdata[0]) * 10 + int.parse(tdata[1]) >= 7) {
      if (min < int.parse(tdata[3]) * 10 + int.parse(tdata[4])) {
        return false;
      } else if (min == int.parse(tdata[3]) * 10 + int.parse(tdata[4])) {
        if (sec <= int.parse(tdata[6]) * 10 + int.parse(tdata[7])) {
          return false;
        }
      }
    }

    return true;
  }

  Future<void> dobooking(String time_book) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = await http.post(Uri.parse(url_booking), body: {
        'salonid': salon_id.toString(),
        'name': prefs.getString('register') != null
            ? prefs.getString('register').toString()
            : prefs.getString('Login').toString(),
        'time': time_book.toString(),
        'type': choice.toString()
      });
      var data = await jsonDecode(res.body);
      print(res.body);
      if (data.toString() == 'Success') {
        

        next(context);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Booked()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(),
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0))),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Time Slots',
                style: GoogleFonts.ubuntu(
                    fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: TimeSlot.length,
                  itemBuilder: (context, index) {
                    if (gettime(TimeSlot[index]['time_slot_start']) == true) {
                      return GestureDetector(
                          onTap: () {
                            _onAlertButtonPressed1(context);
                            dobooking(TimeSlot[index]['time_slot_start']);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                            child: Material(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: kPrimaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      TimeSlot[index]['time_slot_start'] +
                                          ' - ' +
                                          TimeSlot[index]['time_slot_end'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.white, fontSize: 24.0),
                                    ),
                                  )),
                            ),
                          ));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                        child: Material(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromARGB(255, 174, 190, 201),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  TimeSlot[index]['time_slot_start'] +
                                      ' - ' +
                                      TimeSlot[index]['time_slot_end'] +
                                      '\nNot Available',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.white, fontSize: 24.0),
                                ),
                              )),
                        ),
                      );
                    }
                    //if
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Color.fromARGB(255, 252, 252, 252),
            onPressed: () {
              int count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 2;
              });
            },
            label: Text(
              'Back',
              style: GoogleFonts.ubuntu(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
      ),
    );
  }
}

_onAlertButtonPressed1(context) {
  AlertDialog alert = AlertDialog(
    title: Text('Booking Slot'),
    content: LinearProgressIndicator(
      color: kPrimaryColor,
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/constants.dart';
import 'package:salon_app/screen/available_time_slot.dart';
import 'package:http/http.dart' as http;

class Salon_screen extends StatefulWidget {
  const Salon_screen({Key? key}) : super(key: key);

  @override
  State<Salon_screen> createState() => _Salon_screenState();
}

class _Salon_screenState extends State<Salon_screen> {
  Future<void> getslot() async {
    var res = await http.post(Uri.parse(url_timeslot),
        body: {'salonid': salon_id.toString()}); //do it
    var data = await jsonDecode(res.body);
    setState(() {
      TimeSlot = data;
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Time_Slot()));
  }

  Future<dynamic> botom_sheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //   const Padding(
                //     padding: EdgeInsets.only(left: 120.0, right: 120.0),
                //     child: Divider(
                //       color: Colors.black,
                //       thickness: 5.0,
                //     ),
                //   ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        elevation: 5.0,
                        color: Color.fromARGB(255, 225, 234, 237),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset(
                              'images/haircut.png',
                              height: 95.0,
                              width: 95.0,
                            ),
                            Text('Haircut',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 24.0,
                                ))
                          ],
                        ),
                        onPressed: () {
                          getslot();
                          choice = 'Haircut';
                        }),
                    MaterialButton(
                        elevation: 5.0,
                        color: Color.fromARGB(255, 225, 234, 237),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset('images/beard.png'),
                            Text('Beard',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 24.0,
                                ))
                          ],
                        ),
                        onPressed: () {
                          getslot();
                          choice = 'Beard';
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: MaterialButton(
                      elevation: 5.0,
                      color: Color.fromARGB(255, 225, 234, 237),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/haircut.png',
                                height: 120.0,
                                width: 120.0,
                              ),
                              Text(
                                '+',
                                style: TextStyle(fontSize: 70.0),
                              ),
                              Image.asset('images/beard.png'),
                            ],
                          ),
                          Text('Haircut   &   Beard',
                              style: GoogleFonts.ubuntu(
                                fontSize: 24.0,
                              ))
                        ],
                      ),
                      onPressed: () {
                        getslot();
                        choice = 'Haircut & Beard';
                      }),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                width: double.infinity,
                child: Image(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(uploaded_images +
                        Salon_image[card_position]['image_name'])),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0, left: 6.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(85.0, 8.0, 85.0, 0.0),
                        child: Divider(
                          color: Colors.black,
                          thickness: 5,
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(Salon_image[card_position]['Name'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                              fontSize: 35.0, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(Salon_image[card_position]['address'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                              fontSize: 20.0, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(Salon_image[card_position]['number'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                            fontSize: 18.0,
                          )),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 5.0,
                            color: kPrimaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Back',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 45.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 5.0,
                            color: kPrimaryColor,
                            onPressed: () {
                              botom_sheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Book',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 45.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

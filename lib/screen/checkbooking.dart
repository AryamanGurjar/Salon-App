import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/constants.dart';

import 'package:url_launcher/url_launcher.dart';

class CheckBooking extends StatelessWidget {
  const CheckBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Your Bookings',
            style:
                GoogleFonts.ubuntu(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: checkbooking.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            checkbooking[index]['time_slot_start'] +
                                ' - ' +
                                checkbooking[index]['time_slot_end'],
                            style: GoogleFonts.ubuntu(fontSize: 18),
                          ),
                          card_row(
                            icon: Icons.store,
                            text: checkbooking[index]['Name'],
                          ),
                          card_row(
                            icon: Icons.accessibility_new_sharp,
                            text: checkbooking[index]['type'],
                          ),
                          card_row(
                            icon: Icons.directions,
                            text: checkbooking[index]['address'],
                          ),
                          card_row(
                            icon: Icons.email,
                            text: checkbooking[index]['email'],
                          ),
                          card_row(
                            icon: Icons.phone,
                            text: checkbooking[index]['number'],
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () async {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: "+91" + checkbooking[index]['number'],
                              );
                              await launch(launchUri.toString());
                            },
                            color: const Color.fromARGB(255, 100, 183, 251),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class card_row extends StatelessWidget {
  final String text;
  final IconData icon;
  card_row({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 8,
        ),
        Flexible(child: Text(text)),
      ],
    );
  }
}

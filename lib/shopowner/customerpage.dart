import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class customer extends StatefulWidget {
  const customer({Key? key}) : super(key: key);

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {
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

  Future<void> UpdateScreen() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res_2 = await http.post(Uri.parse(url_todaysbooking),
          body: {'id': prefs.getString('id')});
      var data_2 = await jsonDecode(res_2.body);
      setState(() {
        TodayBooking = data_2;
      });
    } catch (e) {
      print(e);
    }
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(minutes: 10), (Timer t) => UpdateScreen());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 199, 230, 255),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(OwnerDetail[0]['Name'],
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ) //TextStyle
                      ), //Text
                  background: Image.network(
                    uploaded_images + OwnerDetail[0]['image_name'],
                    fit: BoxFit.cover,
                  ) //Images.network
                  ), //FlexibleSpaceBar
              expandedHeight: 230,
              backgroundColor: Colors.blue,
              //IconButton
              //<Widget>[]
            ), //SliverAppBar
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (gettime(TodayBooking[index]['time_slot_start']) == true) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 12, 0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 68, 171, 255),
                                Color.fromARGB(255, 46, 161, 255),
                              ]),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text(
                                  TodayBooking[index]['time_slot_start'] +
                                      ' - ' +
                                      TodayBooking[index]['time_slot_end'],
                                  style: GoogleFonts.ubuntu(fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Booking_card_row(
                                  card_icon: Icons.face,
                                  card_text: TodayBooking[index]['name'],
                                ),
                                Booking_card_row(
                                  card_icon: Icons.accessibility_new_sharp,
                                  card_text: TodayBooking[index]['type'],
                                ),
                                Booking_card_row(
                                  card_icon: Icons.phone,
                                  card_text: TodayBooking[index]['number'],
                                ),
                                const SizedBox(height: 8),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  onPressed: () async {
                                    final Uri launchUri = Uri(
                                      scheme: 'tel',
                                      path:
                                          "+91" + TodayBooking[index]['number'],
                                    );
                                    await launch(launchUri.toString());
                                  },
                                  color: const Color.fromARGB(255, 60, 190, 255),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(90, 2, 90, 2),
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 12, 0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 195, 206, 215),
                                Color.fromARGB(255, 162, 168, 173),
                              ]),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text(
                                  TodayBooking[index]['time_slot_start'] +
                                      ' - ' +
                                      TodayBooking[index]['time_slot_end'],
                                  style: GoogleFonts.ubuntu(fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Booking_card_row(
                                  card_icon: Icons.face,
                                  card_text: TodayBooking[index]['name'],
                                ),
                                Booking_card_row(
                                  card_icon: Icons.accessibility_new_sharp,
                                  card_text: TodayBooking[index]['type'],
                                ),
                                Booking_card_row(
                                  card_icon: Icons.phone,
                                  card_text: TodayBooking[index]['number'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                } //ListTile
                ,
                childCount: TodayBooking.length,
              ), //SliverChildBuildDelegate
            ) //SliverList
          ], //<Widget>[]
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color.fromARGB(255, 93, 172, 250),
            onPressed: () {
              UpdateScreen();
            },
            label: Text(
              'Refresh',
              style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
            ),
            icon: const Icon(Icons.refresh)), //CustonScrollView
      ),
    );
  }
}

class Booking_card_row extends StatelessWidget {
  final String card_text;
  final IconData card_icon;

  Booking_card_row({required this.card_icon, required this.card_text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          card_icon,
          color: const Color.fromARGB(255, 207, 233, 255),
          size: 30,
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Text(
            card_text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'package:salon_app/constants.dart';
import 'package:salon_app/Home_page/search_location.dart';

import '../screen/bookscreen.dart';

List SearchLocationDetail = [];

class SalonsSearch extends StatefulWidget {
  const SalonsSearch({Key? key}) : super(key: key);

  @override
  State<SalonsSearch> createState() => _SalonsSearchState();
}

class _SalonsSearchState extends State<SalonsSearch> {
  Future<void> locationSearch() async {
    try {
      var res = await http
          .post(Uri.parse(url_search), body: {'search': placedsearch});
      var data = await jsonDecode(res.body);
      print(res.body);
      setState(() {
        SearchLocationDetail = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationSearch();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg2.gif"), fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: SearchLocationDetail.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          salon_id =
                              int.parse(SearchLocationDetail[index]['salonid']);
                          String for_card =
                              SearchLocationDetail[index]['salonid'];
                          card_position = int.parse(for_card) - 1;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Salon_screen()));
                        },
                        child: Card(
                          shadowColor: Color.fromARGB(255, 0, 2, 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: kCardColor,
                          elevation: 4.0,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 140,
                                    width: 180,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.fill,
                                        image: NetworkImage(uploaded_images +
                                            SearchLocationDetail[index]
                                                ['image_name']),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Flexible(
                                      child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: SearchLocationDetail[index]
                                            ['Name'],
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 20, color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: '\n\n' +
                                                  SearchLocationDetail[index]
                                                      ['address'],
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 15.0,
                                                  color: Colors.black))
                                        ]),
                                  )),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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

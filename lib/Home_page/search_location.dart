import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/Home_page/locations.dart';
import 'package:salon_app/Home_page/HomePage.dart';

List<String> searchedTerms = [];
String? placedsearch;



class CustomSearchDelegate extends SearchDelegate {



  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var place in searchedTerms) {
      if (place.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(place);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, i) {
          var result = matchQuery[i];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  placedsearch = result;
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonsSearch(),
                      
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    result,
                    style:
                        GoogleFonts.ubuntu(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
              const Divider(),
            ],
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var place in searchedTerms) {
      if (place.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(place);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, i) {
          var result = matchQuery[i];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                 
                  placedsearch = result;
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonsSearch(),
                       
                    ),
                  );
                
                },
                child: ListTile(
                  title: Text(
                    result,
                    style:
                        GoogleFonts.ubuntu(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
              const Divider(),
            ],
          );
        });
  }
}

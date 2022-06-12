import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:salon_app/constants.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salon_app/screen/checkbooking.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../starting_screens/SpalshScreen.dart';

File? user_image;
var username = "";
var email_profile;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> showbookedslot(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var res = await http.post(Uri.parse(url_checkbooking), body: {
      'email': prefs.getString('register') != null
          ? prefs.getString('register')
          : prefs.getString('Login')
    });
    var data = await jsonDecode(res.body);

    setState(() {
      checkbooking = data;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckBooking(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Color(0xFF255BC1),
          title: Text('PROFILE',
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold, fontSize: 35.0)),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/p.gif"), fit: BoxFit.cover)),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Material(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70.0,
                        backgroundImage: user_image == null
                            ? null
                            : FileImage(File(user_image!.path))
                                as ImageProvider,
                      ),
                      Positioned(
                          bottom: 0,
                          right: -15,
                          child: TextButton(
                              onPressed: () {
                                botom_sheet(context);
                              },
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                elevation: 5.0,
                                shadowColor: Colors.black,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color(0xFF255BC1),
                                  size: 35.0,
                                ),
                              ))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Name',
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 40.0),
                ),
                Text(
                  username == null ? 'user' : username,
                  style:
                      GoogleFonts.ubuntu(fontSize: 20.0, color: Colors.white),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Text(
                  'Email Id',
                  style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 40.0),
                ),
                Text(
                  email_profile.toString(),
                  style:
                      GoogleFonts.ubuntu(fontSize: 20.0, color: Colors.white),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                MaterialButton(
                  height: 65.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 5.0,
                  onPressed: () {
                    showbookedslot(context);
                  },
                  color: Color(0xFF4E97EB),
                  child: Text('Check Bookings',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white, fontSize: 40.0)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                  child: MaterialButton(
                    height: 65.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 5.0,
                    onPressed: () {
                      Logout(context);
                    },
                    color: Color(0xFF4E97EB),
                    child: Center(
                      child: Text('Log Out',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white, fontSize: 40.0)),
                    ),
                  ),
                )
              ])),
        ),
      ),
    );
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
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 150.0, right: 150.0),
                  child: Divider(
                    color: kPrimaryColor,
                    thickness: 5.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        elevation: 30.0,
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final photo = await _picker.getImage(
                              source: ImageSource.camera);

                          setState(() {
                            if (File(photo!.path) != null) {
                              user_image = File(photo.path);
                            }
                          });
                          if (user_image != null) {
                            uploadimage(photo);
                          }
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: kPrimaryColor,
                          size: 40.0,
                        )),
                    MaterialButton(
                        elevation: 30.0,
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final photo = await _picker.getImage(
                              source: ImageSource.gallery);

                          setState(() {
                            if (File(photo!.path) != null) {
                              user_image = File(photo.path);
                            }
                          });

                          if (user_image != null || user_image != '') {
                            uploadimage(photo);
                          }
                        },
                        child: const Icon(
                          Icons.image_sharp,
                          color: kPrimaryColor,
                          size: 40.0,
                        ))
                  ],
                ),
              ],
            ),
          );
        });
  }
}

Future<void> uploadimage(var photo) async {
  var response = await http.post(Uri.parse(url_UploadImage),
      body: {'email': email_profile, 'Profile_Picture': photo.path.toString()});
  print(response.body);

//   var stream =
//       new http.ByteStream(DelegatingStream.typed(user_image!.openRead()));
//   // get file length
//   var length = await user_image!.length();

//   // string to uri
//   var uri = Uri.parse(url_UploadImage);

//   // create multipart request
//   var request = new http.MultipartRequest("POST", uri);

//   // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
//   request.fields["email"] = email_profile;

//   // multipart that takes file.. here this "image_file" is a key of the API request
//   var multipartFile = new http.MultipartFile('Profile_Picture', stream, length,
//       filename: basename(user_image!.path));

//   // add file to multipart
//   request.files.add(multipartFile);

//   // send request to upload image
//   await request.send().then((response) async {
//     // listen for response
//     response.stream.transform(utf8.decoder).listen((value) {
//       print(value);
//     });
//   }).catchError((e) {
//     print(e);
//   });
}

getProfiledetail(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('register') != null) {
    email_profile = prefs.getString('register');
  } else {
    email_profile = prefs.getString('Login');
  }

  var response = await http
      .post(Uri.parse(url_userdetail), body: {'email': email_profile});
  var data = await jsonDecode(response.body);

  username = data[0]['name'].toString();
}

Future<void> Logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Login(),
    ),
  );
}

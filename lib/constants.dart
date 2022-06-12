import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

late int card_position;
const kPrimaryColor = Color(0XFF005B96);
const kBackgroundColor = Color(0XFFE5E5E5);
const kCardColor = Color.fromARGB(255, 243, 242, 242);
var url_register = 'https://salonappmysql.000webhostapp.com/register.php';
var url_login = 'https://salonappmysql.000webhostapp.com/login.php';
var url_logout = 'https://salonappmysql.000webhostapp.com/logout.php';
var url_userdetail = 'https://salonappmysql.000webhostapp.com/user_data.php';
var url_UploadImage = 'https://salonappmysql.000webhostapp.com/uploadimage.php';
var url_getdata = 'https://salonappmysql.000webhostapp.com/nearby.php';

var url_search =
    'https://salonappmysql.000webhostapp.com/searched_location.php';
var url_timeslot = 'https://salonappmysql.000webhostapp.com/Timeslot.php';
var url_forgetpassword =
    'https://salonappmysql.000webhostapp.com/forgetpassword.php';
var url_checkbooking =
    'https://salonappmysql.000webhostapp.com/checkbooking.php';
var url_change_password =
    'https://salonappmysql.000webhostapp.com/changepassword.php';
var url_booking = 'https://salonappmysql.000webhostapp.com/booking.php';
var url_ownerdetail = 'https://salonappmysql.000webhostapp.com/ownerdetail.php';
var url_todaysbooking =
    'https://salonappmysql.000webhostapp.com/owner_booking_data.php';
var uploaded_images = 'https://salonappmysql.000webhostapp.com/salon_image/';

late int salon_id;
String? choice;
List TodayBooking = [];
String tdata = DateFormat("HH:mm:ss").format(DateTime.now());
List Salon_image = [];
List TimeSlot = [];
List OwnerDetail = [];
String? customer_name;
bool loading_ts = true;
List checkbooking = [];

//alert dialog



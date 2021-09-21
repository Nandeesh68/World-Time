import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  bool isDaytime = true;
  String location = ""; // Location name for the UI
  String time = ""; //the time in that location
  String helo = "";
  String flag = ""; //url to an assest flag icon
  String url = ""; // Location url for the api endpoint

  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> get getData async {
    try {
      //make a request
      String link = "http://worldtimeapi.org/api/timezone/$url";
      Response response = await get(Uri.parse(link));
      Map data = jsonDecode(response.body);
      //print(data);
      //get prorperty from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1, 3);
      String offsetMin = data['utc_offset'].toString().substring(4, 6);
      //print(datetime);
      //print(offset);

      //create Date time object

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset), minutes: int.parse(offsetMin)));

      // Set time property
      isDaytime = now.hour < 18 && now.hour > 6 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error : $e');
      time = 'Could not get time data';
    }
  }
}

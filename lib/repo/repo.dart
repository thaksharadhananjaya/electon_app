import 'dart:convert';

import 'package:election_app/config.dart';
import 'package:election_app/db/db_helper.dart';
import 'package:http/http.dart' as http;

class Repo {
  static var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  static Future<void> addData(
      {String place,
      int userType,
      String file,
      int type,
      String remark,
      String phone,
      String email,
      double lat,
      double long}) async {
    print(place);
    print(userType);
    print(file);
    print(type);
    print(remark);
    print(email);
    print(phone);
    print(long);
    print(lat);
    try {
      final response = await http.post(
          Uri.parse(
              "$URL/check-number-postmedia?place=$place&user_type=$userType"),
          body: json.encode({
            'remark': remark,
            'file': file,
            'type': type,
            'lat': lat,
            'long': long,
            'phone': phone,
            'email': email
          }),
          headers: headers);
      print(response.headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        DBHelper dbHelper = DBHelper();
        dbHelper.deleteDataOffline();
      }
    } catch (e) {
      addData(
          email: email,
          userType: userType,
          remark: remark,
          place: place,
          phone: phone,
          file: file,
          lat: lat,
          long: long);
    }
  }
}

import 'dart:convert';

import 'package:election_app/config.dart';
import 'package:election_app/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Repo {
  static var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  static Future<void> addData(
      {String file, int type, String remark, double lat, double long}) async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));

    debugPrint(
      user.toString(),
    );

    try {
      final response = await http.post(Uri.parse("$URL/mobile-postmedia"),
          body: json.encode({
            "user": user,
            "userdata_collate": {
              'remark': remark,
              'file': file,
              'type': type,
              'lat': lat,
              'long': long,
              'phone': user['phone'],
              'email': user['email']
            }
          }),
          headers: headers);
      //print(response.headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        DBHelper dbHelper = DBHelper();
        dbHelper.deleteDataOffline();
        
      }
    } catch (e) {
      addData(remark: remark, file: file, lat: lat, long: long);
    }
  }

  static Future<bool> addCollation(
      {String reg,
      String accredited,
      String rejected,
      String textA,
      String textAA,
      String textADP,
      String textAPP,
      String textAAC,
      String textADC,
      String textAPC,
      String textAPGA,
      String textAPM,
      String textBP,
      String textLP,
      String textNRM,
      String textNNPP,
      String textPDP,
      String textPRP,
      String textSDP,
      String textYPP,
      String textZLP}) async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));

    try {
      final response = await http.post(Uri.parse("$URL/mobile-submit"),
          body: json.encode({
            "user": user,
            "userdata_collate": {'phone': user['phone'], 'email': user['email']}
          }),
          headers: headers);
      //print(response.headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        DBHelper dbHelper = DBHelper();
        dbHelper.deleteDataOffline();
        return true;
      }
      
    } catch (e) {
      debugPrint(e);
      
    }
    return false;
  }

   static Future<bool> cancelCollation(
      {String reg,
      String accredited,
      String rejected,
      String textA,
      String textAA,
      String textADP,
      String textAPP,
      String textAAC,
      String textADC,
      String textAPC,
      String textAPGA,
      String textAPM,
      String textBP,
      String textLP,
      String textNRM,
      String textNNPP,
      String textPDP,
      String textPRP,
      String textSDP,
      String textYPP,
      String textZLP}) async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));

    try {
      final response = await http.post(Uri.parse("$URL/mobile-submit"),
          body: json.encode({
            "user": user,
            "userdata_collate": {'phone': user['phone'], 'email': user['email']}
          }),
          headers: headers);
      //print(response.headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        DBHelper dbHelper = DBHelper();
        dbHelper.deleteDataOffline();
        return false;
      }
    } catch (e) {
      debugPrint(e);
      
    }
    return true;
  }
}

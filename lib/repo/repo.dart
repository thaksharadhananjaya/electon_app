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
            }
          }),
          headers: headers);
      //print(response.headers);
     // print(response.statusCode);
      if (response.statusCode == 200) {
        DBHelper dbHelper = DBHelper();
        dbHelper.deleteDataOffline();
      }
    } catch (e) {
      addData(remark: remark, file: file, lat: lat, long: long);
    }
  }

  static Future addCollation(
      {int reg,
      int type,
      int accredited,
      int rejected,
      int textA,
      int textAA,
      int textADP,
      int textAPP,
      int textAAC,
      int textADC,
      int textAPC,
      int textAPGA,
      int textAPM,
      int textBP,
      int textLP,
      int textNRM,
      int textNNPP,
      int textPDP,
      int textPRP,
      int textSDP,
      int textYPP,
      int textZLP}) async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));

    try {
      final response = await http.post(
          Uri.parse(type == 0
              ? "$URL/mobile_submit"
              : (type == 1
                  ? "$URL/mobile_submit-senate"
                  : "$URL/mobile_submit-rep")),
          body: json.encode({
            "user": user,
            "userdata_collate": {
              'A': textA,
              'AA': textAA,
              'AAC': textAAC,
              'ADC': textADC,
              'ADP': textADP,
              'APC': textAPC,
              'APGA': textAPGA,
              'APM': textAPM,
              'APP': textAPP,
              'BP': textBP,
              'LP': textLP,
              'NNPP': textNNPP,
              'NRM': textNRM,
              'PDP': textPDP,
              'PRP': textPRP,
              'SDP': textSDP,
              'YPP': textYPP,
              'ZLP': textZLP,
              'Total_Accredited_voters': accredited,
              'Total_Registered_voters': reg,
              'Total_Rejected_votes': reg
            }
          }),
          headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data[0]);
        return {
          'success': true,
          'person': data['person_collated'],
          'time': data['time']
        };
      }
    } catch (e) {
      //debugPrint(e.toString());
    }
    return {'success': false};
  }

  static Future cancelCollation(
      {int reg,
      int type,
      int accredited,
      int rejected,
      int textA,
      int textAA,
      int textADP,
      int textAPP,
      int textAAC,
      int textADC,
      int textAPC,
      int textAPGA,
      int textAPM,
      int textBP,
      int textLP,
      int textNRM,
      int textNNPP,
      int textPDP,
      int textPRP,
      int textSDP,
      int textYPP,
      int textZLP}) async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));

    try {
      final response = await http.post(
          Uri.parse(type == 0
              ? "$URL/mobile-cancel"
              : (type == 1
                  ? "$URL/mobile-cancel-senate"
                  : "$URL/mobile-cancel-rep")),
          body: json.encode({
            "user": user,
            "userdata_collate": {
              'A': textA,
              'AA': textAA,
              'AAC': textAAC,
              'ADC': textADC,
              'ADP': textADP,
              'APC': textAPC,
              'APGA': textAPGA,
              'APM': textAPM,
              'APP': textAPP,
              'BP': textBP,
              'LP': textLP,
              'NNPP': textNNPP,
              'NRM': textNRM,
              'PDP': textPDP,
              'PRP': textPRP,
              'SDP': textSDP,
              'YPP': textYPP,
              'ZLP': textZLP,
              'Total_Accredited_voters': accredited,
              'Total_Registered_voters': reg,
              'Total_Rejected_votes': reg
            }
          }),
          headers: headers);
      //print(response.headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return {
          'success': false,
          'person': data['person_collated'],
          'time': data['time']
        };
      }
    } catch (e) {
      debugPrint(e);
    }
    return true;
  }
}

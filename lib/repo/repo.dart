import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:election_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Repo {
/*   static Future<List> getState() async {
    var response =
        await http.get(Uri.parse("${API_END_POINT}getState?key=$ACCESS_KEY"));
        

    List listState = json.decode(response.body);

    return listState;
  }

  static Future<List> getLGA(String state) async {
    var response = await http
        .get(Uri.parse("${API_END_POINT}getLGA?key=$ACCESS_KEY&name=$state"));
    print("${API_END_POINT}getLGA?key=$ACCESS_KEY&name=$state");

    List listLGA = json.decode(response.body);

    return listLGA;
  }

  static Future<List> getWard(String state, String lga) async {
    var response = await http.get(Uri.parse(
        "${API_END_POINT}getWard?key=$ACCESS_KEY&state=$state&lga=$lga"));

    List listWard = json.decode(response.body);

    return listWard;
  }

  static Future<List> getPol(String state, String lga, int wardID) async {
    var response = await http.get(Uri.parse(
        "${API_END_POINT}getPol?key=$ACCESS_KEY&state=$state&lga=$lga&wardID=$wardID"));

    List list = json.decode(response.body);
    List listWard = [];
    for (var data in list) {
      listWard.add(data['pu_code']);
    }
    return listWard;
  }
 */
  static Future<void> addData(
      {String state,
      String lga,
      String ward,
      String pu,
      String file,
      int type,
      String remark,
      double lat,
      double long,
      @required BuildContext context}) async {
    try {
      var response =
          await http.post(Uri.parse("${API_END_POINT}addData"), body: {
        'key': ACCESS_KEY,
        'state': state,
        'lga': lga,
        'ward': ward,
        'pu': pu,
        'file': file,
        'type': type.toString(),
        'remark': remark,
        'lat': lat.toString(),
        'long':long.toString()
      });
      print('output ${response.body}');
     
    } catch (e) {
      Flushbar(
        message: e.toString(),
        messageColor: Colors.red,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
      ).show(context);
    }
  }
}

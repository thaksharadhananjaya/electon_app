// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:election_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String welcomeText = '', avatarLink = '';
  @override
  void initState() {
    super.initState();
    getWelcome();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: avatarLink != ''
          ? SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DelayedDisplay(
                    delay: const Duration(microseconds: 200),
                    child: PhysicalModel(
                      color: Colors.black,
                      elevation: 6.0,
                      shape: BoxShape.circle,
                      child: CircleAvatar(
                        radius: 120.0,
                        backgroundImage: NetworkImage(avatarLink),
                        backgroundColor: kPrimeryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                 /*  const DelayedDisplay(
                    delay: Duration(microseconds: 700),
                    child: Text(
                      'Welcome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: kPrimeryColor),
                    ),
                  ), */
                  const SizedBox(
                    height: 8,
                  ),
                  DelayedDisplay(
                    delay: const Duration(seconds: 1),
                    child: Text(
                      welcomeText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void getWelcome() async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));
    //print("gg: $user");
     avatarLink = user['user']['aspirant_avatar'];
/* 
    setState(() {
     

      String country = user['user']['level_childs']['country'].toString() == ''
          ? ''
          : user['user']['level_childs']['country'].toString();
      String state = user['user']['level_childs']['sate'].toString() == ''
          ? ''
          : "/${user['user']['level_childs']['state']}";
      String lga = user['user']['level_childs']['lga'].toString() == ''
          ? ''
          : "/${user['user']['level_childs']['lga']}";
      String ward = user['user']['level_childs']['ward'].toString() == ''
          ? ''
          : "/${user['user']['level_childs']['ward']}";
      String pol = user['user']['level_childs']['pollingUnit'].toString() == ''
          ? ''
          : "/${user['user']['level_childs']['pollingUnit']}";
      welcomeText =
          "${user['user']['name']} to \n${user['type_of_election']} at $country$state$lga$ward$pol";
    }); */

    //String user_type = await storage.read(key: 'user_type');
    try {
      final response = await http.post(Uri.parse("$URL/mobile-message"),
          body:json.encode( user),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          });
  
        var data = jsonDecode(response.body);
        print(data);
        setState(() {
          welcomeText = data['message'].join("\n");
        });
   
    } catch (e) {
      // ignore: use_build_context_synchronously
      Flushbar(
        message: e.toString(),
        messageColor: Colors.red,
        //backgroundColor: kPrimeryColor,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
      ).show(context);
    }
  }
}

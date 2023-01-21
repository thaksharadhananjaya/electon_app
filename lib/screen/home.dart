// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:election_app/config.dart';
import 'package:flutter/material.dart';

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
                    height: 50,
                  ),
                  const DelayedDisplay(
                    delay: Duration(microseconds: 700),
                    child: Text(
                      'Welcome',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: kPrimeryColor),
                    ),
                  ),
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

    setState(() {
      avatarLink = user['aspirant_avatar'];
      String country = user['level_childs']['country'] == ''
          ? ''
          : user['level_childs']['country'];
      String state = user['level_childs']['sate'] == ''
          ? ''
          : "/${user['level_childs']['state']}";
      String lga = user['level_childs']['lga'] == ''
          ? ''
          : "/${user['level_childs']['lga']}";
      String ward = user['level_childs']['ward'] == ''
          ? ''
          : "/${user['level_childs']['ward']}";
      String pol = user['level_childs']['pollingUnit'] == ''
          ? ''
          : "/${user['level_childs']['pollingUnit']}";
      welcomeText =
          "${user['name']} to \n${user['type_of_election']} at $country$state$lga$ward$pol";
    });

    /*  String user_type = await storage.read(key: 'user_type');
    try {
      final response = await http.post(
          Uri.parse("$URL/check-number-data?place=$place&user_type=$user_type"),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          });
      setState(() {
        var data = jsonDecode(response.body);
        name = data[1];
        welcomeText = data[3];
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
    } */
  }
}

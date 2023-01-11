// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
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
  String name = '', welcomeText = '';
  @override
  void initState() {
    super.initState();
    getWelcome();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/welcome.png'),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 8,),
          Text(
            welcomeText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  void getWelcome() async {
    const storage = FlutterSecureStorage();
    String place = await storage.read(key: 'place');
    String user_type = await storage.read(key: 'user_type');
    try {
      final response = await http.post(
          Uri.parse("$URL/check-number-data?place=$place&user_type=$user_type"),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          });
      setState(() {
        var data = jsonDecode(response.body);
        name=data[1];
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
    }
  }
}

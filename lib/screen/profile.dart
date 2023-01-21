import 'dart:convert';

import 'package:election_app/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileView extends StatefulWidget {
  final String avatarLink;
  const ProfileView({Key key, this.avatarLink}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text('My Profile'),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.75,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 25.0,
                        spreadRadius: 5.0,
                        offset: Offset(
                          15.0,
                          15.0,
                        ),
                      )
                    ]),
                child: FutureBuilder(
                    future: getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var user = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.only(right: 32, left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              buildMainText('Profile'),
                              buildTiltleText('Full Name'),
                              buildValueText(user['name']),
                              buildTiltleText('Email'),
                              buildValueText(user['email']),
                              buildTiltleText('Phone'),
                              buildValueText(user['phone']),
                              const SizedBox(
                                height: 10,
                              ),
                              buildMainText('My Manager'),
                              Container(
                                padding: const EdgeInsets.all(6),
                                alignment: Alignment.centerLeft,
                                height: 80,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[300]),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage:
                                          NetworkImage(user['manager']['avatar']),
                                      backgroundColor: kPrimeryColor,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildTiltleText(user['manager']['name']),
                                        Text(
                                          user['manager']['email'],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
            Positioned(
              top: screenHeight*0.06,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
             
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(widget.avatarLink),
                  backgroundColor: kPrimeryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildValueText(String text) {
    return Container(
      width: double.maxFinite,
      height: 40,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 4, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.grey[300]),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Padding buildMainText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: kPrimeryColor, fontSize: 18),
      ),
    );
  }

  Text buildTiltleText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Future getUser() async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));
    return user;
  }
}

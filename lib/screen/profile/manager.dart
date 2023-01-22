import 'package:election_app/config.dart';
import 'package:flutter/material.dart';

class Manager extends StatelessWidget {
  final String avatarLink;
  final String name;
  final String email;
  final String phone;
  final String type;
  const Manager(
      {Key key, this.avatarLink, this.name, this.email, this.phone, this.type})
      : super(key: key);

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
        title: const Text('My Manager'),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.75,
                padding: const EdgeInsets.only(right: 32, left: 8),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    buildTiltleText('Full Name'),
                    buildValueText(name),
                    buildTiltleText('Email'),
                    buildValueText(email),
                    buildTiltleText('Phone'),
                    buildValueText(phone),
                    buildTiltleText('Type Of Election'),
                    buildValueText(type),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.06,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(avatarLink),
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
      margin: const EdgeInsets.only(top: 4, bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.grey[300]),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

/*   Padding buildMainText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: kPrimeryColor, fontSize: 18),
      ),
    );
  } */

  Text buildTiltleText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

/*import 'package:election_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../compononts/button.dart';
import '../config.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/back.png",
            ),
          ),
        ),
        title: const Text(
          "Verification",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/otp2.png",
              height: screenHeight * 0.45,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: OtpTextField(
                numberOfFields: 5,
                borderColor: kPrimeryColor,
                showFieldAsBox: true,
                fieldWidth: 50,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  print(verificationCode);
                },
              ),
            ),
            CustomButton(
                label: "Verify",
                onPress: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => const Main())));
                })
          ],
        ),
      ),
    );
  }
}
*/

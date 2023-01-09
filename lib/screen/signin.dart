import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:election_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../compononts/button.dart';
import '../compononts/custom_textfeild.dart';
import '../compononts/paswordfield.dart';
import '../config.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  String phone = "";
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/header_signin.png"),
            //const SizedBox(height: 187, ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Sign In",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 24,
            ),
            //buildPhoneTextField(),

            CustomTextFeild(
              hint: 'Email',
              controller: textEmailController,
              image: "email.png",
              textInputType: TextInputType.emailAddress,
            ),
            PasswordFeild(
              controller: textPasswordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: CustomButton(
                  isLoading: isLogin,
                  label: "SIGN IN",
                  onPress: () {
                    login();
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Main()))); */
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    if (textEmailController.text.isEmpty && textPasswordController.text.isEmpty) {
      Flushbar(
            message: 'Enter your email & password!',
            messageColor: Colors.red,
            //backgroundColor: kPrimeryColor,
            duration: const Duration(seconds: 3),
            icon: const Icon(
              Icons.warning_rounded,
              color: Colors.red,
            ),
          ).show(context);
    }else if (textEmailController.text.isEmpty) {
      Flushbar(
            message: 'Enter your email!',
            messageColor: Colors.red,
            //backgroundColor: kPrimeryColor,
            duration: const Duration(seconds: 3),
            icon: const Icon(
              Icons.warning_rounded,
              color: Colors.red,
            ),
          ).show(context);
    } else if (textPasswordController.text.isEmpty) {
      Flushbar(
            message: 'Enter your password!',
            messageColor: Colors.red,
            //backgroundColor: kPrimeryColor,
            duration: const Duration(seconds: 3),
            icon: const Icon(
              Icons.warning_rounded,
              color: Colors.red,
            ),
          ).show(context);
    } else {
      setState(() {
        isLogin = true;
      });
      try {
        String path = "$URL/login";

        final response = await http.post(Uri.parse(path),
            body: json.encode({"email": textEmailController.text, "password": textPasswordController.text}),
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json'
            });
        setState(() {
          isLogin = false;
        });
        if (response.statusCode == 200) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => const Main())));
        } else {
          // ignore: use_build_context_synchronously
          Flushbar(
            message: 'User not registered!',
            messageColor: Colors.red,
            //backgroundColor: kPrimeryColor,
            duration: const Duration(seconds: 3),
            icon: const Icon(
              Icons.warning_rounded,
              color: Colors.red,
            ),
          ).show(context);
        }
      } catch (e) {
        setState(() {
          isLogin = false;
        });
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

  /* Widget buildPhoneTextField() {
    double height = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: height < 600 ? 47 : 54,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(8)),
        child: InternationalPhoneNumberInput(
          initialValue: PhoneNumber(isoCode: 'NG'),
          onInputChanged: (PhoneNumber number) {
            phone = number.phoneNumber;
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          selectorTextStyle: const TextStyle(color: Colors.black),
          hintText: 'Enter mobile number',
          textFieldController: textPasswordController,
          maxLength: 16,
          formatInput: true,
          errorMessage: '',
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        ));
  } */
}

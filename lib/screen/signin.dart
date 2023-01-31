// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:election_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../components/button.dart';
import '../components/custom_textfeild.dart';
import '../components/paswordfield.dart';


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
              hint: 'Username',
              controller: textEmailController,
              image: "user.png",
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
            message: 'Enter your username & password!',
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
            message: 'Enter your username!',
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
        String path = "https://nnpp.herokuapp.com/api/login";
        String userName =  textEmailController.text;
        String password = textPasswordController.text;
        final response = await http.post(Uri.parse(path),
            body: json.encode({"username": userName, "password": password}),
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json'
            });

        setState(() {
          isLogin = false;
        });
        if (response.statusCode == 200) {
          const storage = FlutterSecureStorage();
          //var data = json.decode(response.body)['user'] ;
          await storage.write(key: 'user', value: response.body);
          print(response.body);
          //textEmailController.text=data.toString();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) =>  Main())));
        } else {
          
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

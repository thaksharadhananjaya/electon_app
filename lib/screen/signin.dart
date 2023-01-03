import 'package:election_app/screen/otp.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../compononts/button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController textPhoneController = TextEditingController();
  String phone = "";
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
            buildPhoneTextField(),

            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: CustomButton(
                  label: "SIGN IN",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const OTPScreen())));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhoneTextField() {
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
          textFieldController: textPhoneController,
          maxLength: 16,
          formatInput: true,
          errorMessage: '',
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        ));
  }
}

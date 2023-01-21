import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';

class PasswordFeild extends StatefulWidget {
  final TextEditingController controller;

  PasswordFeild({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  State<PasswordFeild> createState() => _PasswordFeildState();
}

class _PasswordFeildState extends State<PasswordFeild> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth * 0.8,
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: kPrimeryColor, borderRadius: BorderRadius.circular(8)),
              child: Image.asset('assets/lock.png')),
          SizedBox(
            width: screenwidth * 0.8 - 90,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !isVisible,
              style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
              decoration: InputDecoration(
                  hintText: "Password",
                  
                  hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  suffixIcon: IconButton(
                      onPressed: () {setState(() {
                        isVisible=!isVisible;
                      });}, icon: Icon(isVisible? Icons.visibility_outlined: Icons.visibility_off_outlined), color: kPrimeryColor, iconSize: 32,)),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';

class CustomTextFeild extends StatelessWidget {
  final String label;
// final String image;
  final TextEditingController controller;
  TextInputType textInputType;
  CustomTextFeild(
      {Key key,
      @required this.label,
      @required this.controller,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Text(label,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500),
            )),
        Container(
        
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(bottom: 24, top: 4),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            keyboardType: textInputType,
            maxLines: 6,
            maxLength: 150,
            style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
            decoration: const InputDecoration(
              
              //hintText: hint,
              /* hintStyle: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)), */
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              
            ),
          ),
        ),
      ],
    );
  }
}

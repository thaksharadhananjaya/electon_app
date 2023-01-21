import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';

class ColationFeild extends StatelessWidget {
  final String hint;
  final String image;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmit;
  const ColationFeild(
      {Key key,
      @required this.hint,
      @required this.controller,
      @required this.image,
      this.focusNode,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
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
                      color: kPrimeryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.asset('assets/$image')),
              SizedBox(
                width: screenwidth * 0.8 - 90,
                child: TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  textInputAction: hint != 'Rejected Votes'
                      ? TextInputAction.next
                      : TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  textAlign: TextAlign.center,
                  onFieldSubmitted: (text) {
                    onSubmit();
                  },
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

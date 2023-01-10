import 'package:flutter/material.dart';
import '../config.dart';

class CustomDropDown extends StatelessWidget {
 final String label;
 final Widget autoComplete;
  const CustomDropDown({Key key, this.label, this.autoComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            buildTextLable(label),
            const Padding(
              padding: EdgeInsets.only(top: 18),
              child: Text(
                " *",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          height: height < 600 ? 47 : 54,
          decoration: containerDecoration(),
          child: autoComplete,
        )
      ],
    );

    
  }
  BoxDecoration containerDecoration() {
    return BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 25,
            color: kPrimeryColor.withOpacity(0.20),
          ),
        ],
        borderRadius: BorderRadius.circular(15.0));
  }

   Padding buildTextLable(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 8, top: 20),
      child: Text(
        text,
        style: TextStyle(
          color: kPrimeryColor,
        ),
      ),
    );
  }
}
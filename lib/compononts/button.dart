

import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
   Color color;
  final Function function;
  final String label;
  CustomButton({Key key, this.color=Colors.blue, this.function, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 50,
      decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 25,
              color: color.withOpacity(0.20),
            ),
          ],
          borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.only(top: 40, bottom: 120),
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: function,
          child:  Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
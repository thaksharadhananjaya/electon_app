import 'package:flutter/material.dart';

import '../config.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPress;
  bool isLoading;
  double elevation;
  double height;
  CustomButton(
      {Key key,
      this.isLoading = false,
      this.elevation = 1,
      this.height = 60,
      @required this.label,
      @required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      height: height,
      minWidth: screenwidth * 0.8,
      elevation: elevation,
      color: kPrimeryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () => onPress(),
      child: isLoading
          ? Row(
            mainAxisSize: MainAxisSize.min,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                //const SizedBox(width: 12,),
                const SizedBox(
                    width: 25, height: 25, child: CircularProgressIndicator(color: Colors.white,))
              ],
            )
          : Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900),
            ),
    );
  }
}

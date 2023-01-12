import 'package:flutter/material.dart';

class CollationRow extends StatelessWidget {
  final String label;
  const CollationRow({Key key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           SizedBox(
            width: 100,
             child: Text(
              label,
              style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
           ),
          //const SizedBox(width: 100,),
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                border: Border.all(color:  Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            child: const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
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
    );
  }
}

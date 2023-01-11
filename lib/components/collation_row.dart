import 'package:flutter/material.dart';

class CollationRow extends StatelessWidget {
  final String label;
  const CollationRow({Key key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          label,
          style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          width: 32,
        ),
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE6E6E6)),
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
    );
  }
}

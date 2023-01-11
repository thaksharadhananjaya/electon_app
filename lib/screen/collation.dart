import 'package:election_app/components/collation_row.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class Collation extends StatefulWidget {
  const Collation({Key key}) : super(key: key);

  @override
  _CollationState createState() => _CollationState();
}

class _CollationState extends State<Collation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16,),
        const CollationRow(label: 'A'),
        const CollationRow(label: 'A'),
        const CollationRow(label: 'A'),
        const CollationRow(label: 'A'),
        const CollationRow(label: 'A'),
      ],
    );
  }
}

import 'package:election_app/components/button.dart';
import 'package:election_app/components/collation_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollationParty extends StatefulWidget {
  const CollationParty({Key key}) : super(key: key);

  @override
  _CollationPartyState createState() => _CollationPartyState();
}

class _CollationPartyState extends State<CollationParty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          toolbarHeight: 40),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Party',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text('Score',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CollationRow(label: 'A'),
                    const CollationRow(label: 'AA'),
                    const CollationRow(label: 'ADP'),
                    const CollationRow(label: 'APP'),
                    const CollationRow(label: 'AAC'),
                    const CollationRow(label: 'ADC'),
                    const CollationRow(label: 'APC'),
                    const CollationRow(label: 'APGA'),
                    const CollationRow(label: 'APM'),
                    const CollationRow(label: 'BP'),
                    const CollationRow(label: 'LP'),
                    const CollationRow(label: 'NRM'),
                    const CollationRow(label: 'NNPP'),
                    const CollationRow(label: 'PDP'),
                    const CollationRow(label: 'PRP'),
                    const CollationRow(label: 'SDP'),
                    const CollationRow(label: 'YPP'),
                    const CollationRow(label: 'ZLP'),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 32, left: 80, right: 80, top: 16),
                      child: CustomButton(label: 'Submit', onPress: () {}),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

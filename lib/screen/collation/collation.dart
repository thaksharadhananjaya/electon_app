import 'package:election_app/components/button.dart';
import 'package:election_app/components/custom_textbox.dart';
import 'package:election_app/components/custom_textfeild.dart';
import 'package:election_app/screen/collation/collation_party.dart';
import 'package:flutter/material.dart';

class Collation extends StatelessWidget {
  const Collation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textRegController = TextEditingController();
    TextEditingController textAccController = TextEditingController();
    TextEditingController textRejectController = TextEditingController();
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFeild(
              image: "vote.png",
              hint: 'Registered Votes',
              controller: textRegController),
          const SizedBox(
            height: 16,
          ),
          CustomTextFeild(
              image: "vote_ac.png",
              hint: 'Accredited Votes',
              controller: textAccController),
          const SizedBox(
            height: 16,
          ),
          CustomTextFeild(
              image: "vote_rej.png",
              hint: 'Rejected Votes',
              controller: textRejectController),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              label: 'Next',
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const CollationParty())));
              })
        ],
      ),
    );
  }
}

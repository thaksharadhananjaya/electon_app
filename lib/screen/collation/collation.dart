import 'package:another_flushbar/flushbar.dart';
import 'package:election_app/components/button.dart';
import 'package:election_app/screen/collation/collation_party.dart';
import 'package:flutter/material.dart';

import '../../components/colationFeild.dart';

class Collation extends StatelessWidget {
  final bool mode;
  Collation({Key key, @required this.mode}) : super(key: key);
  TextEditingController textRegController = TextEditingController();
  TextEditingController textAccController = TextEditingController();
  TextEditingController textRejectController = TextEditingController();
  FocusNode focusNodeAcc = FocusNode();
  FocusNode focusNodeRej = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          toolbarHeight: 40),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColationFeild(
                onSubmit: () {
                  focusNodeAcc.requestFocus();
                },
                image: "vote.png",
                hint: 'Registered Votes',
                controller: textRegController),
            const SizedBox(
              height: 16,
            ),
            ColationFeild(
                onSubmit: () {
                  focusNodeRej.requestFocus();
                },
                focusNode: focusNodeAcc,
                image: "vote_ac.png",
                hint: 'Accredited Votes',
                controller: textAccController),
            const SizedBox(
              height: 16,
            ),
            ColationFeild(
              onSubmit: (){},
                focusNode: focusNodeRej,
                image: "vote_rej.png",
                hint: 'Rejected Votes',
                controller: textRejectController),
            const SizedBox(
              height: 32,
            ),
            CustomButton(label: 'Next', onPress: () => next(context))
          ],
        ),
      ),
    );
  }

  void next(BuildContext context) {
    String reg = textRegController.text,
        acc = textAccController.text,
        reject = textRejectController.text;
    if (reg.isNotEmpty && reject.isNotEmpty && acc.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => CollationParty(
                accredited: int.parse(acc),
                registered:int.parse( reg),
                rejected: int.parse(reject),
                mode: mode,
              ))));
    } else {
      Flushbar(
        messageText: const Text(
          'All feilds are requied!',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        //backgroundColor: kPrimeryColor,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
      ).show(context);
    }
  }
}

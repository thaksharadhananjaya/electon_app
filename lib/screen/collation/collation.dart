import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:election_app/components/button.dart';
import 'package:election_app/config.dart';
import 'package:election_app/screen/collation/collation_party.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../components/colationFeild.dart';

class Collation extends StatelessWidget {
  final bool mode;
  final int type;
  Collation({Key key, @required this.mode, this.type}) : super(key: key);
  TextEditingController textRegController = TextEditingController();
  TextEditingController textAccController = TextEditingController();
  TextEditingController textRejectController = TextEditingController();
  FocusNode focusNodeAcc = FocusNode();
  FocusNode focusNodeRej = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          elevation: 0,
          title: Text(type == 0
                  ? 'Presidential Collation'
                  : (type == 1 ? 'Senate Collation' : 'Rep Collation')
              ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          toolbarHeight: 40),
      body: SizedBox(
          width: double.maxFinite,
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data['total'];
                  print(data);
                  textAccController.text =
                      data['TOTAL_ACCREDITED_VOTERS'].toString();
                  textRegController.text =
                      data['TOTAL_REGISTERED_VOTERS'].toString();
                  textRejectController.text =
                      data['TOTAL_REJECTED_VOTES'].toString();
                  return Column(
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
                          onSubmit: () {},
                          focusNode: focusNodeRej,
                          image: "vote_rej.png",
                          hint: 'Rejected Votes',
                          controller: textRejectController),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                          label: 'Next',
                          onPress: () =>
                              next(context, snapshot.data['results']))
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }

  void next(BuildContext context, var result) {
    // print(result);
    String reg = textRegController.text,
        acc = textAccController.text,
        reject = textRejectController.text;
    if (reg.isNotEmpty && reject.isNotEmpty && acc.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => CollationParty(
              accredited: int.parse(acc),
              registered: int.parse(reg),
              rejected: int.parse(reject),
              mode: mode,
              type: type,
              data: result))));
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

  Future getData() async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'));
    final response = await http.post(
        Uri.parse(type == 0
            ? "$URL/mobile-getdata"
            : (type == 1 ? "$URL/mobile-getdata-senate" : "$URL/mobile-getdata-rep")),
        body: json.encode(user),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        });

    var data = jsonDecode(response.body);
    return data;
  }
}

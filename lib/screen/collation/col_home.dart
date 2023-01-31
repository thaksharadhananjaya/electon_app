// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:election_app/components/button.dart';
import 'package:election_app/config.dart';
import 'package:election_app/repo/repo.dart';
import 'package:election_app/screen/collation/collation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../components/customDailog.dart';

class ColHome extends StatefulWidget {
  const ColHome({Key key}) : super(key: key);

  @override
  State<ColHome> createState() => _ColHomeState();
}

class _ColHomeState extends State<ColHome> {
  String presidential, senate, rep;

  @override
  void initState() {
    super.initState();
    getButtons();
  }

  List<bool> isLoading = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              presidential == null
                  ? buildButton("Presidential")
                  : (presidential == '0'
                      ? buildCanButton("Presidential")
                      : buildColedButton("Presidential")),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Collate",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Collation(
                                  mode: true,
                                  type: 0,
                                ))));
                  },
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(
                width: 115,
                child: CustomButton(
                  label: "Cancel",
                  isLoading: isLoading[0],
                  onPress: () {
                    buildDeleteBox(0);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              senate == null
                  ? buildButton("Senate")
                  : (senate == '0'
                      ? buildCanButton("Senate")
                      : buildColedButton("Senate")),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Collate",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Collation(
                                  mode: true,
                                  type: 1,
                                ))));
                  },
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(
                width: 115,
                child: CustomButton(
                  label: "Cancel",
                  isLoading: isLoading[1],
                  onPress: () {
                    buildDeleteBox(1);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              rep == null
                  ? buildButton("Rep")
                  : (rep == '0'
                      ? buildCanButton("Rep")
                      : buildColedButton("Rep")),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Collate",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Collation(
                                  mode: true,
                                  type: 2,
                                ))));
                  },
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(
                width: 115,
                child: CustomButton(
                  isLoading: isLoading[2],
                  label: "Cancel",
                  onPress: () {
                    buildDeleteBox(2);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildButton(String text) {
    return Container(
      width: 110,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: kPrimeryColor, width: 2),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: const TextStyle(
            color: kPrimeryColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildColedButton(String text) {
    return Container(
      width: 110,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.blue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const Icon(
            Icons.done,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Container buildCanButton(String text) {
    return Container(
      width: 110,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const Icon(
            Icons.close,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  void getButtons() async {
    const storage = FlutterSecureStorage();
    presidential = await storage.read(key: 'presidential');
    senate = await storage.read(key: 'senate');
    rep = await storage.read(key: 'rep');

    setState(() {});
  }

  Future<dynamic> buildDeleteBox(int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => ComfirmDailogBox(
              onTap: () => cancelSubmit(index),
            ));
  }

  void cancelSubmit(int index) async {
    setState(() {
      isLoading[index] = true;
    });
    Navigator.pop(context);

    var data = await Repo.cancelCollation(type: index);

    if (data['success']) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Canceled',
        desc: "Canceled by\n${data['person']} at\n${data['time']}",
        btnOkOnPress: () {
      
        },
      ).show();
      const storage = FlutterSecureStorage();
      if (index == 0) {
        await storage.write(key: 'presidential', value: '0');
      } else if (index == 1) {
        await storage.write(key: 'senate', value: '0');
      } else {
        await storage.write(key: 'rep', value: '0');
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Unauthenticated',
        desc: "You are not Authorized !",
        btnOkColor: kPrimeryColor,
        btnOkOnPress: () {
          // nav.pop();
        },
      ).show();
    }

    setState(() {
      isLoading[index] = false;
    });
    getButtons();
  }
}

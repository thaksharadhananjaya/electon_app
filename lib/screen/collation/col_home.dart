import 'package:election_app/components/button.dart';
import 'package:election_app/screen/collation/collation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
              presidential == null || presidential == '0'
                  ? SizedBox(
                      width: 110,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "Presidential",
                          style: TextStyle(fontSize: 12),
                        ),
                      ))
                  : Container(
                      width: 110,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: const Text(
                        "Presidential",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                width: 110,
                child: CustomButton(
                  label: "Cancel",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Collation(
                                  mode: false,
                                  type: 0,
                                ))));
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
              senate == null || senate == '0'
                  ? SizedBox(
                      width: 110,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "Senate",
                          style: TextStyle(fontSize: 12),
                        ),
                      ))
                  : Container(
                      width: 110,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: const Text(
                        "Senate",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                width: 110,
                child: CustomButton(
                  label: "Cancel",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Collation(
                                  mode: false,
                                  type: 1,
                                ))));
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
              rep == null || rep == '0'
                  ? SizedBox(
                      width: 110,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "Rep",
                          style: TextStyle(fontSize: 12),
                        ),
                      ))
                  : Container(
                      width: 110,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: const Text(
                        "Rep",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                width: 110,
                child: CustomButton(
                  label: "Cancel",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Collation(
                                  mode: false,
                                  type: 2,
                                ))));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getButtons() async {
    const storage = FlutterSecureStorage();
    presidential = await storage.read(key: 'presidential');
    senate = await storage.read(key: 'senate');
    rep = await storage.read(key: 'rep');

    setState(() {
      
    });
  }
}

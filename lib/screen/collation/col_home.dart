import 'package:election_app/components/button.dart';
import 'package:election_app/screen/collation/collation.dart';
import 'package:flutter/material.dart';

class ColHome extends StatelessWidget {
  const ColHome({Key key}) : super(key: key);

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
              SizedBox(
                  width: 110,
                  height: 60,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "Presidential",
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Collate",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Collation(mode: true,))));
                  },
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Cancel",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Collation(mode: false,))));
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
              SizedBox(
                  width: 110,
                  height: 60,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Senate"),
                  )),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Collate",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Collation(mode: true,))));
                  },
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Cancel",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Collation(mode: false,))));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: 110,
                  height: 60,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Rep"),
                  )),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Collate",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) =>  Collation(mode: true,))));
                  },
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(
                width: 110,
                child: CustomButton(
                  label: "Cancel",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Collation(mode: false,))));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

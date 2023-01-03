
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:election_app/screen/collation.dart';
import 'package:election_app/screen/home.dart';
import 'package:election_app/screen/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:election_app/screen/media_data.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  /*  void configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      Amplify.addPlugin(AmplifyStorageS3());

      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  } */

  @override
  Widget build(BuildContext context) {
    //configureAmplify();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Election',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: buildMaterialColor(kPrimeryColor) ,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: /* FutureBuilder(

          future: Future.delayed(const Duration(seconds: 4)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Home();
            }
            return const Splash();
          }) */
          const SignIn(),
    );
  }

  
  MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
   
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
  }

}

class Main extends StatefulWidget {
  const Main({Key key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentPage = 1;
  List pages = [const MediaData(), const Home(), const Collation()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPage],
        bottomNavigationBar: CircleBottomNavigationBar(
          initialSelection: currentPage,
          circleColor: kPrimeryColor,
          activeIconColor: Colors.white,
          inactiveIconColor: Colors.grey,
          itemTextOff: 1,
          tabs: [
            TabData(
                icon: Icons.upload,
                iconSize: 25,
                title: 'Upload',
                fontSize: 13,
                fontWeight: FontWeight.bold),
            TabData(
                icon: Icons.home,
                iconSize: 25,
                title: 'Home',
                fontSize: 13,
                fontWeight: FontWeight.bold),
            TabData(
                icon: Icons.data_array,
                iconSize: 25,
                title: 'Collation',
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ],
          onTabChangedListener: (index) => setState(() => currentPage = index),
        ));
  }
}

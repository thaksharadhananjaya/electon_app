import 'dart:convert';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:awesome_bottom_navigation/awesome_bottom_navigation.dart';

import 'package:election_app/components/button.dart';
import 'package:election_app/db/db_helper.dart';
import 'package:election_app/repo/repo.dart';
import 'package:election_app/screen/collation/collation.dart';
import 'package:election_app/screen/home.dart';
import 'package:election_app/screen/profile/profile.dart';
import 'package:election_app/screen/signin.dart';
import 'package:election_app/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:election_app/screen/tracking.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'amplifyconfiguration.dart';
import 'config.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  void configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      Amplify.addPlugin(AmplifyStorageS3());

      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  Future<bool> isLogin() async {
    const storage = FlutterSecureStorage();
    String value = await storage.read(key: 'user');

    return value == null ? false : true;
  }

  Future<void> checkUploading() async {
    DBHelper dbHelper = DBHelper();
    List data = await dbHelper.getDataOffline();
    if (data.isNotEmpty) {
      for (var row in data) {
        Repo.addData(
            remark: row['remark'],
            file: row['file'],
            type: int.parse(row['file_type']),
            lat: row['lat'],
            long: row['long']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUploading();
    configureAmplify();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        title: 'Election',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: buildMaterialColor(kPrimeryColor),
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FutureBuilder(
                    future: isLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data) {
                          return const Main();
                        } else {
                          return const SignIn();
                        }
                      }
                      return const Splash();
                    });
              }
              return const Splash();
            }));
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
  int currentPage = 0;
  List pages = [const Home(), const Tracking(), Collation()];
  List pagesName = ['Home', 'Tracking', 'Collation'];
  String avatarLink = '', name = '';
  void getAvatar() async {
    const storage = FlutterSecureStorage();
    var user = json.decode(await storage.read(key: 'user'))['user'];
    setState(() {
      avatarLink = user['avatar'];
      name = user['username'];
    });
  }

  @override
  void initState() {
    super.initState();
    getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          toolbarHeight: 40,
          centerTitle: true,
          title: Text(pagesName[currentPage]),
        ),
        drawer: buildDrawer(),
        body: pages[currentPage],
        bottomNavigationBar: AwesomeBottomNav(
          icons: const [
            Icons.home_outlined,
            Icons.camera_alt_outlined,
            Icons.how_to_vote,
          ],
          highlightedIcons: const [
            Icons.home,
            Icons.camera_alt,
            Icons.how_to_vote_outlined,
          ],
          onTapped: (int value) {
            setState(() {
              currentPage = value;
            });
          },
          bodyBgColor: Colors.transparent,
          highlightColor: kPrimeryColor,
          navFgColor: Colors.grey.withOpacity(0.5),
          navBgColor: Colors.white,
        ));
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          avatarLink == ''
              ? const SizedBox()
              : CircleAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(avatarLink),
                  backgroundColor: kPrimeryColor,
                ),
          Text(
            name,
            style: const TextStyle(
                color: kPrimeryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 48),
            child: CustomButton(
                label: 'View Profile',
                height: 48,
                onPress: () async {
                  if (avatarLink != '') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ProfileView(
                                  avatarLink: avatarLink,
                                ))));
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
            child: CustomButton(
                label: 'Signout',
                height: 48,
                onPress: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SignIn())));
                  const storage = FlutterSecureStorage();
                  await storage.deleteAll();
                }),
          )
        ],
      ),
    );
  }
}

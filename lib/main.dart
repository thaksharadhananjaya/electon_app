import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:election_app/screen/home.dart';
import 'package:election_app/screen/splash.dart';

import 'amplifyconfiguration.dart';
import 'config.dart';

Future<void> main() async {
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

  @override
  Widget build(BuildContext context) {
    configureAmplify();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Election',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimeryColor,
      ),
      home: /* FutureBuilder(

          future: Future.delayed(const Duration(seconds: 4)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Home();
            }
            return const Splash();
          }) */
         const Home(),
    );
  }
}

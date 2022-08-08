// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:election_app/compononts/button.dart';
import 'package:election_app/compononts/custom_dropdown.dart';
import 'package:election_app/db/db_helper.dart';
import 'package:election_app/repo/repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:election_app/screen/player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../config.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  VideoPlayerController controller;
  TextEditingController textNoteController = TextEditingController();
  DBHelper dbHelper = DBHelper();
  Position position;

  File photo;
  File video;
  bool isPhoto = true;
  final ImagePicker picker = ImagePicker();
  List state, lga, ward = [null, null], pucode;
  String stateVal, lgaVal, wardVal, pucodeVal;

  @override
  void deactivate() {
    if (controller != null) {
      controller.setVolume(0.0);
      controller.pause();
    }

    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getState();
dbHelper.getCo();
    //configureAmplify();
    super.initState();
  }

  /*  void configureAmplify() async {
    // Add Pinpoint and Cognito Plugins
    Amplify.addPlugin(AmplifyAuthCognito());
    Amplify.addPlugin(AmplifyStorageS3());
    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Amplify was already configured. Was the app restarted?");
    }
  } */

  Future<void> getState() async {
    if (await Permission.storage.request().isGranted) {
      await dbHelper.saveData();
      state = await dbHelper.getState();
    }
  }

  Future<void> getLGA() async {
    lga = await dbHelper.getLGA(stateVal);
    ward = [null, null];
    pucode = null;
    setState(() {});
  }

  Future<void> getWard() async {
    ward = await dbHelper.getWard(stateVal, lgaVal);
    pucode = null;
    setState(() {});
  }

  Future<void> getPol() async {
    int index = ward[1].indexOf(wardVal);

    pucode = await dbHelper.getPol(stateVal, lgaVal, ward[0][index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.35;
    return WillPopScope(
      onWillPop: () async {
        {
          MoveToBackground.moveTaskToBack();
          return false;
        }
      },
      child: Scaffold(
        // drawer: buildDrawer(),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () => determinePosition(false),
              child: const Icon(Icons.video_camera_back),
            ),
            const SizedBox(
              height: 6,
            ),
            FloatingActionButton(
              onPressed: () => determinePosition(true),
              child: const Icon(Icons.camera_enhance),
            ),
          ],
        ),
        appBar: AppBar(),
        body: Container(
            padding: const EdgeInsets.all(10.0),
            height: double.maxFinite,
            width: double.maxFinite,
            child: controller == null && photo == null
                ? SizedBox(
                    height: height,
                    child: Image.asset("assets/camera.png"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        controller != null
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                height: height,
                                child: AspectRatioVideo(controller))
                            : Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                height: height,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(photo),
                                        fit: BoxFit.fill)),
                              ),
                        CustomDropDown(
                            label: "State",
                            autoComplete: EasyAutocomplete(
                                decoration: buildTextDecoration(),
                                suggestions: state ?? [],
                                onChanged: (value) {},
                                onSubmitted: (value) {
                                  stateVal = value;
                                  getLGA();
                                })),
                        CustomDropDown(
                            label: "LGA",
                            autoComplete: EasyAutocomplete(
                                decoration: buildTextDecoration(),
                                suggestions: lga ?? [],
                                onChanged: (value) {},
                                onSubmitted: (value) {
                                  lgaVal = value;
                                  getWard();
                                })),
                        CustomDropDown(
                            label: "Ward",
                            autoComplete: EasyAutocomplete(
                                decoration: buildTextDecoration(),
                                suggestions: ward[1] ?? [],
                                onChanged: (value) {},
                                onSubmitted: (value) {
                                  wardVal = value;
                                  getPol();
                                })),
                        CustomDropDown(
                            label: "Poling Unit Name",
                            autoComplete: EasyAutocomplete(
                              decoration: buildTextDecoration(),
                              suggestions: pucode ?? [],
                              onChanged: (value) {},
                              onSubmitted: (value) => pucodeVal = value,
                            )),
                        buildNoteTextField(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              label: 'Submit',
                              function: submit,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CustomButton(
                              label: 'Clear',
                              color: Colors.red[200],
                              function: () {
                                setState(() {
                                  photo = null;
                                  video = null;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: InkWell(
                onTap: () {
                  try {
                    controller.dispose();
                    controller = null;
                  } catch (e) {
                    if (kDebugMode) {
                      print("error $e");
                    }
                  }
                },
                child: const SignOutButton()),
          ),
        ],
      ),
    );
  }

  Widget buildNoteTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextLable("Additional Remarks (Optional)"),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 200,
            decoration: containerDecoration(),
            child: TextFormField(
              controller: textNoteController,
              maxLines: 5,
              minLines: 5,
              maxLength: 300,
              keyboardType: TextInputType.text,
              decoration: buildTextDecoration(),
            )),
      ],
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 25,
            color: kPrimeryColor.withOpacity(0.20),
          ),
        ],
        borderRadius: BorderRadius.circular(15.0));
  }

  InputDecoration buildTextDecoration() {
    return InputDecoration(
      counterText: '',
      hintStyle: TextStyle(
        color: kPrimeryColor.withOpacity(0.5),
      ),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      border: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }

  Padding buildTextLable(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 8, top: 20),
      child: Text(
        text,
        style: TextStyle(
          color: kPrimeryColor,
        ),
      ),
    );
  }

  void pickPhoto() async {
    XFile pikedPhoto = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 640, maxHeight: 480);
    if (pikedPhoto != null) {
      photo = File(pikedPhoto.path);
      isPhoto = true;
      try {
        if (controller != null) controller.dispose();
        controller = null;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    if (photo != null) {
      setState(() {});
    }
  }

  void pickVideo() async {
    try {
      if (controller != null) controller.dispose();
    } catch (e) {
      controller.initialize();
    }

    XFile pikedVideo = await picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );
    if (pikedVideo != null && mounted) {
      await VideoCompress.setLogLevel(0);
      final MediaInfo info = await VideoCompress.compressVideo(
        pikedVideo.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
        includeAudio: true,
      );

      photo = null;
      if (info == null) {
        video = File(pikedVideo.path);
      } else {
        video = File(info.path);
      }
      await playVideo();
    }
  }

  Future<void> playVideo() async {
    //await disposeVideoController();
    controller = VideoPlayerController.file(video);

    const double volume = 1;
    await controller.setVolume(volume);
    await controller.initialize();
    await controller.setLooping(true);
    await controller.play();
    setState(() {});
  }

  Future<void> determinePosition(bool mode) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Flushbar(
        message: 'Location services are disabled. Please enable',
        messageColor: Colors.red,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
      ).show(context);
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        Flushbar(
          message:
              'Location permissions are permanently denied, we cannot request permissions.',
          messageColor: Colors.red,
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.warning_rounded,
            color: Colors.red,
          ),
        ).show(context);
      } else if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Flushbar(
            message: 'Location permissions are denied !',
            messageColor: Colors.red,
            duration: const Duration(seconds: 3),
            icon: const Icon(
              Icons.warning_rounded,
              color: Colors.red,
            ),
          ).show(context);
        } else {
          position = await Geolocator.getCurrentPosition();
          mode ? pickPhoto() : pickVideo();
        }
      } else {
        position = await Geolocator.getCurrentPosition();
        mode ? pickPhoto() : pickVideo();
      }
    }
  }

  void submit() async {
    if (stateVal.isNotEmpty) {
      var time = DateTime.now().millisecondsSinceEpoch.toString();

      if (photo != null) {
        await upload(photo, "photos/$time.jpg", 0);
      } else if (video != null) {
        await upload(video, "videos/$time.mp4", 1);
      } else {
        Flushbar(
          message: 'Please capture photo or video !',
          messageColor: Colors.red,
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.warning_rounded,
            color: Colors.red,
          ),
        ).show(context);
      }
    } else {
      Flushbar(
        message: 'Enter required(*) field !',
        messageColor: Colors.red,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
      ).show(context);
    }

    setState(() {});
  }

  Future<void> upload(File file, String key, int type) async {
    S3UploadFileOptions options =
        S3UploadFileOptions(accessLevel: StorageAccessLevel.guest);
    try {
      /*  ProgressDialog pd = ProgressDialog(context: context);
      pd.show(max: 100, msg: 'File Uploading...', completed: Completed()); */
      dbHelper.saveDataOffline(
          state: stateVal,
          lga: lgaVal,
          ward: wardVal,
          pu: pucodeVal,
          remark: textNoteController.text,
          file: key,
          type: type,
          lat: position.latitude,
          long: position.longitude);
      uploadTextData();
      clear();
      await Amplify.Storage.uploadFile(
        key: key,
        local: file,
        options: options,
      );

      try {
        controller.dispose();
        controller = null;
      } catch (e) {
        if (kDebugMode) {
          print("error $e");
        }
      }
    } on StorageException catch (e) {
      Flushbar(
        message: e.message,
        messageColor: Colors.red,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
      ).show(context);
    }
  }

  Future<void> uploadTextData() async {
    var data = await dbHelper.getDataOffline();
    try {
      await InternetAddress.lookup('google.com');
      for (var row in data) {
        Repo.addData(
            state: row['state'],
            lga: row['lga'],
            ward: row['ward'],
            pu: row['pu'],
            remark: row['remark'],
            file: row['file'],
            type: row['file_type'],
            lat: row['lat'],
            long: row['long'],
            context: context);
      }
      dbHelper.deleteDataOffline();
    } catch (e) {
      uploadTextData();
    }
  }

  void clear() {
    Flushbar(
      message: "Data sumited !",
      messageColor: Colors.green,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.warning_rounded,
        color: Colors.green,
      ),
    ).show(context);
    setState(() {
      // controller.dispose();
      //controller = null;
      photo = null;
      /* lga.clear();
      ward.clear();
      pucode.clear(); */
      lga = null;
      ward = [null, null];
      pucode = null;
      video = null;
      stateVal = null;
      wardVal = null;
      lgaVal = null;
      pucode = null;
      textNoteController.clear();
    });
  }
}

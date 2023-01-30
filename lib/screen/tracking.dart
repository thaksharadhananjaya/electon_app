// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:election_app/repo/repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:election_app/components/button.dart';
import 'package:election_app/components/custom_textbox.dart';
import 'package:election_app/config.dart';
import 'package:election_app/util/player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:video_player/video_player.dart';

import '../db/db_helper.dart';

class Tracking extends StatefulWidget {
  const Tracking({Key key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  TextEditingController textEditingControllerRemark = TextEditingController();
  VideoPlayerController controller;
  DBHelper dbHelper = DBHelper();
  File photo;
  File video;
  final ImagePicker picker = ImagePicker();
  Timer timer;
  Position position;

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
    try {
      controller.dispose();
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildCameraButton(),
                CustomTextBox(
                    label: 'Remarks', controller: textEditingControllerRemark),
                CustomButton(label: 'Upload', backgroundColor: Colors.green, onPress: submit),
                const SizedBox(
                  height: 96,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildCameraButton() {
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showBottomSheet(context);
      },
      child: Container(
          height: screenHeight * 0.4,
          margin: const EdgeInsets.only(bottom: 36),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: photo != null
                  ? DecorationImage(image: FileImage(photo), fit: BoxFit.cover)
                  : null,
              color: const Color.fromARGB(77, 228, 224, 224),
              border: Border.all(color: const Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(8)),
          child: photo == null && controller == null
              ? const Icon(
                  Icons.camera_alt,
                  size: 140,
                  color: kPrimeryColor,
                )
              : controller != null
                  ? AspectRatioVideo(controller)
                  : null),
    );
  }

  Future<dynamic> showBottomSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bottomButton('Photo', Icons.photo, () => determinePosition(true)),
            bottomButton('Video', Icons.video_camera_back_sharp,
                () => determinePosition(false)),
          ],
        ),
      ),
    );
  }

  InkWell bottomButton(String label, IconData iconData, Function onClick) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onClick();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: kPrimeryColor,
            size: 50,
          ),
          Text(
            label,
            style: const TextStyle(
                fontSize: 16,
                color: kPrimeryColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  void pickPhoto() async {
    XFile pikedPhoto = await picker.pickImage(source: ImageSource.camera);
    if (pikedPhoto != null) {
      photo = File(pikedPhoto.path);
      // isPhoto = true;
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
      controller = null;
      video == null;
      setState(() {});
    }
  }

  void pickVideo() async {
    try {
      if (controller != null) controller.dispose();
    } catch (e) {
      controller.initialize();
    }

    XFile pikedVideo = await picker.pickVideo(source: ImageSource.camera);
    if (pikedVideo != null && mounted) {
      photo = null;
      //isPhoto = false;
      video = File(pikedVideo.path);
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

  void submit() async {
    var time = DateTime.now().millisecondsSinceEpoch.toString();

    if (photo != null) {
      await upload(photo, "photos/$time.jpg", 0);
      //Navigator.pop(context);
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
  }

  Future<void> upload(File file, String key, int type) async {
    S3UploadFileOptions options =
        S3UploadFileOptions(accessLevel: StorageAccessLevel.guest);
    try {
      /*  ProgressDialog pd = ProgressDialog(context: context);
      pd.show(max: 100, msg: 'File Uploading...', completed: Completed()); */

      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(max: 100, msg: 'File Uploading...', completed: Completed());
      int val = 10;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (val < 100) {
          val += 30;
          pd.update(value: val);
        } else {
          //clear();
          timer.cancel();
        }
      });

      var data = await Amplify.Storage.uploadFile(
        key: key,
        local: file,
        options: options,
      );
      /*const storage = FlutterSecureStorage();
        var user = json.decode( await storage.read(key: 'user'));
      String userType = await storage.read(key: 'user_type');
      String phone = await storage.read(key: 'phone');
      String email = await storage.read(key: 'email'); */

      await dbHelper.saveDataOffline(
          remark: textEditingControllerRemark.text,
          file: data.key,
          type: type,
          lat: position.latitude,
          long: position.longitude);
          
      await Repo.addData(
          remark: textEditingControllerRemark.text,
          file: data.key,
          type: type,
          lat: position.latitude,
          long: position.longitude);

      try {
         setState(() {
          textEditingControllerRemark.clear();
          photo = null;
        });
    print("ggggg");
        //controller.dispose();
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

  void clear(){
    setState(() {
      textEditingControllerRemark.clear();
    photo=null;
    video=null;
    });
    
  }
}

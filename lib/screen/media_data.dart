import 'dart:io';

import 'package:election_app/compononts/button.dart';
import 'package:election_app/compononts/custom_textfeild.dart';
import 'package:election_app/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:video_player/video_player.dart';

class MediaData extends StatefulWidget {
  const MediaData({Key key}) : super(key: key);

  @override
  _MediaDataState createState() => _MediaDataState();
}

class _MediaDataState extends State<MediaData> {
  TextEditingController textEditingControllerRemark = TextEditingController();
  VideoPlayerController controller;
  File photo;
  File video;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showBottomSheet(context);
                  },
                  child: Container(
                      height: screenHeight * 0.4,
                      margin: const EdgeInsets.only(bottom: 36),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(77, 228, 224, 224),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child:  Icon(
                        Icons.camera_alt,
                        size: 140,
                        color: Colors.blue[200],
                      )),
                ),
                CustomTextFeild(
                    label: 'Remark', controller: textEditingControllerRemark),
                CustomButton(label: 'Upload', onPress: () {})
              ],
            ),
          ),
        ),
      ),
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
                          bottomButton('Photo', Icons.photo, () {}),
                          bottomButton('Video', Icons.video_camera_back_sharp,() {}),
                        ],
                      ),
                    ),
                  );
  }

  InkWell bottomButton(String label, IconData iconData, Function onClick) {
    return InkWell(
      onTap: onClick,
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
            style: TextStyle(
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
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_text_recognititon/DetectorView/imagecropper/onImageButtonPressed.dart';
import 'package:flutter_text_recognititon/DetectorView/painters/text_detector_painter.dart';
import 'package:flutter_text_recognititon/DetectorView/textDetectorView.dart';
import 'package:flutter_text_recognititon/homePage.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File? _image;

  @override
  void initState() {
    super.initState();
    onImageIsCome();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _image != null
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 20.0),
                child: _image != null
                    ? Image.file(_image!) // Buraya bir gövde oluşturup not sayfasına akarımı sağlamam gerekli
                    : Container(
                        color: Colors.green,
                      ),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  onImageIsCome() async {
    File val = (await ImageCropper.cropImage(
      sourcePath: widget.imagePath,
      compressQuality: 100,
      maxHeight: 700,
      maxWidth: 700,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        showCropGrid: true,
        lockAspectRatio: false,
        toolbarColor: Colors.white,
        toolbarTitle: mAppName,
      ),
    ))!;
    print("cropper ${val.runtimeType}");

    setState(() {
      if (val != null) {
        _image = val as File;
      }
    });

  }


}

/*

MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _image != null ? Image.file(_image) : Container(color: Colors.green,),
        ),
      ),
    );


 */

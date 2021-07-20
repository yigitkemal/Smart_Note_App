import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


onImageButtonPressed(ImageSource source,
    {BuildContext? context, capturedImageFile}) async {
  final ImagePicker _picker = ImagePicker();
  File val;

  final pickedFile = await _picker.getImage(
    source: source,
  );

  val = (await ImageCropper.cropImage(
    sourcePath: pickedFile!.path,
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
  capturedImageFile(val.path);

}

typedef capturedImageFile = String Function(String);
typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
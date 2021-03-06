import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_text_recognititon/DetectorView/cameraView.dart';
import 'package:flutter_text_recognititon/DetectorView/painters/text_detector_painter.dart';
import 'package:flutter_text_recognititon/DetectorView/textDetectorView.dart';
import 'package:flutter_text_recognititon/homePage.dart';
import 'package:flutter_text_recognititon/main.dart';
import 'package:flutter_text_recognititon/model/notesModel.dart';
import 'package:flutter_text_recognititon/screens/addNotesScreen.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nb_utils/nb_utils.dart';

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.onImage})
      : super(key: key);

  final Function(InputImage inputImage) onImage;
  final String imagePath;

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File? _image;
  bool isBusy = false;
  CustomPaint? customPaint;
  TextDetector textDetector = GoogleMlKit.vision.textDetector();

  Color? _mSelectColor;
  List<String> collaborateList = [];
  //NotesModel _notes = NotesModel();
  String? okunanText;

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
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pop(MaterialPageRoute(builder: (context) => TextDetectorView()));
        return false;
      },
      child: _image != null
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SafeArea(
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 20.0),
                  child: _image != null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: Image.file(_image!)),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(
                                    bottom: (MediaQuery.of(context).size.height /
                                        10)),
                                child: AppButton(
                                  height: 60,
                                  width: context.width(),
                                  color: PrimaryBackgroundColor,
                                  text: 'Not Olarak Oku',
                                  textColor: appStore.isDarkMode
                                      ? splashBgColor
                                      : scaffoldColorDark,
                                  onTap: () {
                                    processImage(
                                        InputImage.fromFilePath(_image!.path));
                                  },
                                ),
                              ),
                            ],
                          )) // Buraya bir g??vde olu??turup not sayfas??na akar??m?? sa??lamam gerekli
                      : Container(
                          color: Colors.green,
                        ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
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

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final recognisedText = await textDetector.processImage(inputImage);
    print('Found ${recognisedText.blocks.length} textBlocks');
    //kesilmi?? ekranda notu buraya almay?? ba??arabiliyorum, not modelin i??ine yollayacak ??ekilde doldurup. AddNotesScreene yollayabilirsem problemim ????z??lecek
    ///notu burada okuyabiliyorum AddNotesScreene buradaki texti yollayabilmem gerekli.

    okunanText = recognisedText.text.trim().replaceAll("\n", " ");

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = TextDetectorPainter(
          recognisedText,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }


    setState(() {
      okunanText == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddNotesScreen(
                    comingString: okunanText,
                  )));
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

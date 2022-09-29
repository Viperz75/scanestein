import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scanestein/components/ocr_dialog.dart';
import 'package:scanestein/constants.dart';
import 'package:scanestein/theme/theme_manager.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

ThemeManager _themeManager = ThemeManager();

class ImageToText extends StatefulWidget {
  const ImageToText({Key? key}) : super(key: key);

  @override
  State<ImageToText> createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {
  bool textScanning = false;

  XFile? imageFile;
  String scannedText = "";

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer(script: TextRecognitionScript.devanagiri);
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + " " + line.text + " ";
      }
    }
    textScanning = false;
    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) => OCRDialog(scannedText: scannedText));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image to Text'),
          backgroundColor: _themeManager.themeMode == ThemeMode.light
              ? Color(0xff1186d9)
              : Color(0xff11d9aa),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(
              () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                getImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              child: Text('Gallery', style: kImagetoTextStyle),
                            ),
                            TextButton(
                              onPressed: () {
                                getImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              child: Text('Camera', style: kImagetoTextStyle),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Icon(Icons.add_a_photo_rounded),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (!textScanning && imageFile == null)
              Center(
                child: Container(
                    width: 400,
                    height: 300,
                    color: Colors.grey,
                    child: Icon(FontAwesomeIcons.images, size: 40)),
              ),
            if (imageFile != null)
              Center(
                child: Container(
                  child: Image.file(
                    File(imageFile!.path),
                    fit: BoxFit.fill,
                  ),
                  height: 300,
                ),
              ),
            if (textScanning)
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: Color(0xff1186d9), size: 50),
              ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 5),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.lightbulb,
                      size: 30,
                      color: Colors.yellow,
                    )),
                    TextSpan(
                        text:
                            'Please turn on internet to extract text other than '
                                'english to avoid errors',
                        style: kImageDetail),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ));
  }
}

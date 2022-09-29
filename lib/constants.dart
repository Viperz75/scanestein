import 'package:flutter/material.dart';
import 'package:scanestein/theme/theme_manager.dart';

ThemeManager _themeManager = ThemeManager();

const kGetUserDataDec = InputDecoration(
  hintText: 'Your text...',
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(100.0),
      ),
      borderSide: BorderSide.none),
  focusColor: Color(0xfff2a618),
);

const kTextFieldText = TextStyle(fontSize: 18.0);

const kButtonText = TextStyle(color: Colors.white, fontSize: 15.0);

const kDownloadButton = TextStyle(
  color: Color(0x9906bd95),
  fontSize: 17.0,
  fontWeight: FontWeight.bold,
);

const kChoiceTextButton = TextStyle(
  color: Color(0xff0072d9),
  fontSize: 19.0,
);

const kHomeButtonTextButton = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kScanTextStyles =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white);

const kScannedStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

const kImagetoTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Color(0x9900ffc8),
);


final kImageDetail = TextStyle(
  fontSize: 18.0,
  color: Color(0xffB8A803)
);


const kBrandName = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold
);

const kName = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold
);
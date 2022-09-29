import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


File? image;
var image_path;
Future pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    print(imageTemp);
    image_path = imageTemp;
    print(image_path);
  } on PlatformException catch (e) {
    print('Failed to pick image: $e');
  }
}